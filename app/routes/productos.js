/**
 * app/routes/productos.js · Productos y Combos. Toda operación de datos usa callProc().
 */
import { Router } from 'express';
import { callProc } from '../db/pool.js';
import { ErrorApp } from '../db/errores.js';
import { comboSchema, productoSchema } from '../validators/producto.js';
import { comoArreglo, idSchema, validar } from '../validators/comunes.js';

const router = Router();

const MENSAJES_OK = {
  creado: 'Producto creado.',
  actualizado: 'Cambios guardados.',
  disponibilidad: 'Disponibilidad actualizada.',
  componentes: 'Componentes del combo actualizados.',
};

function leerId(req) {
  const resultado = idSchema.safeParse(req.params.id);
  if (!resultado.success) throw new ErrorApp('El id del producto debe ser un número entero positivo.', { status: 404 });
  return resultado.data;
}

function leerFiltro(valor, etiqueta) {
  if (valor === undefined || valor === '') return null;
  if (typeof valor !== 'string') throw new ErrorApp(`El filtro de ${etiqueta} debe ser un id válido.`, { status: 400 });
  const resultado = idSchema.safeParse(valor);
  if (!resultado.success) throw new ErrorApp(`El filtro de ${etiqueta} debe ser un id válido.`, { status: 400 });
  return resultado.data;
}

async function listasCatalogo() {
  const [[restaurantes], [categorias]] = await Promise.all([
    callProc('sp_restaurante_listar', [null]),
    callProc('sp_categoria_listar'),
  ]);
  return { restaurantes, categorias };
}

function parametrosProducto(datos) {
  return [datos.id_restaurante, datos.id_categoria, datos.nombre, datos.descripcion, datos.precio];
}

async function mostrarFormulario(res, {
  producto = {}, errores = {}, aviso = null, modo, restauranteFijo = false, status = 200,
}) {
  const { restaurantes, categorias } = await listasCatalogo();
  return res.status(status).render('productos/formulario', {
    titulo: modo === 'crear' ? 'Nuevo producto' : 'Editar producto',
    activo: '/productos',
    modo,
    producto,
    restauranteFijo,
    restaurantes,
    categorias,
    errores,
    aviso,
  });
}

function avisoEliminacion(query) {
  if (!['eliminado', 'desactivado'].includes(query.accion) || typeof query.mensaje !== 'string') return null;
  return {
    tipo: query.accion === 'eliminado' ? 'ok' : 'info',
    titulo: query.accion === 'eliminado' ? 'Producto eliminado' : 'Producto desactivado',
    mensaje: query.mensaje,
  };
}

router.get('/', async (req, res) => {
  const buscar = String(req.query.q ?? '').trim().slice(0, 100);
  const idRestaurante = leerFiltro(req.query.restaurante, 'restaurante');
  const idCategoria = leerFiltro(req.query.categoria, 'categoría');
  const [[productos], { restaurantes, categorias }] = await Promise.all([
    callProc('sp_producto_listar', [buscar || null, idRestaurante, idCategoria]),
    listasCatalogo(),
  ]);
  res.render('productos/lista', {
    titulo: 'Productos y combos',
    activo: '/productos',
    productos,
    restaurantes,
    categorias,
    buscar,
    filtroRestaurante: idRestaurante,
    filtroCategoria: idCategoria,
    ok: MENSAJES_OK[req.query.ok] ?? null,
    aviso: avisoEliminacion(req.query),
  });
});

router.get('/nuevo', (req, res) => mostrarFormulario(res, { modo: 'crear' }));

router.post('/', async (req, res) => {
  const { datos, errores } = validar(productoSchema, req.body);
  if (errores) return mostrarFormulario(res, { producto: req.body, errores, modo: 'crear', status: 400 });

  try {
    const [[fila]] = await callProc('sp_producto_crear', parametrosProducto(datos));
    res.redirect(303, `/productos/${fila.id_producto}?ok=creado`);
  } catch (err) {
    if (!(err instanceof ErrorApp) || err.status >= 500) throw err;
    mostrarFormulario(res, {
      producto: req.body, modo: 'crear', status: err.status,
      errores: err.campo ? { [err.campo]: err.message } : {},
      aviso: { titulo: 'No se guardó el producto', mensaje: err.message, detalle: err.detalle },
    });
  }
});

async function cargarProducto(id) {
  const [[producto], componentes, combos] = await callProc('sp_producto_obtener', [id]);
  return { producto, componentes, combos };
}

async function mostrarDetalle(res, id, { ok = null, aviso = null, status = 200 } = {}) {
  const { producto, componentes, combos } = await cargarProducto(id);
  res.status(status).render('productos/detalle', {
    titulo: producto.nombre,
    activo: '/productos',
    producto,
    componentes,
    combos,
    ok,
    aviso,
  });
}

