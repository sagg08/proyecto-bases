/**
 * app/lib/formato.js · Formatos de presentación para las vistas EJS.
 * Se exponen en res.locals.fmt, así en cualquier vista: <%= fmt.cop(total) %>
 */
const cop = new Intl.NumberFormat('es-CO', { style: 'currency', currency: 'COP', maximumFractionDigits: 0 });
const opcionesFecha = { day: 'numeric', month: 'short', year: 'numeric' };
const fechaLarga = new Intl.DateTimeFormat('es-CO', opcionesFecha);
const fechaSolo = new Intl.DateTimeFormat('es-CO', { ...opcionesFecha, timeZone: 'UTC' });

export const fmt = {
  /** 97500 → "$ 97.500" */
  cop: (n) => (n == null ? '' : cop.format(n)),

  /** "2026-11-20" o "2026-11-20 14:16:27" → "20 nov 2026" */
  fecha: (valor) => {
    if (!valor) return '';
    if (typeof valor === 'string') {
      const soloFecha = /^(\d{4})-(\d{2})-(\d{2})$/.exec(valor);
      if (soloFecha) {
        const [, anio, mes, dia] = soloFecha;
        return fechaSolo.format(new Date(Date.UTC(Number(anio), Number(mes) - 1, Number(dia))));
      }
      return fechaLarga.format(new Date(valor.replace(' ', 'T')));
    }
    return fechaLarga.format(valor);
  },

  /** "2026-11-20 14:16:27" → "14:16" */
  hora: (texto) => (texto ? String(texto).slice(11, 16) : ''),

  /** 42 → "#0042" (ids de pedido y similares) */
  id: (n) => `#${String(n).padStart(4, '0')}`,

  /** Nombre compuesto a partir de sus partes */
  nombre: (r) => [r.nombres, r.primer_apellido, r.segundo_apellido].filter(Boolean).join(' '),
};
