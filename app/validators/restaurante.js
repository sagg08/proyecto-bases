/**
 * app/validators/restaurante.js · Reglas del formulario de Restaurantes.
 * Los largos coinciden con el DDL de RESTAURANTE.
 */
import { z } from 'zod';
import { textoObligatorio, telefono, fecha } from './comunes.js';

function noEsFutura(fechaTexto) {
  const hoy = new Date();
  const hoyTexto = `${hoy.getFullYear()}-${String(hoy.getMonth() + 1).padStart(2, '0')}-${String(hoy.getDate()).padStart(2, '0')}`;
  return fechaTexto <= hoyTexto;
}

export const restauranteSchema = z.object({
  nit: textoObligatorio('NIT', 15)
    .regex(/^\d{9,10}(?:-\d)?$/, 'El NIT debe tener 9 o 10 dígitos y, opcionalmente, guion y dígito de verificación.'),
  nombre: textoObligatorio('Nombre', 80),
  direccion: textoObligatorio('Dirección', 120),
  telefono: telefono.refine((valor) => valor.length <= 15, 'El teléfono admite máximo 15 caracteres.'),
  fecha_afiliacion: fecha('La fecha de afiliación')
    .refine(noEsFutura, 'La fecha de afiliación no puede ser futura.'),
});
