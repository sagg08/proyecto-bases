/**
 * tests/pedidos.test.js · Pruebas de Pedidos, Reportes y banco de consultas (P4).
 *
 * Mismo patrón que tests/clientes.test.js (P1):
 *   - "unitarias": validación de la app (zod) sin tocar MySQL.
 *   - "de integración": la app real (supertest) y los procedimientos (callProc)
 *     contra la base de prueba domicilios_test.
 *
 * Las pruebas leen conteos con pool.query (SELECT directo). Eso está permitido
 * AQUÍ porque la prueba es quien verifica a la app desde afuera; la regla
 * "solo CALL sp_..." aplica al código de la aplicación (app/).
 *
 * Ninguna prueba depende de números fijos de los datos semilla: cada una lee
 * su "antes" y compara contra su "después". Así no se rompen si cambian los
 * datos de prueba o si alguien corre npm run db:perf.
 */
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import request from 'supertest';
import mysql from 'mysql2/promise';
import app from '../app/app.js';
import { callProc, pool } from '../app/db/pool.js';
import { ErrorApp } from '../app/db/errores.js';
import { avanzarEstadoSchema, confirmarPedidoSchema } from '../app/validators/pedido.js';
import { filtrosReporteSchema } from '../app/validators/reporte.js';
import { validar } from '../app/validators/comunes.js';
import { partirInstrucciones } from '../scripts/db-setup.js';

const raiz = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');

afterAll(() => pool.end());

// ---------------------------------------------------------------------
// Ayudas
// ---------------------------------------------------------------------

/** Filas actuales de las tres tablas que toca sp_pedido_crear. */
async function contarTablasPedido() {
  const [[fila]] = await pool.query(`
    SELECT (SELECT COUNT(*) FROM PEDIDO)           AS pedidos,
           (SELECT COUNT(*) FROM DETALLE_PEDIDO)   AS lineas,
           (SELECT COUNT(*) FROM HISTORIAL_ESTADO) AS estados`);
  return fila;
}

/** Datos de apoyo: un cliente, un restaurante con 2 productos disponibles y un producto de OTRO restaurante. */
let cliente;
let restaurante;
let productos;
let productoAjeno;
let repartidor;

beforeAll(async () => {
  [[{ id_cliente: cliente }]] = await pool.query('SELECT id_cliente FROM CLIENTE ORDER BY id_cliente LIMIT 1');
  [[{ id_restaurante: restaurante }]] = await pool.query(`
    SELECT id_restaurante FROM PRODUCTO WHERE disponible = TRUE
     GROUP BY id_restaurante HAVING COUNT(*) >= 2 ORDER BY id_restaurante LIMIT 1`);
  [productos] = await pool.query(
    'SELECT id_producto, precio FROM PRODUCTO WHERE id_restaurante = ? AND disponible = TRUE ORDER BY id_producto LIMIT 2',
    [restaurante],
  );
  [[productoAjeno]] = await pool.query(
    'SELECT id_producto FROM PRODUCTO WHERE id_restaurante <> ? AND disponible = TRUE ORDER BY id_producto LIMIT 1',
    [restaurante],
  );
  [[{ id_repartidor: repartidor }]] = await pool.query('SELECT id_repartidor FROM REPARTIDOR ORDER BY id_repartidor LIMIT 1');
});

/** Crea un pedido válido con el procedimiento y devuelve su id. */
async function crearPedido(detalle = [{ id_producto: productos[0].id_producto, cantidad: 1 }]) {
  const [[fila]] = await callProc('sp_pedido_crear', [
    cliente, restaurante, 'Calle 10', '# 5-23', 'Centro', 'Villavicencio', 4000, 'efectivo', JSON.stringify(detalle),
  ]);
  return fila.id_pedido;
}

