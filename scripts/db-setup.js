/**
 * scripts/db-setup.js · Crea la base de datos desde cero.
 *
 * Uso:  npm run db:setup          (crea la base DB_NAME de .env, por defecto "domicilios")
 * Las pruebas lo importan para crear "domicilios_test" sin tocar la base real.
 *
 * Qué hace:
 *  1. Lee db/00_run_all.sql y toma las líneas "SOURCE archivo;" (las comentadas se ignoran).
 *  2. Ejecuta cada archivo en ese orden contra MySQL, usando las credenciales de .env.
 *  3. Entiende "DELIMITER $$" igual que el cliente mysql, para los triggers y procedimientos.
 *
 * Por qué existe: así el profesor no necesita instalar el cliente de consola de
 * MySQL ni copiar y pegar scripts en Workbench; basta Node.js.
 */
import 'dotenv/config';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath, pathToFileURL } from 'node:url';
import mysql from 'mysql2/promise';

const raiz = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');

/** Devuelve la lista de archivos de 00_run_all.sql, en orden. */
function leerManifiesto() {
  const texto = fs.readFileSync(path.join(raiz, 'db', '00_run_all.sql'), 'utf8');
  return texto
    .split(/\r?\n/)
    .map((l) => l.trim())
    .map((l) => l.match(/^SOURCE\s+([^;\s]+)/i))     // toma solo la ruta; ignora "-- SOURCE ..." y comentarios al final
    .filter(Boolean)
    .map((m) => m[1]);
}

/**
 * Parte un archivo .sql en instrucciones respetando DELIMITER.
 * Las líneas que son solo comentario se descartan para que un ";" dentro
 * de un comentario no corte una instrucción por error.
 */
function partirInstrucciones(sql) {
  const instrucciones = [];
  let delimitador = ';';
  let actual = [];

  for (const linea of sql.split(/\r?\n/)) {
    const limpia = linea.trim();

    if (/^DELIMITER\s+/i.test(limpia)) {            // cambio de delimitador
      delimitador = limpia.split(/\s+/)[1];
      continue;
    }
    if (limpia === '' || limpia.startsWith('--')) continue;

    actual.push(linea);

    // Se quita un comentario al final de la línea solo para revisar si termina en el delimitador
    const sinComentario = limpia.replace(/\s+--\s.*$/, '');
    if (sinComentario.endsWith(delimitador)) {
      const texto = actual.join('\n').trim();
      instrucciones.push(texto.slice(0, texto.lastIndexOf(delimitador)).trim());
      actual = [];
    }
  }
  if (actual.join('').trim()) instrucciones.push(actual.join('\n').trim());
  return instrucciones.filter(Boolean);
}

/**
 * Los scripts SQL dicen "domicilios". Si se pide otra base (p. ej. domicilios_test),
 * se cambia el nombre SOLO en DROP DATABASE / CREATE DATABASE / USE.
 */
function cambiarNombreBase(instruccion, nombreBD) {
  if (nombreBD === 'domicilios') return instruccion;
  return /^(DROP DATABASE|CREATE DATABASE|USE)\b/i.test(instruccion)
    ? instruccion.replace(/\bdomicilios\b/, nombreBD)
    : instruccion;
}

/**
 * Crea la base completa. Lanza un error (no cierra el proceso) para que las pruebas lo atrapen.
 * @param {{ nombreBD?: string, silencioso?: boolean }} opciones
 */
export async function crearBase({ nombreBD = process.env.DB_NAME ?? 'domicilios', silencioso = false } = {}) {
  const log = silencioso ? () => {} : (t) => process.stdout.write(t);

  // Sin "database": 01_ddl.sql la borra y la vuelve a crear
  const conexion = await mysql.createConnection({
    host: process.env.DB_HOST ?? '127.0.0.1',
    port: Number(process.env.DB_PORT ?? 3306),
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    charset: 'utf8mb4',
  });

  try {
    const archivos = leerManifiesto();
    log(`Creando la base "${nombreBD}" con ${archivos.length} archivo(s)...\n\n`);

    for (const archivo of archivos) {
      const instrucciones = partirInstrucciones(fs.readFileSync(path.join(raiz, archivo), 'utf8'));
      log(`  ${archivo.padEnd(32)} `);

      for (const [i, instruccion] of instrucciones.entries()) {
        try {
          await conexion.query(cambiarNombreBase(instruccion, nombreBD));
        } catch (err) {
          log('ERROR\n');
          err.message = `Falló la instrucción ${i + 1} de ${archivo}:\n${instruccion.slice(0, 300)}\n\nMySQL ${err.errno ?? ''} ${err.code ?? ''}: ${err.message}`;
          throw err;
        }
      }
      log(`ok (${instrucciones.length} instrucciones)\n`);
    }
  } finally {
    await conexion.end();
  }
}

// Solo se ejecuta si se llama directo (npm run db:setup), no cuando las pruebas lo importan
const ejecutadoDirecto = process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href;
if (ejecutadoDirecto) main();

async function main() {
  try {
    await crearBase();
    console.log('\nBase de datos lista. Ahora: npm start');
  } catch (err) {
    falla(err);
  }
}

function falla(err) {
  if (err.code === 'ECONNREFUSED') {
    console.error('No hay conexión con MySQL. ¿Está encendido el servicio? Revisa DB_HOST y DB_PORT en .env');
  } else if (err.code === 'ER_ACCESS_DENIED_ERROR') {
    console.error('MySQL rechazó el usuario o la contraseña. Revisa DB_USER y DB_PASSWORD en .env');
  } else {
    console.error(`\n${err.message}`);
  }
  process.exit(1);
}
