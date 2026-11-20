/**
 * app/validators/comunes.js · Piezas de validación reutilizables (zod).
 *
 * Por qué validar en la app SI la BD ya tiene CHECK y NOT NULL:
 *  - La app da mensajes por campo, en español, antes de gastar un viaje a MySQL.
 *  - La BD es la última línea de defensa: protege aunque alguien se salte la app.
 * Ambas capas se documentan en docs/arquitectura.md (P4).
 */
import { z } from 'zod';

/** Texto obligatorio, sin espacios sobrantes, con largo máximo. */
export const textoObligatorio = (etiqueta, max) =>
  z.string({ error: `${etiqueta} es obligatorio.` })
    .trim()
    .min(1, `${etiqueta} es obligatorio.`)
    .max(max, `${etiqueta} admite máximo ${max} caracteres.`);

/** Texto opcional: '' se convierte en null (así llega NULL a la BD). */
export const textoOpcional = (etiqueta, max) =>
  z.string().trim()
    .max(max, `${etiqueta} admite máximo ${max} caracteres.`)
    .transform((v) => (v === '' ? null : v))
    .nullable()
    .optional()
    .transform((v) => v ?? null);

/** Nombres y apellidos: letras (con tildes y ñ), espacios, apóstrofo y guion. */
export const nombrePersona = (etiqueta, max) =>
  textoObligatorio(etiqueta, max).regex(/^[\p{L}][\p{L} '\-]*$/u, `${etiqueta} solo admite letras, espacios y guiones.`);

/** Teléfono colombiano: 7 a 15 dígitos, opcionalmente con + al inicio. */
export const telefono = z.string().trim()
  .transform((v) => v.replace(/[\s-]/g, ''))                       // acepta "310 455 8821"
  .pipe(z.string().regex(/^\+?\d{7,15}$/, 'Cada teléfono debe tener entre 7 y 15 dígitos.'));

/** Fecha AAAA-MM-DD que exista de verdad (rechaza 2025-02-30). */
export const fecha = (etiqueta) =>
  z.string({ error: `${etiqueta} es obligatoria.` })
    .regex(/^\d{4}-\d{2}-\d{2}$/, `${etiqueta} debe tener formato AAAA-MM-DD.`)
    .refine((v) => {
      const d = new Date(`${v}T00:00:00`);
      return !Number.isNaN(d.getTime()) && d.toISOString().startsWith(v);
    }, `${etiqueta} no es una fecha válida.`);

/** id numérico de la URL (/clientes/:id). */
export const idSchema = z.coerce.number().int().positive();

/** Un campo de formulario que puede llegar como texto o como arreglo → siempre arreglo. */
export const comoArreglo = (v) => (v === undefined ? [] : Array.isArray(v) ? v : [v]);

/**
 * Valida y devuelve { datos } o { errores: { campo: 'mensaje' } } para pintar el formulario.
 */
export function validar(esquema, entrada) {
  const r = esquema.safeParse(entrada);
  if (r.success) return { datos: r.data, errores: null };

  const errores = {};
  for (const issue of r.error.issues) {
    const campo = String(issue.path[0] ?? '_');
    errores[campo] ??= issue.message;     // solo el primer error de cada campo
  }
  return { datos: null, errores };
}