// ---------------------------------------------------------------------
// 1. Validación en la app (antes de llegar a MySQL)
// ---------------------------------------------------------------------
describe('Validación de pedidos y reportes (zod, sin base de datos)', () => {
  it('rechaza una dirección incompleta y un método de pago que no existe', () => {
    const { errores } = validar(confirmarPedidoSchema, {
      calle: 'Calle 10', numero: '', barrio: 'Centro', ciudad: 'Villavicencio', metodo_pago: 'bitcoin',
    });
    expect(Object.keys(errores).sort()).toEqual(['metodo_pago', 'numero']);
    expect(errores.metodo_pago).toBe('Selecciona un método de pago.');
  });

  it('avanzar estado: el repartidor vacío se vuelve null y un estado no numérico se rechaza', () => {
    expect(validar(avanzarEstadoSchema, { id_estado: '2', id_repartidor: '' }).datos)
      .toEqual({ id_estado: 2, id_repartidor: null });
    expect(validar(avanzarEstadoSchema, { id_estado: 'abc' }).errores).toHaveProperty('id_estado');
  });

  it('filtros de reportes: vacíos → valores por defecto; fuera de rango → mensaje claro', () => {
    expect(validar(filtrosReporteSchema, {}).datos).toEqual({ limite: 10, min_calificaciones: 3, ciudad: null });
    const { errores } = validar(filtrosReporteSchema, { limite: '500' });
    expect(errores.limite).toBe('El número de restaurantes debe estar entre 1 y 100.');
  });
});

// ---------------------------------------------------------------------
// 2. Transacción 1: sp_pedido_crear (todo o nada)
// ---------------------------------------------------------------------
describe('Crear pedidos contra la base de prueba', () => {
  it('crea un pedido válido desde el flujo Pedir: PEDIDO + líneas + estado "recibido"', async () => {
    const antes = await contarTablasPedido();
    const carrito = {
      id_restaurante: restaurante,
      items: [
        { id_producto: productos[0].id_producto, cantidad: 2 },
        { id_producto: productos[1].id_producto, cantidad: 1 },
      ],
    };

    // El flujo Pedir guarda el cliente y el carrito en cookies (app/lib/carrito.js)
    const res = await request(app)
      .post('/pedir/confirmar')
      .set('Cookie', [`pedir_cliente=${cliente}`, `pedir_carrito=${encodeURIComponent(JSON.stringify(carrito))}`])
      .type('form')
      .send({ calle: 'Carrera 33', numero: '# 15-20', barrio: 'Barzal', ciudad: 'Villavicencio', metodo_pago: 'tarjeta' });

    expect(res.status).toBe(303);
    expect(res.headers.location).toMatch(/^\/pedir\/seguimiento\/\d+\?ok=creado$/);
    const id = Number(res.headers.location.match(/seguimiento\/(\d+)/)[1]);

    const [[pedido], lineas, historial] = await callProc('sp_pedido_obtener', [id]);
    expect(pedido.estado_actual).toBe('recibido');
    expect(historial).toHaveLength(1);
    expect(lineas).toHaveLength(2);
    // El total derivado = líneas (con el precio del momento) + envío fijo de 4.000
    const esperado = productos[0].precio * 2 + productos[1].precio + 4000;
    expect(pedido.total).toBe(esperado);

    const despues = await contarTablasPedido();
    expect(despues).toEqual({ pedidos: antes.pedidos + 1, lineas: antes.lineas + 2, estados: antes.estados + 1 });
  });

  it('producto de otro restaurante → mensaje claro del trigger (no un error genérico)', async () => {
    const intento = callProc('sp_pedido_crear', [
      cliente, restaurante, 'Calle 10', '# 5-23', 'Centro', 'Villavicencio', 4000, 'efectivo',
      JSON.stringify([{ id_producto: productoAjeno.id_producto, cantidad: 1 }]),
    ]);
    await expect(intento).rejects.toBeInstanceOf(ErrorApp);
    await expect(intento).rejects.toMatchObject({
      status: 400,
      message: 'El producto no pertenece al restaurante del pedido.',
    });
  });

  it('ROLLBACK: si falla una línea a mitad de sp_pedido_crear, las tres tablas quedan sin cambios', async () => {
    const antes = await contarTablasPedido();

    // Dentro de la transacción, el INSERT en PEDIDO ya se hizo cuando trg_detalle_bi
    // rechaza la línea ajena. Si no hubiera ROLLBACK quedaría un pedido sin líneas
    // completas y sin historial.
    const intento = callProc('sp_pedido_crear', [
      cliente, restaurante, 'Calle ROLLBACK', '# 0-00', 'Centro', 'Villavicencio', 4000, 'efectivo',
      JSON.stringify([
        { id_producto: productos[0].id_producto, cantidad: 1 },   // válida
        { id_producto: productoAjeno.id_producto, cantidad: 1 },  // de otro restaurante
      ]),
    ]);
    await expect(intento).rejects.toMatchObject({ message: 'El producto no pertenece al restaurante del pedido.' });

    expect(await contarTablasPedido()).toEqual(antes);
    const [huerfanos] = await pool.query("SELECT id_pedido FROM PEDIDO WHERE calle = 'Calle ROLLBACK'");
    expect(huerfanos).toHaveLength(0);
  });
});

