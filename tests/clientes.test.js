/**
 * tests/clientes.test.js · Pruebas del módulo Clientes.
 *
 * Patrón para los demás módulos (P4 agrega las de pedidos aquí al lado):
 *   - "unitarias": prueban la validación de la app sin tocar MySQL.
 *   - "de integración": llaman la app real (supertest) o los procedimientos
 *     (callProc) contra la base de prueba domicilios_test.
 */
import { describe, it, expect, afterAll } from 'vitest';
import request from 'supertest';
import app from '../app/app.js';
import { callProc, pool } from '../app/db/pool.js';
import { ErrorApp } from '../app/db/errores.js';
import { clienteSchema } from '../app/validators/cliente.js';
import { validar } from '../app/validators/comunes.js';

// Al terminar, cerrar las conexiones para que el proceso no quede colgado
afterAll(() => pool.end());

/** Busca clientes por correo usando el mismo procedimiento que usa la app. */
async function buscarPorCorreo(email) {
  const [filas] = await callProc('sp_cliente_listar', [email]);
  return filas.filter((c) => c.email === email);
}

/** Datos válidos de base; cada prueba cambia lo que necesite. */
const valido = {
  nombres: 'Prueba',
  primer_apellido: 'Automática',
  segundo_apellido: '',
  email: 'prueba@test.co',
  fecha_nacimiento: '2000-01-01',
  telefonos: ['3001234567'],
};

// ---------------------------------------------------------------------
// 1. Validación en la app (antes de llegar a MySQL)
// ---------------------------------------------------------------------
describe('Validación de clientes (zod, sin base de datos)', () => {
  it('rechaza datos inválidos con un mensaje por campo', () => {
    const { errores } = validar(clienteSchema, {
      nombres: 'J4n',                 // números en el nombre
      primer_apellido: '',            // obligatorio vacío
      email: 'no-es-correo',
      fecha_nacimiento: '2020-01-01', // menor de 14 años
      telefonos: ['123'],             // muy corto
    });
    expect(Object.keys(errores).sort()).toEqual(
      ['email', 'fecha_nacimiento', 'nombres', 'primer_apellido', 'telefonos'],
    );
    expect(errores.fecha_nacimiento).toMatch(/al menos 14 años/);
  });

  it('normaliza los datos válidos: correo en minúscula, segundo apellido vacío → null, teléfonos sin repetidos', () => {
    const { datos, errores } = validar(clienteSchema, {
      ...valido,
      email: '  Ana@Correo.CO ',
      telefonos: ['310 222 3344', '3102223344', ''],
    });
    expect(errores).toBeNull();
    expect(datos.email).toBe('ana@correo.co');
    expect(datos.segundo_apellido).toBeNull();
    expect(datos.telefonos).toEqual(['3102223344']);
  });
});

// ---------------------------------------------------------------------
// 2. Integración: app + procedimientos + MySQL
// ---------------------------------------------------------------------
describe('Clientes contra la base de prueba', () => {
  it('crea un cliente desde el formulario y queda guardado con sus teléfonos', async () => {
    const res = await request(app)
      .post('/clientes')
      .type('form')
      .send({ ...valido, email: 'nuevo@test.co', telefonos: ['3001112233', '3154445566'] });

    expect(res.status).toBe(303);                           // redirige al detalle
    expect(res.headers.location).toMatch(/^\/clientes\/\d+\?ok=creado$/);

    const [cliente] = await buscarPorCorreo('nuevo@test.co');
    const [, telefonos] = await callProc('sp_cliente_obtener', [cliente.id_cliente]);
    expect(telefonos.map((t) => t.telefono).sort()).toEqual(['3001112233', '3154445566']);
  });

  it('muestra el mensaje de MySQL (SIGNAL) cuando el correo ya existe', async () => {
    await callProc('sp_cliente_crear', ['Uno', 'Repetido', null, 'repetido@test.co', '1990-05-05', '["3009998877"]']);

    const res = await request(app)
      .post('/clientes')
      .type('form')
      .send({ ...valido, email: 'repetido@test.co' });

    expect(res.status).toBe(400);
    expect(res.text).toContain('Ya existe un cliente con el correo repetido@test.co.');
  });

  it('ROLLBACK: si falla un teléfono, el cliente tampoco se guarda (todo o nada)', async () => {
    const correo = 'rollback@test.co';
    const antes = await buscarPorCorreo(correo);

    // El mismo teléfono dos veces viola la PK de TELEFONO_CLIENTE en el SEGUNDO insert,
    // DESPUÉS de que el INSERT en CLIENTE ya se hizo dentro de la transacción.
    const intento = callProc('sp_cliente_crear', ['Ana', 'Rollback', null, correo, '1995-03-03', '["3101234567","3101234567"]']);

    await expect(intento).rejects.toBeInstanceOf(ErrorApp);
    await expect(intento).rejects.toMatchObject({ status: 409, campo: 'telefonos' });

    const despues = await buscarPorCorreo(correo);
    expect(antes).toHaveLength(0);
    expect(despues).toHaveLength(0);                         // el ROLLBACK deshizo el INSERT del cliente
  });

  it('responde 404 con mensaje claro si el cliente no existe', async () => {
    const res = await request(app).get('/clientes/999999');
    expect(res.status).toBe(404);
    expect(res.text).toContain('No existe un cliente con id 999999.');
  });
});
