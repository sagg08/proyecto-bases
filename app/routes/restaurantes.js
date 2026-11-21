/**
 * app/routes/restaurantes.js · CRUD de Restaurantes, siguiendo la plantilla de Clientes.
 * Toda operación de datos se realiza mediante callProc().
 */
import { Router } from 'express';
import { callProc } from '../db/pool.js';
import { ErrorApp } from '../db/errores.js';
import { restauranteSchema } from '../validators/restaurante.js';
import { validar, idSchema } from '../validators/comunes.js';

const router = Router();

const MENSAJES_OK = {
  creado: 'Restaurante creado.',
  actualizado: 'Cambios guardados.',
  eliminado: 'Restaurante eliminado.',
};

function leerId(req) {
  const r = idSchema.safeParse(req.params.id);
  if (!r.success) throw new ErrorApp('El id del restaurante debe ser un número entero positivo.', { status: 404 });
  return r.data;
}

function parametros(d) {
  return [d.nit, d.nombre, d.direccion, d.telefono, d.fecha_afiliacion];
}

function mostrarFormulario(res, { restaurante = {}, errores = {}, aviso = null, modo, status = 200 }) {
  res.status(status).render('restaurantes/formulario', {
    titulo: modo === 'crear' ? 'Nuevo restaurante' : 'Editar restaurante',
    activo: '/restaurantes',
    modo,
    restaurante,
    errores,
    aviso,
  });
}

router.get('/', async (req, res) => {
  const buscar = String(req.query.q ?? '').trim().slice(0, 100);
  const [restaurantes] = await callProc('sp_restaurante_listar', [buscar || null]);
  res.render('restaurantes/lista', {
    titulo: 'Restaurantes',
    activo: '/restaurantes',
    restaurantes,
    buscar,
    ok: MENSAJES_OK[req.query.ok] ?? null,
  });
});

router.get('/nuevo', (req, res) => mostrarFormulario(res, { modo: 'crear' }));

router.post('/', async (req, res) => {
  const { datos, errores } = validar(restauranteSchema, req.body);
  if (errores) return mostrarFormulario(res, { restaurante: req.body, errores, modo: 'crear', status: 400 });

  try {
    const [[fila]] = await callProc('sp_restaurante_crear', parametros(datos));
    res.redirect(303, `/restaurantes/${fila.id_restaurante}?ok=creado`);
  } catch (err) {
    if (!(err instanceof ErrorApp) || err.status >= 500) throw err;
    mostrarFormulario(res, {
      restaurante: req.body, modo: 'crear', status: err.status,
      errores: err.campo ? { [err.campo]: err.message } : {},
      aviso: { titulo: 'No se guardó el restaurante', mensaje: err.message, detalle: err.detalle },
    });
  }
});

async function mostrarDetalle(res, id, { ok = null, aviso = null, status = 200 } = {}) {
  const [[restaurante], productos, componentes] = await callProc('sp_producto_menu', [id]);
  res.status(status).render('restaurantes/detalle', {
    titulo: restaurante.nombre,
    activo: '/restaurantes',
    restaurante,
    productos,
    componentes,
    ok,
    aviso,
  });
}

router.get('/:id', async (req, res) => {
  await mostrarDetalle(res, leerId(req), { ok: MENSAJES_OK[req.query.ok] ?? null });
});

router.get('/:id/editar', async (req, res) => {
  const id = leerId(req);
  const [[restaurante]] = await callProc('sp_restaurante_obtener', [id]);
  mostrarFormulario(res, { restaurante, modo: 'editar' });
});

router.post('/:id/editar', async (req, res) => {
  const id = leerId(req);
  const { datos, errores } = validar(restauranteSchema, req.body);
  if (errores) return mostrarFormulario(res, { restaurante: { ...req.body, id_restaurante: id }, errores, modo: 'editar', status: 400 });

  try {
    await callProc('sp_restaurante_actualizar', [id, ...parametros(datos)]);
    res.redirect(303, `/restaurantes/${id}?ok=actualizado`);
  } catch (err) {
    if (!(err instanceof ErrorApp) || err.status >= 500 || err.status === 404) throw err;
    mostrarFormulario(res, {
      restaurante: { ...req.body, id_restaurante: id }, modo: 'editar', status: err.status,
      errores: err.campo ? { [err.campo]: err.message } : {},
      aviso: { titulo: 'No se guardaron los cambios', mensaje: err.message, detalle: err.detalle },
    });
  }
});

router.post('/:id/eliminar', async (req, res) => {
  const id = leerId(req);
  try {
    await callProc('sp_restaurante_eliminar', [id]);
    res.redirect(303, '/restaurantes?ok=eliminado');
  } catch (err) {
    if (!(err instanceof ErrorApp) || err.status !== 400) throw err;
    await mostrarDetalle(res, id, {
      status: 409,
      aviso: { titulo: 'No se eliminó el restaurante', mensaje: err.message, detalle: err.detalle },
    });
  }
});

export default router;
