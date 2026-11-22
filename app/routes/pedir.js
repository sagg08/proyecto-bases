/**
 * app/routes/pedir.js · Flujo "Pedir" (cara cliente, tipo Rappi, sección 4 del plan).
 *
 * ¿Quién pide? → Restaurantes → Menú (reutiliza partials/menu y sp_producto_menu
 * de P2) → Carrito → Confirmar → Seguimiento → Calificar.
 *
 * No hay login real: "¿Quién pide?" guarda el id_cliente elegido en una cookie
 * (app/lib/carrito.js). El carrito vive en otra cookie y solo admite productos
 * de UN restaurante (regla del caso): si se intenta mezclar, se pide confirmar.
 * Toda operación de datos usa callProc(); el carrito en sí no toca la BD hasta
 * que se confirma el pedido (sp_pedido_crear).
 */
import { Router } from 'express';
import { callProc } from '../db/pool.js';
import { ErrorApp } from '../db/errores.js';
import { confirmarPedidoSchema, calificarSchema } from '../validators/pedido.js';
import { validar, idSchema } from '../validators/comunes.js';
import {
  leerClienteElegido, fijarClienteElegido, olvidarClienteElegido,
  leerCarrito, guardarCarrito, vaciarCarrito, esOtroRestaurante,
  agregarAlCarrito, actualizarCantidad,
} from '../lib/carrito.js';
import { ESTADOS, FLUJO, claseEstado } from '../lib/estados.js';

const router = Router();

// Supuesto 10: costo de envío fijo (el caso no exige calcularlo por distancia).
const COSTO_ENVIO_FIJO = 4000;

function leerId(req, nombre = 'id') {
  const r = idSchema.safeParse(req.params[nombre]);
  if (!r.success) throw new ErrorApp('El id indicado no es válido.', { status: 404 });
  return r.data;
}

/** Arma las líneas del carrito con nombre/precio actuales; descarta las que ya no existen. */
async function detalleCarrito(carrito) {
  if (!carrito.id_restaurante || carrito.items.length === 0) {
    return { restaurante: null, lineas: [], subtotal: 0 };
  }
  try {
    const [[restaurante]] = await callProc('sp_restaurante_obtener', [carrito.id_restaurante]);
    const [productos] = await callProc('sp_producto_listar', [null, carrito.id_restaurante, null]);
    const porId = new Map(productos.map((p) => [p.id_producto, p]));
    const lineas = carrito.items
      .map((item) => {
        const producto = porId.get(item.id_producto);
        if (!producto) return null;   // el producto se borró o desactivó: no se muestra
        return {
          id_producto: item.id_producto,
          cantidad: item.cantidad,
          nombre: producto.nombre,
          precio: producto.precio,
          disponible: Boolean(producto.disponible),
          subtotal: producto.precio * item.cantidad,
        };
      })
      .filter(Boolean);
    return { restaurante, lineas, subtotal: lineas.reduce((acc, l) => acc + l.subtotal, 0) };
  } catch (err) {
    if (err instanceof ErrorApp && err.status === 404) return { restaurante: null, lineas: [], subtotal: 0 };
    throw err;
  }
}

function contarUnidades(carrito) {
  return carrito.items.reduce((acc, i) => acc + i.cantidad, 0);
}

// ---------- ¿Quién pide? ----------
router.get('/', async (req, res) => {
  if (leerClienteElegido(req)) return res.redirect('/pedir/restaurantes');

  const buscar = String(req.query.q ?? '').trim().slice(0, 100);
  const [clientes] = await callProc('sp_cliente_listar', [buscar || null]);
  res.render('pedir/quien', { titulo: 'Pedir a domicilio', activo: '/pedir', clientes, buscar });
});

router.post('/quien', async (req, res) => {
  const r = idSchema.safeParse(req.body.id_cliente);
  if (!r.success) {
    const [clientes] = await callProc('sp_cliente_listar', [null]);
    return res.status(400).render('pedir/quien', {
      titulo: 'Pedir a domicilio', activo: '/pedir', clientes, buscar: '',
      aviso: { titulo: 'Elige un cliente', mensaje: 'Selecciona con quién vas a pedir.' },
    });
  }
  await callProc('sp_cliente_obtener', [r.data]);   // 404 claro si el id no existe
  fijarClienteElegido(res, r.data);
  res.redirect(303, '/pedir/restaurantes');
});

router.post('/salir', (req, res) => {
  olvidarClienteElegido(res);
  vaciarCarrito(res);
  res.redirect(303, '/pedir');
});

/** Exige que ya se haya elegido cliente; si no, manda al selector. */
function exigirCliente(req, res) {
  const id = leerClienteElegido(req);
  if (!id) { res.redirect('/pedir'); return null; }
  return id;
}

