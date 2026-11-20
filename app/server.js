/**
 * app/server.js · Punto de entrada. Arranca con: npm start
 * Solo enciende el servidor; la aplicación se arma en app.js.
 */
import { config } from './config.js';
import { pool } from './db/pool.js';
import app from './app.js';

const servidor = app.listen(config.app.port, config.app.host, () => {
  console.log(`Domicilios listo en http://${config.app.host}:${config.app.port}`);
});

// Cierre ordenado (Ctrl+C): libera las conexiones de MySQL
process.on('SIGINT', () => {
  servidor.close(() => pool.end().then(() => process.exit(0)));
});