router.get('/combo/nuevo', async (req, res) => {
  const { restaurantes, categorias } = await listasCatalogo();
  if (req.query.restaurante === undefined || req.query.restaurante === '') {
    return res.render('productos/combo-formulario', {
      titulo: 'Nuevo combo',
      activo: '/productos',
      restaurantes,
      categorias,
      restaurante: null,
      productos: [],
      producto: {},
      errores: {},
      aviso: null,
      seleccionados: {},
      cantidades: {},
    });
  }

  const resultado = typeof req.query.restaurante === 'string'
    ? idSchema.safeParse(req.query.restaurante)
    : { success: false };
  if (!resultado.success) {
    return res.status(400).render('productos/combo-formulario', {
      titulo: 'Nuevo combo',
      activo: '/productos',
      restaurantes,
      categorias,
      restaurante: null,
      productos: [],
      producto: {},
      errores: { restaurante: 'Selecciona un restaurante válido.' },
      aviso: null,
      seleccionados: {},
      cantidades: {},
    });
  }

  const [[[restaurante]], [todos]] = await Promise.all([
    callProc('sp_restaurante_obtener', [resultado.data]),
    callProc('sp_producto_listar', [null, resultado.data, null]),
  ]);
  res.render('productos/combo-formulario', {
    titulo: 'Nuevo combo',
    activo: '/productos',
    restaurantes,
    categorias,
    restaurante,
    productos: todos.filter((p) => !Boolean(p.es_combo)),
    producto: { id_restaurante: restaurante.id_restaurante },
    errores: {},
    aviso: null,
    seleccionados: {},
    cantidades: {},
  });
});

function leerComponentes(body) {
  const ids = comoArreglo(body.componente);
  const seleccionados = Object.create(null);
  const cantidades = Object.create(null);
  const componentes = ids.map((id) => {
    seleccionados[id] = true;
    cantidades[id] = String(body[`cantidad_${id}`] ?? '');
    return { id_producto: id, cantidad: cantidades[id] };
  });
  return { componentes, seleccionados, cantidades };
}

async function mostrarFormularioCombo(res, {
  restaurante, restaurantes, categorias, productos, producto = {}, errores = {}, aviso = null,
  seleccionados = {}, cantidades = {}, status = 200,
}) {
  return res.status(status).render('productos/combo-formulario', {
    titulo: 'Nuevo combo',
    activo: '/productos',
    restaurante,
    restaurantes,
    categorias,
    productos,
    producto,
    errores,
    aviso,
    seleccionados,
    cantidades,
  });
}

router.post('/combo/nuevo', async (req, res) => {
  const seleccion = leerComponentes(req.body);
  const idRestaurante = typeof req.body.id_restaurante === 'string'
    ? idSchema.safeParse(req.body.id_restaurante)
    : { success: false };
  const { restaurantes, categorias } = await listasCatalogo();
  if (!idRestaurante.success) {
    return mostrarFormularioCombo(res, {
      restaurantes, categorias, productos: [], producto: req.body,
      errores: { restaurante: 'Selecciona un restaurante válido.' }, status: 400,
    });
  }

  const [[[restaurante]], [todos]] = await Promise.all([
    callProc('sp_restaurante_obtener', [idRestaurante.data]),
    callProc('sp_producto_listar', [null, idRestaurante.data, null]),
  ]);
  const productos = todos.filter((p) => !Boolean(p.es_combo));
  const datosFormulario = {
    ...req.body,
    componentes: seleccion.componentes ?? [],
  };
  const { datos, errores } = validar(comboSchema, datosFormulario);
  const erroresFinales = { ...(errores ?? {}) };
  if (seleccion.error) {
    erroresFinales.componentes = seleccion.error;
  }
  if (Object.keys(erroresFinales).length) {
    return mostrarFormularioCombo(res, {
      restaurante, restaurantes, categorias, productos, producto: req.body, errores: erroresFinales,
      seleccionados: seleccion.seleccionados ?? {}, cantidades: seleccion.cantidades ?? {}, status: 400,
    });
  }

  try {
    const [[fila]] = await callProc('sp_combo_crear', [
      datos.id_restaurante,
      datos.id_categoria,
      datos.nombre,
      datos.descripcion,
      datos.precio,
      JSON.stringify(datos.componentes),
    ]);
    res.redirect(303, `/productos/${fila.id_producto}?ok=creado`);
  } catch (err) {
    if (!(err instanceof ErrorApp) || err.status >= 500) throw err;
    mostrarFormularioCombo(res, {
      restaurante, restaurantes, categorias, productos, producto: req.body,
      errores: err.campo ? { [err.campo]: err.message } : {},
      aviso: { titulo: 'No se creó el combo', mensaje: err.message, detalle: err.detalle },
      seleccionados: seleccion.seleccionados ?? {}, cantidades: seleccion.cantidades ?? {}, status: err.status,
    });
  }
});

router.get('/:id', async (req, res) => {
  await mostrarDetalle(res, leerId(req), { ok: MENSAJES_OK[req.query.ok] ?? null });
});

router.get('/:id/editar', async (req, res) => {
  const id = leerId(req);
  const { producto, combos } = await cargarProducto(id);
  mostrarFormulario(res, {
    producto,
    modo: 'editar',
    restauranteFijo: Boolean(producto.es_combo) || combos.length > 0,
  });
});

