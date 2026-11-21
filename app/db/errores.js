/**
 * app/db/errores.js · Convierte errores de MySQL en mensajes claros para la persona.
 *
 * El enunciado pide "mensaje de error claro y específico, no un error genérico".
 * Cada error de MySQL trae un número (errno) y un SQLSTATE; según eso decidimos
 * el código HTTP, el texto y, si se puede, el campo del formulario culpable.
 */

/** Error "esperado" que la app sabe mostrar. */
export class ErrorApp extends Error {
  /**
   * @param {string} mensaje  texto para la persona
   * @param {object} opciones status HTTP, campo del formulario, detalle técnico
   */
  constructor(mensaje, { status = 400, campo = null, detalle = null } = {}) {
    super(mensaje);
    this.name = 'ErrorApp';
    this.status = status;
    this.campo = campo;       // nombre del input para marcarlo en rojo
    this.detalle = detalle;   // p. ej. "MySQL 1062 · uq_cliente_email" (se muestra pequeño)
  }
}

// Restricciones UNIQUE y CHECK → campo + mensaje.
// Cada módulo agrega aquí las suyas (P2: nit, producto; P3: documento, placa...).
const RESTRICCIONES = {
  uq_cliente_email:        { campo: 'email', mensaje: 'Ya existe un cliente con ese correo.' },
  'TELEFONO_CLIENTE.PRIMARY': { campo: 'telefonos', mensaje: 'Hay un teléfono repetido.' },
  uq_restaurante_nit:      { campo: 'nit', mensaje: 'Ya existe un restaurante con ese NIT.' },
  uq_categoria_nombre:     { campo: 'nombre', mensaje: 'Ya existe una categoría con ese nombre.' },
  uq_repartidor_documento: { campo: 'documento', mensaje: 'Ya existe un repartidor con esa cédula.' },
  uq_repartidor_placa:     { campo: 'placa', mensaje: 'Esa placa ya pertenece a otro repartidor.' },
  ck_repartidor_placa:     { campo: 'placa', mensaje: 'La bicicleta no lleva placa; la moto y el carro sí.' },
  uq_producto_restaurante_nombre: { campo: 'nombre', mensaje: 'Este restaurante ya tiene un producto con ese nombre.' },
  ck_producto_precio:      { campo: 'precio', mensaje: 'El precio debe ser mayor que 0.' },
  ck_combo_cantidad:       { campo: 'componentes', mensaje: 'La cantidad de cada componente debe ser mayor que 0.' },
  ck_combo_no_si_mismo:    { campo: 'componentes', mensaje: 'Un producto no puede ser componente de sí mismo.' },
  'COMBO_COMPONENTE.PRIMARY': { campo: 'componentes', mensaje: 'Un producto no puede repetirse en el mismo combo.' },
};

/**
 * Busca el nombre de la restricción dentro del mensaje de MySQL.
 * Se compara en minúscula porque MySQL en Windows guarda los nombres de tabla
 * en minúscula (lower_case_table_names=1): 'telefono_cliente.PRIMARY' en Windows
 * vs 'TELEFONO_CLIENTE.PRIMARY' en Linux.
 */
function buscarRestriccion(mensaje = '') {
  const texto = mensaje.toLowerCase();
  const clave = Object.keys(RESTRICCIONES).find((nombre) => {
    const n = nombre.toLowerCase();
    return texto.includes(`'${n}'`) || texto.includes(`.${n}'`);
  });
  return clave ? { clave, ...RESTRICCIONES[clave] } : null;
}

/** Recibe el error crudo de mysql2 y devuelve un ErrorApp. */
export function traducirErrorMySQL(err) {
  const tecnico = `MySQL ${err.errno ?? ''} ${err.sqlState ?? err.code ?? ''}`.trim();

  // 1) SIGNAL de nuestros procedimientos y triggers: el mensaje YA es claro
  if (err.errno === 1644) {
    const status = err.sqlState === '45004' ? 404 : 400;   // 45004 = no existe (convención del proyecto)
    return new ErrorApp(err.sqlMessage, { status, detalle: `${tecnico} · SIGNAL` });
  }

  // 2) Violaciones de UNIQUE y de CHECK
  if (err.errno === 1062 || err.errno === 3819) {
    const r = buscarRestriccion(err.sqlMessage);
    const mensaje = r?.mensaje ?? (err.errno === 1062 ? 'Ese valor ya está registrado.' : 'Un dato no cumple las reglas de la base de datos.');
    return new ErrorApp(mensaje, { status: err.errno === 1062 ? 409 : 400, campo: r?.campo, detalle: `${tecnico} · ${r?.clave ?? err.sqlMessage}` });
  }

  // 3) Llaves foráneas
  if (err.errno === 1451) {
    return new ErrorApp('No se puede borrar: hay otros registros que dependen de este.', { status: 409, detalle: tecnico });
  }
  if (err.errno === 1452) {
    return new ErrorApp('Uno de los datos seleccionados ya no existe. Recarga la página e inténtalo de nuevo.', { status: 400, detalle: tecnico });
  }

  // 4) Problemas de instalación (los más probables cuando el profesor la levanta)
  if (err.code === 'ECONNREFUSED') {
    return new ErrorApp('No hay conexión con MySQL. Revisa que el servicio esté encendido y los datos DB_HOST/DB_PORT de .env.', { status: 503, detalle: err.code });
  }
  if (err.errno === 1045) {
    return new ErrorApp('MySQL rechazó el usuario o la contraseña de .env (DB_USER, DB_PASSWORD).', { status: 503, detalle: tecnico });
  }
  if (err.errno === 1049) {
    return new ErrorApp('La base de datos no existe todavía. Ejecuta: npm run db:setup', { status: 503, detalle: tecnico });
  }
  if (err.errno === 1305) {
    return new ErrorApp('Falta un procedimiento almacenado en la base. Ejecuta: npm run db:setup', { status: 500, detalle: `${tecnico} · ${err.sqlMessage}` });
  }

  // 5) Cualquier otro: mensaje honesto + detalle técnico para depurar
  return new ErrorApp('Ocurrió un error inesperado en la base de datos.', { status: 500, detalle: `${tecnico} · ${err.sqlMessage ?? err.message}` });
}
