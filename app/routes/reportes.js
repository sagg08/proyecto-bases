/**
 * app/routes/reportes.js · Pantalla Reportes (P4).
 *
 * Cada reporte responde una pregunta de negocio y llama UN procedimiento de
 * 05_sp_reportes.sql, que a su vez lee una vista de 06_vistas.sql. La app no
 * calcula ventas ni promedios: solo valida los filtros y pinta lo que devuelve
 * MySQL (regla del proyecto: la app solo ejecuta CALL sp_...).
 */
import { Router } from 'express';
import { callProc } from '../db/pool.js';
import { filtrosReporteSchema, FILTROS_POR_DEFECTO } from '../validators/reporte.js';
import { validar } from '../validators/comunes.js';

const router = Router();

/** Opciones de los selectores (los procedimientos aceptan 1-100 y 1-50). */
const OPCIONES_LIMITE = [5, 10, 20, 60];
const OPCIONES_MIN_CALIFICACIONES = [1, 2, 3, 5];

router.get('/', async (req, res) => {
  const { datos, errores } = validar(filtrosReporteSchema, req.query);
  const filtros = errores ? FILTROS_POR_DEFECTO : datos;
  const aviso = errores
    ? { titulo: 'Filtro no válido', mensaje: `${Object.values(errores)[0]} Se muestran los valores por defecto.` }
    : null;

  // Los cinco procedimientos son independientes: se piden a la vez (el pool tiene 10 conexiones)
  const [
    [[resumen]],
    [restaurantes],
    [repartidores],
    [zonas, ciudades],
    [meses],
  ] = await Promise.all([
    callProc('sp_reporte_resumen'),
    callProc('sp_reporte_restaurantes', [filtros.limite]),
    callProc('sp_reporte_repartidores', [filtros.min_calificaciones, 10]),
    callProc('sp_reporte_tiempos_entrega', [filtros.ciudad]),
    callProc('sp_reporte_ventas_mensuales'),
  ]);

  res.status(errores ? 400 : 200).render('reportes/index', {
    titulo: 'Reportes',
    activo: '/reportes',
    filtros,
    aviso,
    opcionesLimite: OPCIONES_LIMITE,
    opcionesMinCalificaciones: OPCIONES_MIN_CALIFICACIONES,
    resumen,
    restaurantes,
    repartidores,
    zonas,
    ciudades: ciudades.map((c) => c.ciudad),
    meses,
  });
});

export default router;