// ---------- Restaurantes ----------
router.get('/restaurantes', async (req, res) => {
  const idCliente = exigirCliente(req, res);
  if (!idCliente) return;

  const buscar = String(req.query.q ?? '').trim().slice(0, 100);
  const [restaurantes] = await callProc('sp_restaurante_listar', [buscar || null]);
  const carrito = leerCarrito(req);
  res.render('pedir/restaurantes', {
    titulo: 'Pedir a domicilio', activo: '/pedir', restaurantes, buscar,
    numUnidadesCarrito: contarUnidades(carrito),
  });
});

// ---------- Menú de un restaurante ----------
router.get('/restaurantes/:id', async (req, res) => {
  const idCliente = exigirCliente(req, res);
  if (!idCliente) return;
  const id = leerId(req);

  const [[restaurante], productos, componentes] = await callProc('sp_producto_menu', [id]);
  const carrito = leerCarrito(req);
  res.render('pedir/menu', {
    titulo: restaurante.nombre, activo: '/pedir',
    restaurante, productos, componentes,
    accionAgregar: `/pedir/restaurantes/${id}/agregar`,
    avisoOtroRestaurante: esOtroRestaurante(carrito, id),
    numUnidadesCarrito: contarUnidades(carrito),
  });
});

async function agregarProducto(req, res, { forzar }) {
  const idCliente = exigirCliente(req, res);
  if (!idCliente) return;
  const idRestaurante = leerId(req);
  const r = idSchema.safeParse(req.body.id_producto);
  if (!r.success) throw new ErrorApp('El producto indicado no es válido.', { status: 400 });

  const [[producto]] = await callProc('sp_producto_obtener', [r.data]);
  if (producto.id_restaurante !== idRestaurante) {
    throw new ErrorApp('Ese producto no pertenece a este restaurante.', { status: 400 });
  }
  if (!producto.disponible) {
    throw new ErrorApp('Ese producto ya no está disponible.', { status: 400 });
  }

  const carrito = leerCarrito(req);
  if (!forzar && esOtroRestaurante(carrito, idRestaurante)) {
    return res.redirect(303, `/pedir/restaurantes/${idRestaurante}/cambiar-carrito?id_producto=${r.data}`);
  }

  guardarCarrito(res, agregarAlCarrito(carrito, idRestaurante, r.data));
  res.redirect(303, `/pedir/restaurantes/${idRestaurante}`);
}

router.post('/restaurantes/:id/agregar', (req, res) => agregarProducto(req, res, { forzar: false }));
router.post('/restaurantes/:id/agregar-confirmado', (req, res) => agregarProducto(req, res, { forzar: true }));

// Aviso de "tu carrito tiene productos de otro restaurante" antes de vaciarlo.
router.get('/restaurantes/:id/cambiar-carrito', async (req, res) => {
  const idCliente = exigirCliente(req, res);
  if (!idCliente) return;
  const id = leerId(req);
  const idProducto = idSchema.safeParse(req.query.id_producto);
  if (!idProducto.success) throw new ErrorApp('El producto indicado no es válido.', { status: 400 });

  const carrito = leerCarrito(req);
  const { restaurante: restauranteActual } = await detalleCarrito(carrito);
  const [[restaurante]] = await callProc('sp_restaurante_obtener', [id]);
  res.render('pedir/cambiar-carrito', {
    titulo: 'Cambiar de restaurante', activo: '/pedir',
    restauranteActual, restaurante, idProducto: idProducto.data,
  });
});

// ---------- Carrito ----------
router.get('/carrito', async (req, res) => {
  const idCliente = exigirCliente(req, res);
  if (!idCliente) return;

  const carrito = leerCarrito(req);
  const { restaurante, lineas, subtotal } = await detalleCarrito(carrito);
  res.render('pedir/carrito', {
    titulo: 'Tu carrito', activo: '/pedir',
    restaurante, lineas, subtotal, costoEnvio: COSTO_ENVIO_FIJO,
    numUnidadesCarrito: contarUnidades(carrito),
  });
});

router.post('/carrito/:id/sumar', (req, res) => {
  const idCliente = exigirCliente(req, res);
  if (!idCliente) return;
  const idProducto = leerId(req);
  const carrito = leerCarrito(req);
  const actual = carrito.items.find((i) => i.id_producto === idProducto)?.cantidad ?? 0;
  guardarCarrito(res, actualizarCantidad(carrito, idProducto, Math.min(actual + 1, 20)));
  res.redirect(303, '/pedir/carrito');
});

router.post('/carrito/:id/restar', (req, res) => {
  const idCliente = exigirCliente(req, res);
  if (!idCliente) return;
  const idProducto = leerId(req);
  const carrito = leerCarrito(req);
  const actual = carrito.items.find((i) => i.id_producto === idProducto)?.cantidad ?? 0;
  guardarCarrito(res, actualizarCantidad(carrito, idProducto, actual - 1));
  res.redirect(303, '/pedir/carrito');
});

router.post('/carrito/:id/quitar', (req, res) => {
  const idCliente = exigirCliente(req, res);
  if (!idCliente) return;
  const idProducto = leerId(req);
  guardarCarrito(res, actualizarCantidad(leerCarrito(req), idProducto, 0));
  res.redirect(303, '/pedir/carrito');
});

