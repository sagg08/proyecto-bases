/**
 * app/validators/producto.js · Reglas de Productos y Combos.
 * Los largos coinciden con PRODUCTO en el DDL.
 */
import { z } from 'zod';
import { idSchema, textoObligatorio, textoOpcional } from './comunes.js';

const precioSchema = z.coerce.number({ error: 'El precio debe ser un número entero de pesos.' })
  .int('El precio debe ser un número entero de pesos.')
  .positive('El precio debe ser mayor que 0.');

const componenteSchema = z.object({
  id_producto: idSchema,
  cantidad: z.coerce.number()
    .int('La cantidad debe ser un número entero.')
    .min(1, 'La cantidad debe ser al menos 1.'),
});

export const productoSchema = z.object({
  id_restaurante: idSchema,
  id_categoria: idSchema,
  nombre: textoObligatorio('Nombre', 80),
  descripcion: textoOpcional('Descripción', 200),
  precio: precioSchema,
});

export const comboSchema = productoSchema.extend({
  componentes: z.array(componenteSchema).min(1, 'Selecciona al menos un producto para el combo.'),
});
