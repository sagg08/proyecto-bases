/**
 * app/lib/formato.js · Formatos de presentación para las vistas EJS.
 * Se exponen en res.locals.fmt, así en cualquier vista: <%= fmt.cop(total) %>
 */
const cop = new Intl.NumberFormat('es-CO', { style: 'currency', currency: 'COP', maximumFractionDigits: 0 });
const fechaLarga = new Intl.DateTimeFormat('es-CO', { day: 'numeric', month: 'short', year: 'numeric' });

export const fmt = {
  /** 97500 → "$ 97.500" */
  cop: (n) => (n == null ? '' : cop.format(n)),

  /** "2026-11-20" o "2026-11-20 14:16:27" → "20 nov 2026" */
  fecha: (texto) => (texto ? fechaLarga.format(new Date(String(texto).replace(' ', 'T'))) : ''),

  /** "2026-11-20 14:16:27" → "14:16" */
  hora: (texto) => (texto ? String(texto).slice(11, 16) : ''),

  /** 42 → "#0042" (ids de pedido y similares) */
  id: (n) => `#${String(n).padStart(4, '0')}`,

  /** Nombre compuesto a partir de sus partes */
  nombre: (r) => [r.nombres, r.primer_apellido, r.segundo_apellido].filter(Boolean).join(' '),
};
