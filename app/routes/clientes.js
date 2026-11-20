/**
 * app/routes/clientes.js · CRUD de Clientes. PLANTILLA para los demás módulos.
 *
 * Flujo de una operación (p. ej. crear):
 *   formulario → POST → validar con zod → si falla, re-mostrar con errores por campo
 *              → callProc('sp_cliente_crear') → si MySQL rechaza (SIGNAL/UNIQUE),
 *                re-mostrar con el mensaje → si todo bien, redirigir con ?ok=creado
 *
 * Patrón POST → redirect → GET: recargar la página no repite el envío.
 * Express 5 pasa solo los errores de funciones async al manejador global.
 */
import { Router } from 'express';
import { callProc } from '../db/pool.js';
import { ErrorApp } from '../db/errores.js';
import { clienteSchema } from '../validators/cliente.js';
import { validar, idSchema, comoArreglo } from '../validators/comunes.js';

const router = Router();

// Mensajes de éxito que llegan por ?ok=... después de redirigir
const MENSAJES_OK = {
  creado: 'Cliente creado.',
  actualizado: 'Cambios guardados.',
  eliminado: 'Cliente eliminado.',
};

/** Lee y valida el :id de la URL; si no es un número, 404 claro. */
function leerId(req) {
  const r = idSchema.safeParse(req.params.id);
  if (!r.success) throw new ErrorApp('El id del cliente debe ser un número entero positivo.', { status: 404 });
  return r.data;
}

/** Convierte los datos validados al orden de parámetros del procedimiento. */
function parametros(d) {
  return [d.nombres, d.primer_apellido, d.segundo_apellido, d.email, d.fecha_nacimiento, JSON.stringify(d.telefonos)];
}

/** Pinta el formulario (crear o editar) con valores, errores y aviso general. */
function mostrarFormulario(res, { cliente = {}, errores = {}, aviso = null, modo, status = 200 }) {
  // Siempre al menos un input de teléfono vacío para escribir
  const telefonos = comoArreglo(cliente.telefonos);
  res.status(status).render('clientes/formulario', {
    titulo: modo === 'crear' ? 'Nuevo cliente' : 'Editar cliente',
    activo: '/clientes',
    modo,
    cliente: { ...cliente, telefonos: telefonos.length ? telefonos : [''] },
    errores,
    aviso,
  });
}

// ---------- Listar ----------
router.get('/', async (req, res) => {
  const buscar = String(req.query.q ?? '').trim().slice(0, 100);
  const [clientes] = await callProc('sp_cliente_listar', [buscar || null]);
  res.render('clientes/lista', {
    titulo: 'Clientes',
    activo: '/clientes',
    clientes,
    buscar,
    ok: MENSAJES_OK[req.query.ok] ?? null,
  });
});

// ---------- Crear ----------
router.get('/nuevo', (req, res) => mostrarFormulario(res, { modo: 'crear' }));

router.post('/', async (req, res) => {
  const { datos, errores } = validar(clienteSchema, req.body);
  if (errores) return mostrarFormulario(res, { cliente: req.body, errores, modo: 'crear', status: 400 });

  try {
    const [[fila]] = await callProc('sp_cliente_crear', parametros(datos));
    res.redirect(303, `/clientes/${fila.id_cliente}?ok=creado`);
  } catch (err) {
    if (!(err instanceof ErrorApp) || err.status >= 500) throw err;   // errores graves → página de error
    mostrarFormulario(res, {
      cliente: req.body, modo: 'crear', status: err.status,
      errores: err.campo ? { [err.campo]: err.message } : {},
      aviso: { titulo: 'No se guardó el cliente', mensaje: err.message, detalle: err.detalle },
    });
  }
});

// ---------- Ver detalle ----------
/** Pinta el detalle de un cliente; "extra" permite añadir un aviso de error. */
async function mostrarDetalle(res, id, { ok = null, aviso = null, status = 200 } = {}) {
  const [[cliente], telefonos] = await callProc('sp_cliente_obtener', [id]);
  res.status(status).render('clientes/detalle', {
    titulo: res.locals.fmt.nombre(cliente),
    activo: '/clientes',
    cliente,
    telefonos: telefonos.map((t) => t.telefono),
    ok,
    aviso,
  });
}

router.get('/:id', async (req, res) => {
  await mostrarDetalle(res, leerId(req), { ok: MENSAJES_OK[req.query.ok] ?? null });
});

// ---------- Editar ----------
router.get('/:id/editar', async (req, res) => {
  const id = leerId(req);
  const [[cliente], telefonos] = await callProc('sp_cliente_obtener', [id]);
  mostrarFormulario(res, { cliente: { ...cliente, telefonos: telefonos.map((t) => t.telefono) }, modo: 'editar' });
});

router.post('/:id/editar', async (req, res) => {
  const id = leerId(req);
  const { datos, errores } = validar(clienteSchema, req.body);
  if (errores) return mostrarFormulario(res, { cliente: { ...req.body, id_cliente: id }, errores, modo: 'editar', status: 400 });

  try {
    await callProc('sp_cliente_actualizar', [id, ...parametros(datos)]);
    res.redirect(303, `/clientes/${id}?ok=actualizado`);
  } catch (err) {
    if (!(err instanceof ErrorApp) || err.status >= 500 || err.status === 404) throw err;
    mostrarFormulario(res, {
      cliente: { ...req.body, id_cliente: id }, modo: 'editar', status: err.status,
      errores: err.campo ? { [err.campo]: err.message } : {},
      aviso: { titulo: 'No se guardaron los cambios', mensaje: err.message, detalle: err.detalle },
    });
  }
});

// ---------- Eliminar ----------
router.post('/:id/eliminar', async (req, res) => {
  const id = leerId(req);
  try {
    await callProc('sp_cliente_eliminar', [id]);
    res.redirect(303, '/clientes?ok=eliminado');
  } catch (err) {
    if (!(err instanceof ErrorApp) || err.status !== 400) throw err;
    // Regla de negocio (p. ej. tiene pedidos): mostrar el detalle explicando por qué
    await mostrarDetalle(res, id, {
      status: 409,
      aviso: { titulo: 'No se eliminó el cliente', mensaje: err.message, detalle: err.detalle },
    });
  }
});

export default router;