// ---------- Confirmar (dirección + método de pago) ----------
function mostrarConfirmar(res, { pedido = {}, errores = {}, aviso = null, restaurante, lineas, subtotal, status = 200 }) {
  res.status(status).render('pedir/confirmar', {
    titulo: 'Confirmar pedido', activo: '/pedir',
    pedido, errores, aviso, restaurante, lineas, subtotal, costoEnvio: COSTO_ENVIO_FIJO,
  });
}

router.get('/confirmar', async (req, res) => {
  const idCliente = exigirCliente(req, res);
  if (!idCliente) return;

  const carrito = leerCarrito(req);
  const { restaurante, lineas, subtotal } = await detalleCarrito(carrito);
  if (!restaurante || lineas.length === 0) return res.redirect('/pedir/restaurantes');
  mostrarConfirmar(res, { restaurante, lineas, subtotal });
});

router.post('/confirmar', async (req, res) => {
  const idCliente = exigirCliente(req, res);
  if (!idCliente) return;

  const carrito = leerCarrito(req);
  const { restaurante, lineas, subtotal } = await detalleCarrito(carrito);
  if (!restaurante || lineas.length === 0) return res.redirect('/pedir/restaurantes');

  const { datos, errores } = validar(confirmarPedidoSchema, req.body);
  if (errores) return mostrarConfirmar(res, { pedido: req.body, errores, restaurante, lineas, subtotal, status: 400 });

  const detalle = lineas.map((l) => ({ id_producto: l.id_producto, cantidad: l.cantidad }));
  try {
    const [[fila]] = await callProc('sp_pedido_crear', [
      idCliente, restaurante.id_restaurante,
      datos.calle, datos.numero, datos.barrio, datos.ciudad,
      COSTO_ENVIO_FIJO, datos.metodo_pago,
      JSON.stringify(detalle),
    ]);
    vaciarCarrito(res);
    res.redirect(303, `/pedir/seguimiento/${fila.id_pedido}?ok=creado`);
  } catch (err) {
    if (!(err instanceof ErrorApp) || err.status >= 500) throw err;
    mostrarConfirmar(res, {
      pedido: req.body, restaurante, lineas, subtotal, status: err.status,
      aviso: { titulo: 'No se pudo crear el pedido', mensaje: err.message, detalle: err.detalle },
    });
  }
});

// ---------- Seguimiento ----------
router.get('/seguimiento/:id', async (req, res) => {
  const idCliente = exigirCliente(req, res);
  if (!idCliente) return;
  const id = leerId(req);

  const [[pedido], lineas, historial, [calificacion]] = await callProc('sp_pedido_obtener', [id]);
  res.render('pedir/seguimiento', {
    titulo: `Pedido ${res.locals.fmt.id(pedido.id_pedido)}`, activo: '/pedir',
    pedido, lineas, historial, calificacion, claseEstado, estados: ESTADOS, flujo: FLUJO,
    ok: req.query.ok === 'creado' ? 'Pedido enviado. Puedes seguirlo aquí.'
      : req.query.ok === 'calificado' ? '¡Gracias por tu calificación!'
      : null,
  });
});

// ---------- Calificar ----------
router.get('/seguimiento/:id/calificar', async (req, res) => {
  const idCliente = exigirCliente(req, res);
  if (!idCliente) return;
  const id = leerId(req);

  const [[pedido], , , [calificacion]] = await callProc('sp_pedido_obtener', [id]);
  if (pedido.estado_actual !== 'entregado') return res.redirect(`/pedir/seguimiento/${id}`);
  if (calificacion) return res.redirect(`/pedir/seguimiento/${id}`);

  res.render('pedir/calificar', { titulo: 'Calificar pedido', activo: '/pedir', pedido, errores: {}, aviso: null });
});

router.post('/seguimiento/:id/calificar', async (req, res) => {
  const idCliente = exigirCliente(req, res);
  if (!idCliente) return;
  const id = leerId(req);

  const { datos, errores } = validar(calificarSchema, req.body);
  if (errores) {
    const [[pedido]] = await callProc('sp_pedido_obtener', [id]);
    return res.status(400).render('pedir/calificar', { titulo: 'Calificar pedido', activo: '/pedir', pedido, errores, aviso: null });
  }

  try {
    await callProc('sp_calificar_pedido', [id, datos.nota_restaurante, datos.nota_repartidor, datos.comentario]);
    res.redirect(303, `/pedir/seguimiento/${id}?ok=calificado`);
  } catch (err) {
    if (!(err instanceof ErrorApp) || err.status >= 500) throw err;
    const [[pedido]] = await callProc('sp_pedido_obtener', [id]);
    res.status(err.status).render('pedir/calificar', {
      titulo: 'Calificar pedido', activo: '/pedir', pedido, errores: {},
      aviso: { titulo: 'No se guardó la calificación', mensaje: err.message, detalle: err.detalle },
    });
  }
});

export default router;
