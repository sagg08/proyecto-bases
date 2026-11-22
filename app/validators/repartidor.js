/**
 * app/validators/repartidor.js · Reglas del formulario de Repartidores.
 * Los largos coinciden con el DDL de REPARTIDOR. La regla "bicicleta sin
 * placa, moto y carro con placa" ya está en ck_repartidor_placa (01_ddl.sql);
 * se repite aquí para dar el error por campo ANTES de llegar a MySQL.
 */
import { z } from 'zod';
import { nombrePersona, textoObligatorio, textoOpcional, telefono, fecha } from './comunes.js';

function noEsFutura(fechaTexto) {
  const hoy = new Date();
  const hoyTexto = `${hoy.getFullYear()}-${String(hoy.getMonth() + 1).padStart(2, '0')}-${String(hoy.getDate()).padStart(2, '0')}`;
  return fechaTexto <= hoyTexto;
}

const TIPOS_VEHICULO = ['moto', 'bicicleta', 'carro'];

export const repartidorSchema = z.object({
  documento: textoObligatorio('El documento', 15)
    .regex(/^\d{5,15}$/, 'El documento debe tener entre 5 y 15 dígitos.'),
  nombres: nombrePersona('Nombres', 60),
  primer_apellido: nombrePersona('Primer apellido', 40),
  segundo_apellido: textoOpcional('Segundo apellido', 40),
  telefono: telefono.refine((valor) => valor.length <= 15, 'El teléfono admite máximo 15 caracteres.'),
  tipo_vehiculo: z.enum(TIPOS_VEHICULO, { error: 'Selecciona un tipo de vehículo válido.' }),
  // '' (bicicleta, el formulario oculta el campo) se vuelve NULL antes de validar nada más.
  placa: z.string().trim().toUpperCase()
    .transform((v) => (v === '' ? null : v))
    .nullable().optional().transform((v) => v ?? null),
  fecha_ingreso: fecha('La fecha de ingreso').refine(noEsFutura, 'La fecha de ingreso no puede ser futura.'),
}).superRefine((datos, ctx) => {
  if (datos.tipo_vehiculo === 'bicicleta') {
    if (datos.placa) {
      ctx.addIssue({ code: 'custom', path: ['placa'], message: 'La bicicleta no lleva placa.' });
    }
  } else if (!datos.placa) {
    ctx.addIssue({ code: 'custom', path: ['placa'], message: 'La moto y el carro deben tener placa.' });
  } else if (!/^[A-Z0-9-]{5,10}$/.test(datos.placa)) {
    ctx.addIssue({ code: 'custom', path: ['placa'], message: 'La placa no es válida.' });
  }
});
