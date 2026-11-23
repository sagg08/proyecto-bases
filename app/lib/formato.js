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

  /**
   * "2026-11-20 14:16:27" o un Date → "14:16".
   * Los DATETIME llegan de mysql2 como Date (pool.js solo convierte DATE a texto);
   * antes se cortaba String(date), que da "Fri Nov 20 2026 ..." y mostraba el año.
   */
  hora: (valor) => {
    if (!valor) return '';
    if (valor instanceof Date) {
      return `${String(valor.getHours()).padStart(2, '0')}:${String(valor.getMinutes()).padStart(2, '0')}`;
    }
    return String(valor).slice(11, 16);
  },

  /** Dirección por partes. El número ya suele traer "#" ("# 5-23"): no se repite. */
  direccion: (p) => {
    const numero = String(p.numero ?? '').trim();
    return `${p.calle} ${numero.startsWith('#') ? numero : `# ${numero}`}, ${p.barrio}, ${p.ciudad}`;
  },

  /** 42 → "#0042" (ids de pedido y similares) */
  id: (n) => `#${String(n).padStart(4, '0')}`,

  /** Nombre compuesto a partir de sus partes */
  nombre: (r) => [r.nombres, r.primer_apellido, r.segundo_apellido].filter(Boolean).join(' '),

  /** "4.25" o 4.25 → "4,3" (MySQL devuelve AVG/ROUND como texto DECIMAL); '' si es null */
  decimal: (n, digitos = 1) => (n == null ? '' : Number(n).toLocaleString('es-CO', {
    minimumFractionDigits: digitos, maximumFractionDigits: digitos,
  })),

  /** 59 → "59 min"; '' si es null */
  minutos: (n) => (n == null ? '' : `${n} min`),

  /** "2026-08" → "ago 2026" */
  mes: (texto) => {
    const m = /^(\d{4})-(\d{2})$/.exec(texto ?? '');
    if (!m) return texto ?? '';
    return new Intl.DateTimeFormat('es-CO', { month: 'short', year: 'numeric', timeZone: 'UTC' })
      .format(new Date(Date.UTC(Number(m[1]), Number(m[2]) - 1, 1)))
      .replace(/\.?\s*de\s*/, ' ');
  },

  /** 4 → "★★★★☆" (redondeo al entero más cercano; '' si no hay calificación) */
  estrellas: (n) => {
    if (n == null) return '';
    const llenas = Math.min(5, Math.max(0, Math.round(Number(n))));
    return '★'.repeat(llenas) + '☆'.repeat(5 - llenas);
  },
};
