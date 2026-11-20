/**
 * app/validators/cliente.js · Reglas del formulario de Clientes.
 * Los largos coinciden con el DDL (VARCHAR(60), (40), (100)).
 */
import { z } from 'zod';
import { nombrePersona, textoOpcional, telefono, fecha, comoArreglo } from './comunes.js';

const EDAD_MINIMA = 14;   // regla de la app: la plataforma no registra menores de 14 años

function edadEnAnios(fechaTexto) {
  const nacimiento = new Date(`${fechaTexto}T00:00:00`);
  const hoy = new Date();
  let edad = hoy.getFullYear() - nacimiento.getFullYear();
  const aunNoCumple = hoy.getMonth() < nacimiento.getMonth()
    || (hoy.getMonth() === nacimiento.getMonth() && hoy.getDate() < nacimiento.getDate());
  return aunNoCumple ? edad - 1 : edad;
}

export const clienteSchema = z.object({
  nombres: nombrePersona('Nombres', 60),
  primer_apellido: nombrePersona('Primer apellido', 40),
  segundo_apellido: textoOpcional('Segundo apellido', 40),
  email: z.string().trim().toLowerCase()
    .max(100, 'El correo admite máximo 100 caracteres.')
    .pipe(z.email('Escribe un correo válido, p. ej. nombre@correo.com.')),
  fecha_nacimiento: fecha('La fecha de nacimiento')
    .refine((v) => edadEnAnios(v) >= 0, 'La fecha de nacimiento no puede ser futura.')
    .refine((v) => edadEnAnios(v) >= EDAD_MINIMA, `El cliente debe tener al menos ${EDAD_MINIMA} años.`)
    .refine((v) => edadEnAnios(v) <= 110, 'Revisa la fecha de nacimiento: la edad supera 110 años.'),
  // Multivaluado: llega como uno o varios inputs "telefonos".
  // Primero se limpian espacios y guiones y DESPUÉS se quitan vacíos y repetidos;
  // si no, "310 222 3344" y "3102223344" pasarían como números distintos.
  telefonos: z.preprocess(
    (v) => [...new Set(comoArreglo(v).map((t) => String(t).replace(/[\s-]/g, '')).filter(Boolean))],
    z.array(telefono).min(1, 'Agrega al menos un teléfono.').max(5, 'Máximo 5 teléfonos por cliente.'),
  ),
});
