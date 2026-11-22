/**
 * app/validators/pedido.js · Reglas del flujo "Pedir" y del panel de Pedidos.
 * Largos de dirección iguales al DDL de PEDIDO (calle 60, numero 20, barrio 60, ciudad 60).
 */
import { z } from 'zod';
import { idSchema, textoObligatorio } from './comunes.js';

const METODOS_PAGO = ['efectivo', 'tarjeta', 'transferencia'];

/**
 * Paso "Confirmar": dirección por partes + método de pago (sección 4 del plan).
 * El cliente y el restaurante NO se leen del formulario: vienen de la cookie
 * de "¿quién pide?" y del carrito, para que no se puedan falsear desde el HTML.
 */
export const confirmarPedidoSchema = z.object({
  calle: textoObligatorio('La calle', 60),
  numero: textoObligatorio('El número', 20),
  barrio: textoObligatorio('El barrio', 60),
  ciudad: textoObligatorio('La ciudad', 60),
  metodo_pago: z.enum(METODOS_PAGO, { error: 'Selecciona un método de pago.' }),
});

/** Avanzar un pedido en el panel de operación: estado destino + repartidor opcional. */
export const avanzarEstadoSchema = z.object({
  id_estado: idSchema,
  id_repartidor: z.preprocess(
    (v) => (v === '' || v === undefined ? null : v),
    idSchema.nullable(),
  ),
});

/** Calificar: dos notas de 1 a 5 estrellas y un comentario opcional. */
export const calificarSchema = z.object({
  nota_restaurante: z.coerce.number().int().min(1, 'Elige de 1 a 5 estrellas.').max(5, 'Elige de 1 a 5 estrellas.'),
  nota_repartidor: z.coerce.number().int().min(1, 'Elige de 1 a 5 estrellas.').max(5, 'Elige de 1 a 5 estrellas.'),
  comentario: z.string().trim().max(300, 'El comentario admite máximo 300 caracteres.')
    .transform((v) => (v === '' ? null : v)).nullable().optional().transform((v) => v ?? null),
});
