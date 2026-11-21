/**
 * app/db/pool.js · Única puerta de la aplicación hacia MySQL.
 *
 * Regla del proyecto (enunciado 4.2): la app NO escribe SQL suelto.
 * Todo pasa por callProc('sp_nombre', [parametros]), que arma
 * "CALL sp_nombre(?, ?, ...)" con placeholders: mysql2 escapa cada valor,
 * así que no hay inyección SQL aunque el usuario escriba comillas.
 */
import mysql from 'mysql2/promise';
import { config } from '../config.js';
import { traducirErrorMySQL } from './errores.js';

// Pool: reutiliza conexiones abiertas en vez de abrir una por petición
export const pool = mysql.createPool({
  ...config.db,
  connectionLimit: 10,
  dateStrings: ['DATE'],      // DATE llega como YYYY-MM-DD; DATETIME conserva su tipo Date
  multipleStatements: false,  // seguridad: prohíbe "x; DROP TABLE ..." en una sola llamada
  charset: 'utf8mb4',
});

// Solo letras, números y "_" en el nombre del procedimiento: el nombre no puede
// ir como placeholder, así que se valida contra una lista blanca de caracteres.
const NOMBRE_VALIDO = /^sp_[a-z0-9_]+$/;

/**
 * Llama un procedimiento almacenado.
 * @param {string} nombre      p. ej. 'sp_cliente_crear'
 * @param {Array}  parametros  valores en el mismo orden que el procedimiento
 * @returns {Promise<Array<Array<object>>>} un arreglo por cada SELECT del procedimiento
 */
export async function callProc(nombre, parametros = []) {
  if (!NOMBRE_VALIDO.test(nombre)) {
    throw new Error(`Nombre de procedimiento inválido: ${nombre}`);
  }
  const marcadores = parametros.map(() => '?').join(', ');

  try {
    const [resultado] = await pool.query(`CALL ${nombre}(${marcadores})`, parametros);
    // mysql2 devuelve [conjunto1, conjunto2, ..., ResultSetHeader]; nos quedamos con los conjuntos
    return Array.isArray(resultado) ? resultado.filter(Array.isArray) : [];
  } catch (err) {
    throw traducirErrorMySQL(err);
  }
}
