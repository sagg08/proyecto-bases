/**
 * app/routes/pedidos.js · Panel de operación de Pedidos (el "lado operación"
 * de la plataforma: pestañas por estado, detalle con riel + comanda y un
 * único botón con la siguiente acción). Toda operación de datos usa callProc().
 */
import { Router } from 'express';
import { callProc } from '../db/pool.js';
import { ErrorApp } from '../db/errores.js';
import { avanzarEstadoSchema } from '../validators/pedido.js';
import { validar, idSchema } from '../validators/comunes.js';
import {
  ESTADOS, FLUJO, SIGUIENTE_ESTADO, ETIQUETA_SIGUIENTE, ESTADO_CANCELADO, PUEDE_CANCELAR, claseEstado,
} from '../lib/estados.js';

const router = Router();

const MENSAJES_OK = {
  avanzado: 'Pedido actualizado.',
  cancelado: 'Pedido cancelado.',
};

function leerId(req) {
  const r = idSchema.safeParse(req.params.id);
  if (!r.success) throw new ErrorApp('El id del pedido debe ser un número entero positivo.', { status: 404 });
  return r.data;
}

router.get('/', async (req, res) => {
  const filtro = req.query.estado !== undefined && req.query.estado !== ''
    ? idSchema.safeParse(req.query.estado)
    : null;
  const idEstado = filtro?.success ? filtro.data : null;
  const [pedidos] = await callProc('sp_pedido_listar', [idEstado]);
  res.render('pedidos/lista', {
    titulo: 'Pedidos',
    activo: '/pedidos',
    pedidos,
    estados: ESTADOS,
    filtroEstado: idEstado,
    claseEstado,
    ok: MENSAJES_OK[req.query.ok] ?? null,
  });
});

async function cargarPedido(id) {
  const [[pedido], lineas, historial, [calificacion]] = await callProc('sp_pedido_obtener', [id]);
  return { pedido, lineas, historial, calificacion };
}

async function mostrarDetalle(res, id, { ok = null, aviso = null, status = 200 } = {}) {
  const { pedido, lineas, historial, calificacion } = await cargarPedido(id);
  const siguiente = SIGUIENTE_ESTADO[pedido.id_estado_actual] ?? null;
  const necesitaRepartidor = siguiente === 3 && !pedido.id_repartidor;
  const repartidores = necesitaRepartidor ? (await callProc('sp_repartidor_listar', [null]))[0] : [];

  res.status(status).render('pedidos/detalle', {
    titulo: `Pedido ${res.locals.fmt.id(pedido.id_pedido)}`,
    activo: '/pedidos',
    pedido,
    lineas,
    historial,
    calificacion,
    claseEstado,
    estados: ESTADOS,
    flujo: FLUJO,
    siguiente,
    etiquetaSiguiente: siguiente ? ETIQUETA_SIGUIENTE[siguiente] : null,
    necesitaRepartidor,
    repartidores,
    puedeCancelar: PUEDE_CANCELAR.has(pedido.id_estado_actual),
    ok,
    aviso,
  });
}

router.get('/:id', async (req, res) => {
  await mostrarDetalle(res, leerId(req), { ok: MENSAJES_OK[req.query.ok] ?? null });
});

// ---------- Avanzar al siguiente estado (asigna repartidor si hace falta) ----------
router.post('/:id/avanzar', async (req, res) => {
  const id = leerId(req);
  const { datos, errores } = validar(avanzarEstadoSchema, req.body);
  if (errores) {
    return mostrarDetalle(res, id, {
      status: 400,
      aviso: { titulo: 'No se pudo avanzar el pedido', mensaje: Object.values(errores)[0] },
    });
  }

  try {
    await callProc('sp_pedido_avanzar_estado', [id, datos.id_estado, datos.id_repartidor, null]);
    res.redirect(303, `/pedidos/${id}?ok=avanzado`);
  } catch (err) {
    if (!(err instanceof ErrorApp) || err.status >= 500) throw err;
    await mostrarDetalle(res, id, {
      status: err.status,
      aviso: { titulo: 'No se pudo avanzar el pedido', mensaje: err.message, detalle: err.detalle },
    });
  }
});

// ---------- Cancelar (solo disponible desde "recibido" o "en preparación") ----------
router.post('/:id/cancelar', async (req, res) => {
  const id = leerId(req);
  try {
    await callProc('sp_pedido_avanzar_estado', [id, ESTADO_CANCELADO, null, null]);
    res.redirect(303, `/pedidos/${id}?ok=cancelado`);
  } catch (err) {
    if (!(err instanceof ErrorApp) || err.status >= 500) throw err;
    await mostrarDetalle(res, id, {
      status: err.status,
      aviso: { titulo: 'No se pudo cancelar el pedido', mensaje: err.message, detalle: err.detalle },
    });
  }
});

export default router;