// ---------------------------------------------------------------------
// 3. Transacción 2: sp_pedido_avanzar_estado (flujo de estados)
// ---------------------------------------------------------------------
describe('Avanzar estados contra la base de prueba', () => {
  it('transición inválida (recibido → entregado) se rechaza desde el panel y el historial no cambia', async () => {
    const id = await crearPedido();

    const res = await request(app).post(`/pedidos/${id}/avanzar`).type('form').send({ id_estado: '4' });

    expect(res.status).toBe(400);
    expect(res.text).toContain('Transición inválida: los estados avanzan en orden, sin saltos ni retrocesos.');
    const [, , historial] = await callProc('sp_pedido_obtener', [id]);
    expect(historial.map((h) => h.estado)).toEqual(['recibido']);
  });

  it('no deja pasar a "en camino" sin repartidor', async () => {
    const id = await crearPedido();
    await callProc('sp_pedido_avanzar_estado', [id, 2, null, null]);

    await expect(callProc('sp_pedido_avanzar_estado', [id, 3, null, null])).rejects.toMatchObject({
      status: 400,
      message: 'Para pasar a "en camino" el pedido debe tener un repartidor asignado.',
    });
  });

  it('solo se califica un pedido entregado; el flujo completo deja tiempo de entrega y calificación', async () => {
    const id = await crearPedido();

    await expect(callProc('sp_calificar_pedido', [id, 5, 5, null])).rejects.toMatchObject({
      message: 'Solo se pueden calificar pedidos entregados.',
    });

    await callProc('sp_pedido_avanzar_estado', [id, 2, null, null]);
    await callProc('sp_pedido_avanzar_estado', [id, 3, repartidor, 'Sale con el domiciliario']);
    await callProc('sp_pedido_avanzar_estado', [id, 4, null, null]);
    await callProc('sp_calificar_pedido', [id, 4, 5, 'Llegó caliente']);

    const [[pedido], , historial, [calificacion]] = await callProc('sp_pedido_obtener', [id]);
    expect(pedido.estado_actual).toBe('entregado');
    expect(pedido.id_repartidor).toBe(repartidor);
    expect(pedido.tiempo_entrega_minutos).not.toBeNull();
    expect(historial.map((h) => h.secuencia)).toEqual([1, 2, 3, 4]);
    expect(calificacion).toMatchObject({ nota_restaurante: 4, nota_repartidor: 5 });

    // Y no se puede cambiar el estado de un pedido ya entregado
    await expect(callProc('sp_pedido_avanzar_estado', [id, 5, null, null])).rejects.toMatchObject({
      message: 'El pedido ya fue entregado o cancelado; no admite más cambios de estado.',
    });
  });
});

