/**
 * app/validators/reporte.js · Filtros de la pantalla Reportes (P4).
 *
 * Los filtros llegan por la URL (?limite=10&min_calificaciones=3&ciudad=Bogotá),
 * así que cualquiera puede escribir cualquier cosa. Se validan aquí con los
 * mismos rangos que validan los procedimientos (05_sp_reportes.sql): la app da
 * el mensaje claro y la base es la última defensa.
 */
import { z } from 'zod';

export const FILTROS_POR_DEFECTO = Object.freeze({ limite: 10, min_calificaciones: 3, ciudad: null });

/** Entero en un rango; vacío o ausente → valor por defecto. */
const enteroEnRango = (etiqueta, min, max, porDefecto) => z.preprocess(
  (v) => (v === undefined || v === '' ? porDefecto : v),
  z.coerce.number({ error: `${etiqueta} debe ser un número.` })
    .int(`${etiqueta} debe ser un número entero.`)
    .min(min, `${etiqueta} debe estar entre ${min} y ${max}.`)
    .max(max, `${etiqueta} debe estar entre ${min} y ${max}.`),
);

export const filtrosReporteSchema = z.object({
  limite: enteroEnRango('El número de restaurantes', 1, 100, FILTROS_POR_DEFECTO.limite),
  min_calificaciones: enteroEnRango('El mínimo de calificaciones', 1, 50, FILTROS_POR_DEFECTO.min_calificaciones),
  ciudad: z.preprocess(
    (v) => (v === undefined ? '' : v),
    z.string({ error: 'La ciudad no es válida.' }).trim().max(60, 'La ciudad admite máximo 60 caracteres.'),
  ).transform((v) => (v === '' ? null : v)),
});
