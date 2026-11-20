/**
 * scripts/db-setup.js · Crea la base de datos desde cero.
 *
 * Uso:  npm run db:setup
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
import { fileURLToPath } from 'node:url';
import mysql from 'mysql2/promise';

const raiz = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');

/** Devuelve la lista de archivos de 00_run_all.sql, en orden. */
function leerManifiesto() {
  const texto = fs.readFileSync(path.join(raiz, 'db', '00_run_all.sql'), 'utf8');
  return texto
    .split(/\r?\n/)
    .map((l) => l.trim())
    .filter((l) => /^SOURCE\s+/i.test(l))           // ignora comentarios "-- SOURCE ..."
    .map((l) => l.replace(/^SOURCE\s+/i, '').replace(/;$/, '').trim());
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

async function main() {
  // Sin "database": 01_ddl.sql la borra y la vuelve a crear
  const conexion = await mysql.createConnection({
    host: process.env.DB_HOST ?? '127.0.0.1',
    port: Number(process.env.DB_PORT ?? 3306),
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
  });

  const archivos = leerManifiesto();
  console.log(`Ejecutando ${archivos.length} archivo(s) sobre ${process.env.DB_HOST ?? '127.0.0.1'}...\n`);

  for (const archivo of archivos) {
    const sql = fs.readFileSync(path.join(raiz, archivo), 'utf8');
    const instrucciones = partirInstrucciones(sql);
    process.stdout.write(`  ${archivo.padEnd(32)} `);

    for (const [i, instruccion] of instrucciones.entries()) {
      try {
        await conexion.query(instruccion);
      } catch (err) {
        console.log('ERROR');
        console.error(`\nFalló la instrucción ${i + 1} de ${archivo}:\n${instruccion.slice(0, 300)}\n`);
        console.error(`MySQL ${err.errno ?? ''} ${err.code ?? ''}: ${err.message}`);
        await conexion.end();
        process.exit(1);
      }
    }
    console.log(`ok (${instrucciones.length} instrucciones)`);
  }

  await conexion.end();
  console.log('\nBase de datos lista. Ahora: npm start');
}

main().catch((err) => {
  if (err.code === 'ECONNREFUSED') {
    console.error('No hay conexión con MySQL. ¿Está encendido el servicio? Revisa DB_HOST y DB_PORT en .env');
  } else if (err.code === 'ER_ACCESS_DENIED_ERROR') {
    console.error('MySQL rechazó el usuario o la contraseña. Revisa DB_USER y DB_PASSWORD en .env');
  } else {
    console.error(err);
  }
  process.exit(1);
});