// ---------------------------------------------------------------------
// 4. Vistas y reportes
// ---------------------------------------------------------------------
describe('Vistas y reportes', () => {
  it('vw_pedido_resumen calcula total, estado y tiempo IGUAL que las funciones de P3, para todos los pedidos', async () => {
    // La vista usa JOIN por rendimiento; esta prueba garantiza que no se desvía de la definición oficial.
    // CONVERT(... USING utf8mb4) COLLATE iguala la collation del texto que devuelve la función.
    const [[r]] = await pool.query(`
      SELECT COUNT(*) AS pedidos,
             SUM(v.total <> fn_total_pedido(v.id_pedido))                       AS dif_total,
             SUM(v.estado_actual <> CONVERT(fn_estado_actual(v.id_pedido) USING utf8mb4) COLLATE utf8mb4_0900_ai_ci) AS dif_estado,
             SUM(NOT (v.tiempo_entrega_min <=> fn_tiempo_entrega(v.id_pedido))) AS dif_tiempo
        FROM vw_pedido_resumen v`);
    const [[{ total }]] = await pool.query('SELECT COUNT(*) AS total FROM PEDIDO');

    expect(r.pedidos).toBe(total);                 // ningún pedido se pierde en los JOIN
    expect(Number(r.dif_total)).toBe(0);
    expect(Number(r.dif_estado)).toBe(0);
    expect(Number(r.dif_tiempo)).toBe(0);
  });

  it('los reportes cuadran entre sí: ventas totales = suma por restaurante = suma por mes', async () => {
    const [[resumen]] = await callProc('sp_reporte_resumen');
    const [restaurantes] = await callProc('sp_reporte_restaurantes', [100]);
    const [meses] = await callProc('sp_reporte_ventas_mensuales');

    const sumar = (filas) => filas.reduce((acc, f) => acc + f.ventas, 0);
    expect(resumen.ventas).toBeGreaterThan(0);
    expect(sumar(restaurantes)).toBe(resumen.ventas);
    expect(sumar(meses)).toBe(resumen.ventas);
  });

  it('el ranking de repartidores respeta el mínimo de calificaciones', async () => {
    const [filas] = await callProc('sp_reporte_repartidores', [3, 100]);
    expect(filas.length).toBeGreaterThan(0);
    expect(filas.every((f) => f.num_calificaciones >= 3)).toBe(true);
    await expect(callProc('sp_reporte_repartidores', [0, 10])).rejects.toMatchObject({
      status: 400, message: 'El mínimo de calificaciones debe estar entre 1 y 50.',
    });
  });

  it('la pantalla /reportes muestra las cuatro preguntas de negocio y rechaza filtros manipulados', async () => {
    const ok = await request(app).get('/reportes');
    expect(ok.status).toBe(200);
    for (const pregunta of [
      '¿Qué restaurantes venden más?',
      '¿Qué repartidores están mejor calificados?',
      '¿En qué zonas tardamos más en entregar?',
      '¿Cómo evolucionan las ventas mes a mes?',
    ]) expect(ok.text).toContain(pregunta);

    const mal = await request(app).get('/reportes?limite=500');
    expect(mal.status).toBe(400);
    expect(mal.text).toContain('El número de restaurantes debe estar entre 1 y 100.');
  });
});

// ---------------------------------------------------------------------
// 5. Banco de consultas
// ---------------------------------------------------------------------
describe('Banco de consultas (db/07_consultas.sql)', () => {
  it('las 39 consultas corren sin error y los UPDATE/DELETE se deshacen (datos intactos)', async () => {
    const archivo = fs.readFileSync(path.join(raiz, 'db', '07_consultas.sql'), 'utf8');
    expect(archivo.match(/^-- \d+\.\d /gm)).toHaveLength(39);   // 13 temas × 3 consultas

    // Conexión propia: el archivo usa variables de sesión (@cancelado) y transacciones
    const conexion = await mysql.createConnection({
      host: process.env.DB_HOST ?? '127.0.0.1',
      port: Number(process.env.DB_PORT ?? 3306),
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME,              // domicilios_test (vitest.config.js)
      charset: 'utf8mb4',
    });
    const tablas = 'PRODUCTO, PEDIDO, DETALLE_PEDIDO, HISTORIAL_ESTADO, CALIFICACION, TELEFONO_CLIENTE';
    try {
      const [antes] = await conexion.query(`CHECKSUM TABLE ${tablas}`);
      for (const instruccion of partirInstrucciones(archivo)) {
        if (/^USE\s/i.test(instruccion)) continue;    // ya estamos en la base de prueba
        await conexion.query(instruccion);
      }
      const [despues] = await conexion.query(`CHECKSUM TABLE ${tablas}`);
      expect(despues.map((t) => t.Checksum)).toEqual(antes.map((t) => t.Checksum));
    } finally {
      await conexion.end();
    }
  });
});
