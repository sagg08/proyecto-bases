/**
 * app/routes/categorias.js · CRUD de Categorías, siguiendo la plantilla de Clientes.
 * Toda operación de datos se realiza mediante callProc().
 */
import { Router } from 'express';
import { callProc } from '../db/pool.js';
import { ErrorApp } from '../db/errores.js';
import { categoriaSchema } from '../validators/categoria.js';
import { validar, idSchema } from '../validators/comunes.js';

const router = Router();

const MENSAJES_OK = {
  creado: 'Categoría creada.',
  actualizado: 'Cambios guardados.',
  eliminado: 'Categoría eliminada.',
};

function leerId(req) {
  const r = idSchema.safeParse(req.params.id);
  if (!r.success) throw new ErrorApp('El id de la categoría debe ser un número entero positivo.', { status: 404 });
  return r.data;
}

function mostrarFormulario(res, { categoria = {}, errores = {}, aviso = null, modo, status = 200 }) {
  res.status(status).render('categorias/formulario', {
    titulo: modo === 'crear' ? 'Nueva categoría' : 'Editar categoría',
    activo: '/categorias',
    modo,
    categoria,
    errores,
    aviso,
  });
}

router.get('/', async (req, res) => {
  const [categorias] = await callProc('sp_categoria_listar');
  res.render('categorias/lista', {
    titulo: 'Categorías',
    activo: '/categorias',
    categorias,
    ok: MENSAJES_OK[req.query.ok] ?? null,
  });
});

router.get('/nuevo', (req, res) => mostrarFormulario(res, { modo: 'crear' }));

router.post('/', async (req, res) => {
  const { datos, errores } = validar(categoriaSchema, req.body);
  if (errores) return mostrarFormulario(res, { categoria: req.body, errores, modo: 'crear', status: 400 });

  try {
    const [[fila]] = await callProc('sp_categoria_crear', [datos.nombre]);
    res.redirect(303, `/categorias/${fila.id_categoria}?ok=creado`);
  } catch (err) {
    if (!(err instanceof ErrorApp) || err.status >= 500) throw err;
    mostrarFormulario(res, {
      categoria: req.body, modo: 'crear', status: err.status,
      errores: err.campo ? { [err.campo]: err.message } : {},
      aviso: { titulo: 'No se guardó la categoría', mensaje: err.message, detalle: err.detalle },
    });
  }
});

async function mostrarDetalle(res, id, { ok = null, aviso = null, status = 200 } = {}) {
  const [[categoria]] = await callProc('sp_categoria_obtener', [id]);
  res.status(status).render('categorias/detalle', {
    titulo: categoria.nombre,
    activo: '/categorias',
    categoria,
    ok,
    aviso,
  });
}

router.get('/:id', async (req, res) => {
  await mostrarDetalle(res, leerId(req), { ok: MENSAJES_OK[req.query.ok] ?? null });
});

router.get('/:id/editar', async (req, res) => {
  const id = leerId(req);
  const [[categoria]] = await callProc('sp_categoria_obtener', [id]);
  mostrarFormulario(res, { categoria, modo: 'editar' });
});

router.post('/:id/editar', async (req, res) => {
  const id = leerId(req);
  const { datos, errores } = validar(categoriaSchema, req.body);
  if (errores) return mostrarFormulario(res, { categoria: { ...req.body, id_categoria: id }, errores, modo: 'editar', status: 400 });

  try {
    await callProc('sp_categoria_actualizar', [id, datos.nombre]);
    res.redirect(303, `/categorias/${id}?ok=actualizado`);
  } catch (err) {
    if (!(err instanceof ErrorApp) || err.status >= 500 || err.status === 404) throw err;
    mostrarFormulario(res, {
      categoria: { ...req.body, id_categoria: id }, modo: 'editar', status: err.status,
      errores: err.campo ? { [err.campo]: err.message } : {},
      aviso: { titulo: 'No se guardaron los cambios', mensaje: err.message, detalle: err.detalle },
    });
  }
});

router.post('/:id/eliminar', async (req, res) => {
  const id = leerId(req);
  try {
    await callProc('sp_categoria_eliminar', [id]);
    res.redirect(303, '/categorias?ok=eliminado');
  } catch (err) {
    if (!(err instanceof ErrorApp) || err.status !== 400) throw err;
    await mostrarDetalle(res, id, {
      status: 409,
      aviso: { titulo: 'No se eliminó la categoría', mensaje: err.message, detalle: err.detalle },
    });
  }
});

export default router;
