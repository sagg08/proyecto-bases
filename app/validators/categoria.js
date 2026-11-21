/**
 * app/validators/categoria.js · Reglas del formulario de Categorías.
 * El largo coincide con el DDL de CATEGORIA.
 */
import { z } from 'zod';
import { textoObligatorio } from './comunes.js';

export const categoriaSchema = z.object({
  nombre: textoObligatorio('Nombre', 40),
});
