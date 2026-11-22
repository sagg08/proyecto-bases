/**
 * app/lib/estados.js · Metadatos del catálogo ESTADO (ids fijos, 01_ddl.sql),
 * compartidos entre el panel de Pedidos y el flujo "Pedir": ambos pintan el
 * mismo "riel" de HISTORIAL_ESTADO y necesitan los mismos textos y clases.
 */
export const ESTADOS = [
  { id: 1, nombre: 'recibido', clase: 'recibido', texto: 'Recibido' },
  { id: 2, nombre: 'en preparación', clase: 'preparacion', texto: 'En preparación' },
  { id: 3, nombre: 'en camino', clase: 'camino', texto: 'En camino' },
  { id: 4, nombre: 'entregado', clase: 'entregado', texto: 'Entregado' },
  { id: 5, nombre: 'cancelado', clase: 'cancelado', texto: 'Cancelado' },
];

/** "en preparación" → "preparacion" (nombre de la clase estado--*). */
export function claseEstado(nombre) {
  return ESTADOS.find((e) => e.nombre === nombre)?.clase ?? 'recibido';
}

/** id → texto, p. ej. para pintar los pasos del riel que todavía no llegan. */
export function textoEstado(id) {
  return ESTADOS.find((e) => e.id === id)?.texto ?? '';
}

export const FLUJO = [1, 2, 3, 4];                 // recibido → preparación → camino → entregado
export const SIGUIENTE_ESTADO = { 1: 2, 2: 3, 3: 4 };
export const ETIQUETA_SIGUIENTE = {
  2: 'Pasar a "en preparación"',
  3: 'Pasar a "en camino"',
  4: 'Marcar como entregado',
};
export const ESTADO_CANCELADO = 5;
export const PUEDE_CANCELAR = new Set([1, 2]);       // trg_historial_bi: solo desde recibido o en preparación
