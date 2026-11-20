# DESIGN · Sistema visual "Comanda"

Escena: el profesor opera la app en un portátil, en un salón iluminado de día, con el grupo mirando. Necesita legibilidad alta y cero ambigüedad → **tema claro**, papel cálido, tinta oscura.

Archivos: `app/public/css/tokens.css` (variables) y `app/public/css/base.css` (componentes). Muestra viva: `docs/style-guide.html`.

## Color (OKLCH, estrategia *restrained* + paleta semántica de estados)
| Token | Uso |
|---|---|
| `--paper` / `--surface` / `--sunken` | Fondo de página, superficies, zonas hundidas (encabezados de tabla, inputs) |
| `--ink` / `--ink-2` / `--ink-3` | Texto principal, secundario, terciario (todos ≥ 4.5:1 sobre `--paper`) |
| `--line` / `--line-strong` | Bordes y divisores |
| `--accent` (mora) | Acción principal, foco, enlaces. Máximo ~10 % de la superficie |
| `--st-recibido` … `--st-cancelado` | Un tono por estado del pedido. **Siempre con texto**, nunca solo color |
| `--danger` / `--ok` | Errores y confirmaciones |

Neutros teñidos hacia el cálido (hue 75). No se usa `#000` ni `#fff`.

## Tipografía
- **IBM Plex Sans**: interfaz. Escala 1.25: 13 · 14 · 16 · 20 · 25 · 31 px.
- **IBM Plex Mono**: IDs (`#0042`), precios COP, fechas y horas. `font-variant-numeric: tabular-nums`.
- Texto largo máx. 70ch.

## Espaciado y forma
Escala de 4 px (`--s-1` = 4 … `--s-8` = 64). Radio pequeño (4/6 px): papel, no burbujas. Sombras casi nulas; la jerarquía la dan bordes y fondo hundido.

## Componentes base
Botones (primario, secundario, peligro, fantasma) · campos con etiqueta visible, ayuda y error debajo · tabla con números alineados a la derecha · `estado` (etiqueta con punto + texto) · `riel` (línea de tiempo del historial de estados) · aviso en línea (`aviso--error`, `aviso--ok`) con `role="alert"`/`status` · barra lateral de navegación con estado activo.

## Reglas
- Sin bordes laterales de color como acento, sin texto con degradado, sin glassmorphism, sin modales como primera opción (confirmaciones en línea).
- Foco visible en todo (`:focus-visible`, anillo de 2 px en `--accent`).
- Objetivos táctiles ≥ 40 px de alto.
- Animación solo de `opacity`/`transform`, 150–250 ms, `ease-out`; se desactiva con `prefers-reduced-motion`.
- Sin guiones largos en los textos de la interfaz.
