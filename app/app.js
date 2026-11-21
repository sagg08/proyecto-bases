/**
 * app/app.js · Arma la aplicación Express (sin abrir el puerto).
 * Está separada de server.js para que las pruebas la usen con supertest
 * sin levantar un servidor real.
 *
 * Orden de las piezas (importa en Express):
 *   1. seguridad y lectura de formularios
 *   2. archivos estáticos (CSS, JS, fuentes)
 *   3. variables comunes para todas las vistas
 *   4. rutas de cada módulo
 *   5. 404 y manejador de errores (siempre al final)
 */
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import express from 'express';
import helmet from 'helmet';
import { ErrorApp } from './db/errores.js';
import { fmt } from './lib/formato.js';
import { navegacion } from './navegacion.js';
import clientesRouter from './routes/clientes.js';
import restaurantesRouter from './routes/restaurantes.js';
import categoriasRouter from './routes/categorias.js';

const aqui = path.dirname(fileURLToPath(import.meta.url));
const raiz = path.resolve(aqui, '..');
const app = express();

app.set('view engine', 'ejs');
app.set('views', path.join(aqui, 'views'));
app.disable('x-powered-by');

// ---------- 1. Seguridad y formularios ----------
app.use(helmet());                                            // cabeceras seguras (CSP, nosniff, etc.)
app.use(express.urlencoded({ extended: false, limit: '50kb' })); // lee formularios HTML; tamaño acotado

// ---------- 2. Estáticos ----------
app.use(express.static(path.join(aqui, 'public')));
// Fuentes servidas desde node_modules: funcionan sin internet
app.use('/fuentes/plex-sans', express.static(path.join(raiz, 'node_modules/@fontsource/ibm-plex-sans')));
app.use('/fuentes/plex-mono', express.static(path.join(raiz, 'node_modules/@fontsource/ibm-plex-mono')));

// ---------- 3. Datos comunes para las vistas ----------
app.use((req, res, next) => {
  res.locals.fmt = fmt;
  res.locals.navegacion = navegacion;
  res.locals.rutaActual = req.path;
  next();
});

// ---------- 4. Rutas ----------
app.get('/', (req, res) => res.render('inicio', { titulo: 'Inicio', activo: '/' }));
app.use('/clientes', clientesRouter);
app.use('/restaurantes', restaurantesRouter);
app.use('/categorias', categoriasRouter);
// P2: app.use('/productos', ...);
// P3: app.use('/repartidores', ...); app.use('/pedidos', ...);
// P4: app.use('/reportes', ...);

// ---------- 5. 404 y errores ----------
app.use((req, res) => {
  res.status(404).render('error', {
    titulo: 'Página no encontrada', activo: null, status: 404,
    mensaje: `No existe la página ${req.path}.`, detalle: null,
  });
});

// Manejador global: todo error lanzado en una ruta termina aquí
// eslint-disable-next-line no-unused-vars
app.use((err, req, res, next) => {
  const conocido = err instanceof ErrorApp;
  if (!conocido || err.status >= 500) console.error(err);     // los inesperados quedan en la consola
  const status = conocido ? err.status : 500;
  res.status(status).render('error', {
    titulo: status === 404 ? 'No encontrado' : 'Algo salió mal',
    activo: null,
    status,
    mensaje: conocido ? err.message : 'Error inesperado en el servidor. Revisa la consola donde corre npm start.',
    detalle: conocido ? err.detalle : null,
  });
});

export default app;
