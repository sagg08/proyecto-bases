/**
 * app/lib/carrito.js · Estado del flujo "Pedir" guardado en cookies.
 *
 * La app no tiene login real ("¿Quién pide?" simula uno eligiendo un cliente
 * existente, sección 4 del plan): el cliente elegido y el carrito en curso
 * viven en dos cookies firmadas por el propio navegador, httpOnly para que
 * no las toque JavaScript de terceros. No se agregó cookie-parser como
 * dependencia nueva: basta un parser mínimo del encabezado Cookie.
 *
 * El carrito solo admite productos de UN restaurante (regla del caso):
 * agregarAlCarrito() lo vacía si se intenta mezclar, y la ruta que lo llama
 * es quien decide si eso requiere confirmación.
 */
const NOMBRE_CLIENTE = 'pedir_cliente';
const NOMBRE_CARRITO = 'pedir_carrito';
const UN_DIA_MS = 24 * 60 * 60 * 1000;
const OPCIONES_COOKIE = { httpOnly: true, sameSite: 'lax', maxAge: UN_DIA_MS };

/** Parser mínimo de "Cookie: a=1; b=2" → { a: '1', b: '2' }. */
function leerCookies(req) {
  const encabezado = req.headers.cookie;
  if (!encabezado) return {};
  const resultado = {};
  for (const par of encabezado.split(';')) {
    const igual = par.indexOf('=');
    if (igual === -1) continue;
    const nombre = par.slice(0, igual).trim();
    try {
      resultado[nombre] = decodeURIComponent(par.slice(igual + 1).trim());
    } catch {
      resultado[nombre] = par.slice(igual + 1).trim();   // valor mal codificado: se deja crudo
    }
  }
  return resultado;
}

// ---------- "¿Quién pide?": cliente elegido ----------
export function leerClienteElegido(req) {
  const id = Number(leerCookies(req)[NOMBRE_CLIENTE]);
  return Number.isInteger(id) && id > 0 ? id : null;
}

export function fijarClienteElegido(res, idCliente) {
  res.cookie(NOMBRE_CLIENTE, String(idCliente), OPCIONES_COOKIE);
}

export function olvidarClienteElegido(res) {
  res.clearCookie(NOMBRE_CLIENTE);
}

// ---------- Carrito ----------
const CARRITO_VACIO = Object.freeze({ id_restaurante: null, items: [] });

export function leerCarrito(req) {
  const crudo = leerCookies(req)[NOMBRE_CARRITO];
  if (!crudo) return { ...CARRITO_VACIO, items: [] };
  try {
    const datos = JSON.parse(crudo);
    if (!datos || typeof datos !== 'object' || !Array.isArray(datos.items)) throw new Error('forma inválida');
    return { id_restaurante: datos.id_restaurante ?? null, items: datos.items };
  } catch {
    return { ...CARRITO_VACIO, items: [] };   // cookie corrupta o manipulada a mano: se ignora
  }
}

export function guardarCarrito(res, carrito) {
  res.cookie(NOMBRE_CARRITO, JSON.stringify(carrito), OPCIONES_COOKIE);
}

export function vaciarCarrito(res) {
  res.clearCookie(NOMBRE_CARRITO);
}

/** true si el carrito tiene productos de un restaurante DISTINTO al indicado. */
export function esOtroRestaurante(carrito, idRestaurante) {
  return carrito.items.length > 0 && carrito.id_restaurante !== idRestaurante;
}

/** Agrega una unidad del producto (o crea la línea). Asume que ya se resolvió el aviso de "otro restaurante". */
export function agregarAlCarrito(carrito, idRestaurante, idProducto, cantidad = 1) {
  const base = esOtroRestaurante(carrito, idRestaurante) ? { id_restaurante: idRestaurante, items: [] } : carrito;
  const items = [...base.items];
  const linea = items.find((i) => i.id_producto === idProducto);
  if (linea) linea.cantidad += cantidad;
  else items.push({ id_producto: idProducto, cantidad });
  return { id_restaurante: idRestaurante, items };
}

/** cantidad <= 0 quita la línea. Si el carrito queda vacío, también se libera el restaurante. */
export function actualizarCantidad(carrito, idProducto, cantidad) {
  const items = cantidad <= 0
    ? carrito.items.filter((i) => i.id_producto !== idProducto)
    : carrito.items.map((i) => (i.id_producto === idProducto ? { ...i, cantidad } : i));
  return { id_restaurante: items.length ? carrito.id_restaurante : null, items };
}