router.post('/:id/editar', async (req, res) => {
  const id = leerId(req);
  const { producto: existente, combos } = await cargarProducto(id);
  const restauranteFijo = Boolean(existente.es_combo) || combos.length > 0;
  const { datos, errores } = validar(productoSchema, req.body);
  const erroresFinales = { ...(errores ?? {}) };
  if (restauranteFijo && datos && datos.id_restaurante !== Number(existente.id_restaurante)) {
    erroresFinales.id_restaurante = 'No se puede cambiar de restaurante: este producto forma parte de un combo.';
  }
  if (Object.keys(erroresFinales).length) {
    return mostrarFormulario(res, {
      producto: {
        ...req.body,
        id_producto: id,
        ...(restauranteFijo ? { id_restaurante: existente.id_restaurante } : {}),
      },
      errores: erroresFinales,
      modo: 'editar',
      restauranteFijo,
      status: 400,
    });
  }

  try {
    await callProc('sp_producto_actualizar', [id, ...parametrosProducto(datos)]);
    res.redirect(303, `/productos/${id}?ok=actualizado`);
  } catch (err) {
    if (!(err instanceof ErrorApp) || err.status >= 500 || err.status === 404) throw err;
    mostrarFormulario(res, {
      producto: {
        ...req.body,
        id_producto: id,
        ...(restauranteFijo ? { id_restaurante: existente.id_restaurante } : {}),
      },
      modo: 'editar', restauranteFijo, status: err.status,
      errores: err.campo ? { [err.campo]: err.message } : {},
      aviso: { titulo: 'No se guardaron los cambios', mensaje: err.message, detalle: err.detalle },
    });
  }
});

router.post('/:id/disponibilidad', async (req, res) => {
  const id = leerId(req);
  if (!['0', '1'].includes(req.body.disponible)) {
    throw new ErrorApp('El estado de disponibilidad enviado no es válido.', { status: 400 });
  }
  await callProc('sp_producto_cambiar_disponible', [id, req.body.disponible === '1']);
  res.redirect(303, `/productos/${id}?ok=disponibilidad`);
});

router.get('/:id/componentes/editar', async (req, res) => {
  const id = leerId(req);
  const { producto, componentes } = await cargarProducto(id);
  if (!Boolean(producto.es_combo)) throw new ErrorApp('El producto indicado no es un combo.', { status: 404 });
  const [todos] = await callProc('sp_producto_listar', [null, producto.id_restaurante, null]);
  const seleccionados = Object.fromEntries(componentes.map((c) => [c.id_producto, true]));
  const cantidades = Object.fromEntries(componentes.map((c) => [c.id_producto, String(c.cantidad)]));
  res.render('productos/componentes-formulario', {
    titulo: `Editar componentes · ${producto.nombre}`,
    activo: '/productos',
    producto,
    productos: todos.filter((p) => !Boolean(p.es_combo)),
    seleccionados,
    cantidades,
    errores: {},
    aviso: null,
  });
});

router.post('/:id/componentes/editar', async (req, res) => {
  const id = leerId(req);
  const { producto } = await cargarProducto(id);
  if (!Boolean(producto.es_combo)) throw new ErrorApp('El producto indicado no es un combo.', { status: 404 });

  const seleccion = leerComponentes(req.body);
  const [todos] = await callProc('sp_producto_listar', [null, producto.id_restaurante, null]);
  const productos = todos.filter((p) => !Boolean(p.es_combo));
  const resultado = comboSchema.shape.componentes.safeParse(seleccion.componentes ?? []);
  const errores = resultado.success ? {} : { componentes: resultado.error.issues[0].message };
  if (seleccion.error) {
    errores.componentes = seleccion.error;
  }
  if (Object.keys(errores).length) {
    return res.status(400).render('productos/componentes-formulario', {
      titulo: `Editar componentes · ${producto.nombre}`,
      activo: '/productos',
      producto,
      productos,
      seleccionados: seleccion.seleccionados ?? {},
      cantidades: seleccion.cantidades ?? {},
      errores,
      aviso: null,
    });
  }

  try {
    await callProc('sp_combo_actualizar_componentes', [id, JSON.stringify(resultado.data)]);
    res.redirect(303, `/productos/${id}?ok=componentes`);
  } catch (err) {
    if (!(err instanceof ErrorApp) || err.status >= 500 || err.status === 404) throw err;
    res.status(err.status).render('productos/componentes-formulario', {
      titulo: `Editar componentes · ${producto.nombre}`,
      activo: '/productos',
      producto,
      productos,
      seleccionados: seleccion.seleccionados ?? {},
      cantidades: seleccion.cantidades ?? {},
      errores: err.campo ? { [err.campo]: err.message } : {},
      aviso: { titulo: 'No se actualizaron los componentes', mensaje: err.message, detalle: err.detalle },
    });
  }
});

router.post('/:id/eliminar', async (req, res) => {
  const id = leerId(req);
  const [[resultado]] = await callProc('sp_producto_eliminar', [id]);
  res.redirect(303, `/productos?accion=${encodeURIComponent(resultado.accion)}&mensaje=${encodeURIComponent(resultado.mensaje)}`);
});

export default router;
