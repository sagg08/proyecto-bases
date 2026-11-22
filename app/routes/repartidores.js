/**
 * app/routes/repartidores.js · CRUD de Repartidores, siguiendo la plantilla de Clientes/Restaurantes.
 * Toda operación de datos se realiza mediante callProc().
 */
import { Router } from 'express';
import { callProc } from '../db/pool.js';
import { ErrorApp } from '../db/errores.js';
import { repartidorSchema } from '../validators/repartidor.js';
import { validar, idSchema } from '../validators/comunes.js';

const router = Router();

const MENSAJES_OK = {
  creado: 'Repartidor creado.',
  actualizado: 'Cambios guardados.',
  eliminado: 'Repartidor eliminado.',
};

function leerId(req) {
  const r = idSchema.safeParse(req.params.id);
  if (!r.success) throw new ErrorApp('El id del repartidor debe ser un número entero positivo.', { status: 404 });
  return r.data;
}

function parametros(d) {
  return [d.documento, d.nombres, d.primer_apellido, d.segundo_apellido, d.telefono, d.tipo_vehiculo, d.placa, d.fecha_ingreso];
}

function mostrarFormulario(res, { repartidor = {}, errores = {}, aviso = null, modo, status = 200 }) {
  res.status(status).render('repartidores/formulario', {
    titulo: modo === 'crear' ? 'Nuevo repartidor' : 'Editar repartidor',
    activo: '/repartidores',
    modo,
    repartidor,
    errores,
    aviso,
  });
}

router.get('/', async (req, res) => {
  const buscar = String(req.query.q ?? '').trim().slice(0, 100);
  const [repartidores] = await callProc('sp_repartidor_listar', [buscar || null]);
  res.render('repartidores/lista', {
    titulo: 'Repartidores',
    activo: '/repartidores',
    repartidores,
    buscar,
    ok: MENSAJES_OK[req.query.ok] ?? null,
  });
});

router.get('/nuevo', (req, res) => mostrarFormulario(res, { modo: 'crear' }));

router.post('/', async (req, res) => {
  const { datos, errores } = validar(repartidorSchema, req.body);
  if (errores) return mostrarFormulario(res, { repartidor: req.body, errores, modo: 'crear', status: 400 });

  try {
    const [[fila]] = await callProc('sp_repartidor_crear', parametros(datos));
    res.redirect(303, `/repartidores/${fila.id_repartidor}?ok=creado`);
  } catch (err) {
    if (!(err instanceof ErrorApp) || err.status >= 500) throw err;
    mostrarFormulario(res, {
      repartidor: req.body, modo: 'crear', status: err.status,
      errores: err.campo ? { [err.campo]: err.message } : {},
      aviso: { titulo: 'No se guardó el repartidor', mensaje: err.message, detalle: err.detalle },
    });
  }
});

async function mostrarDetalle(res, id, { ok = null, aviso = null, status = 200 } = {}) {
  const [[repartidor]] = await callProc('sp_repartidor_obtener', [id]);
  res.status(status).render('repartidores/detalle', {
    titulo: res.locals.fmt.nombre(repartidor),
    activo: '/repartidores',
    repartidor,
    ok,
    aviso,
  });
}

router.get('/:id', async (req, res) => {
  await mostrarDetalle(res, leerId(req), { ok: MENSAJES_OK[req.query.ok] ?? null });
});

router.get('/:id/editar', async (req, res) => {
  const id = leerId(req);
  const [[repartidor]] = await callProc('sp_repartidor_obtener', [id]);
  mostrarFormulario(res, { repartidor, modo: 'editar' });
});

router.post('/:id/editar', async (req, res) => {
  const id = leerId(req);
  const { datos, errores } = validar(repartidorSchema, req.body);
  if (errores) return mostrarFormulario(res, { repartidor: { ...req.body, id_repartidor: id }, errores, modo: 'editar', status: 400 });

  try {
    await callProc('sp_repartidor_actualizar', [id, ...parametros(datos)]);
    res.redirect(303, `/repartidores/${id}?ok=actualizado`);
  } catch (err) {
    if (!(err instanceof ErrorApp) || err.status >= 500 || err.status === 404) throw err;
    mostrarFormulario(res, {
      repartidor: { ...req.body, id_repartidor: id }, modo: 'editar', status: err.status,
      errores: err.campo ? { [err.campo]: err.message } : {},
      aviso: { titulo: 'No se guardaron los cambios', mensaje: err.message, detalle: err.detalle },
    });
  }
});

router.post('/:id/eliminar', async (req, res) => {
  const id = leerId(req);
  try {
    await callProc('sp_repartidor_eliminar', [id]);
    res.redirect(303, '/repartidores?ok=eliminado');
  } catch (err) {
    if (!(err instanceof ErrorApp) || err.status !== 400) throw err;
    await mostrarDetalle(res, id, {
      status: 409,
      aviso: { titulo: 'No se eliminó el repartidor', mensaje: err.message, detalle: err.detalle },
    });
  }
});

export default router;
