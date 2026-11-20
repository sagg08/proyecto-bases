/**
 * tests/preparar-bd.js · Se ejecuta UNA vez antes de todas las pruebas.
 * Crea "domicilios_test" con los mismos scripts de db/00_run_all.sql,
 * así las pruebas siempre arrancan de un estado conocido.
 */
import dotenv from 'dotenv';
import { crearBase } from '../scripts/db-setup.js';

export default async function () {
  dotenv.config({ quiet: true });           // credenciales de MySQL desde .env
  await crearBase({ nombreBD: 'domicilios_test', silencioso: true });
}
