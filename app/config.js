/**
 * app/config.js · Lee la configuración desde .env (nunca valores en el código).
 * Si falta algo obligatorio, la app se detiene con un mensaje claro al arrancar,
 * en vez de fallar más tarde con un error confuso.
 */
import dotenv from 'dotenv';

dotenv.config({ quiet: true });

const faltantes = ['DB_USER', 'DB_NAME'].filter((clave) => !process.env[clave]);
if (faltantes.length) {
  console.error(`Faltan variables en .env: ${faltantes.join(', ')}. Copia .env.example como .env y complétalo.`);
  process.exit(1);
}

export const config = {
  db: {
    host: process.env.DB_HOST ?? '127.0.0.1',
    port: Number(process.env.DB_PORT ?? 3306),
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD ?? '',
    database: process.env.DB_NAME,
  },
  app: {
    host: process.env.APP_HOST ?? '127.0.0.1',   // solo este equipo, no la red
    port: Number(process.env.APP_PORT ?? 3000),
  },
};
