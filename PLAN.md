# Plan de trabajo · Caso 7 Servicio de domicilios · Pista Ingeniería Informática

Entrega final: **viernes 27 de noviembre de 2026** (sección 6.2 del enunciado; la tabla de hitos dice jueves 19, confirmar con el profesor).
Equipo: Samuel Gerena (P1) · Samuel Hernández (P2) · Juan Andrés Galarza (P3) · Tomás Sarmiento (P4).

## 1. Stack y por qué

| Capa | Elección | Motivo |
|---|---|---|
| Base de datos | MySQL 8.0.16+ | Lo exige el avance (CHECK se aplica desde 8.0.16). |
| Backend | Node.js 20 LTS + Express | Un solo lenguaje, `npm install && npm start`, sin compilación. |
| Vistas | EJS renderizado en servidor + CSS propio | Sin build de frontend: el profesor no necesita Vite ni React para levantarlo. |
| Driver | `mysql2/promise` con pool | Soporta `CALL` y parámetros con `?` (sin concatenar SQL). |
| Validación | `zod` | Valida en la app antes de llegar a MySQL (requisito 4.2). |
| Pruebas | `vitest` + `supertest` | Pruebas de integración contra una BD de prueba. |
| Fuentes | `@fontsource/ibm-plex-*` | Se sirven desde `node_modules`: funcionan sin internet. |

Regla de oro (enunciado 4.2): **la app solo ejecuta `CALL sp_...`**. Nada de `SELECT`/`INSERT` sueltos en el código JS.

Commits: **uno por persona**, en orden P1 → P2/P3/P4. Antes de empezar, `git pull`; antes de hacer push, `npm run db:setup` y `npm start` deben funcionar.

## 2. Estructura del repositorio

```
proyecto-bases/
├── db/
│   ├── 00_run_all.sql          # ejecuta todo en orden sobre BD vacía (se prueba en la sustentación)
│   ├── 01_ddl.sql              # 12 tablas, PK/FK, CHECK, UNIQUE compuesta, DEFAULT
│   ├── 02_triggers.sql         # reglas entre tablas con SIGNAL SQLSTATE '45000'
│   ├── 03_seed.sql             # catálogo ESTADO + datos realistas (≥50 / ≥150 filas)
│   ├── 04_funciones.sql        # fn_edad (P1) + fn_total_pedido, fn_estado_actual, fn_tiempo_entrega (P3)
│   ├── 05_sp_clientes.sql      # P1 · un archivo de procedimientos por módulo
│   ├── 05_sp_catalogo.sql      # P2
│   ├── 05_sp_pedidos.sql       # P3
│   ├── 05_sp_reportes.sql      # P4
│   ├── 06_vistas.sql
│   ├── 07_consultas.sql        # banco de consultas (13 temas × 3)
│   ├── 08_transacciones.sql    # 2 transacciones con COMMIT y demo de ROLLBACK
│   ├── 09_indices.sql          # índices + EXPLAIN antes/después
│   └── perf/generar_5000.sql   # carga sintética para la prueba de rendimiento
├── app/
│   ├── server.js
│   ├── db/pool.js · errores.js # callProc() + traducción de errores MySQL a mensajes claros
│   ├── routes/                 # clientes, restaurantes, productos, repartidores, pedidos, reportes
│   ├── validators/             # esquemas zod por entidad
│   ├── views/                  # EJS: layout, parciales, una carpeta por módulo
│   └── public/css/             # tokens.css + base.css (sistema visual, ya creado)
├── tests/                      # ≥5 pruebas, incluida una que demuestra el ROLLBACK
├── docs/
│   ├── arquitectura.md         # conexión, seguridad, errores, diagrama de flujo
│   ├── indices.md              # evidencia EXPLAIN y tiempos con/sin índice
│   └── style-guide.html        # muestra viva del sistema visual
├── .env.example
├── PRODUCT.md · DESIGN.md      # contexto de diseño
└── README.md                   # instalación paso a paso desde cero
```

## 3. Reparto

El orden importa: P1 deja la base sobre la que trabajan los demás. P2, P3 y P4 pueden avanzar en paralelo cuando P1 haga push.

### P1 · Samuel Gerena: fundación (primero)
Lo que todo lo demás necesita para existir.

1. Estructura del repo, `.gitignore` (node_modules, .env), `.env.example`, `package.json`.
2. `01_ddl.sql`: las 12 tablas del avance tal cual (CHECK ×3+, UNIQUE compuesta, DEFAULT, FKs con sus ON DELETE).
3. `02_triggers.sql`: las reglas de la sección 5 del avance (productos del mismo restaurante, combos de un nivel, secuencia consecutiva, flujo de estados, repartidor obligatorio para "en camino", calificar solo entregados).
4. Catálogo `ESTADO` (5 filas fijas) y `00_run_all.sql`.
5. App base: `server.js`, `db/pool.js` con `callProc()` y traducción de `SQLSTATE 45000` a mensajes claros, layout EJS, navegación y el sistema visual.
6. **Módulo de referencia completo: Clientes** (con teléfonos multivaluados): `sp_cliente_crear/listar/obtener/actualizar/eliminar`, validación zod, rutas y vistas. Es la plantilla que copian los demás.
7. README inicial (cómo levantar MySQL, crear la BD, `npm start`).

### P2 · Samuel Hernández: catálogo y datos
1. Módulos Restaurantes, Categorías, Productos y Combos (SPs + validación + vistas, siguiendo el patrón de Clientes). Producto vendido no se borra: `disponible = FALSE`.
2. `03_seed.sql`: datos realistas de Villavicencio/Bogotá. Mínimos: tablas principales ≥50 filas (CLIENTE, RESTAURANTE, PRODUCTO, REPARTIDOR), transaccionales ≥150 (PEDIDO, DETALLE_PEDIDO, HISTORIAL_ESTADO, CALIFICACION). El historial debe respetar los triggers.
3. `perf/generar_5000.sql` (procedimiento con bucle) + `09_indices.sql` + `docs/indices.md`: dos índices (sugeridos: `HISTORIAL_ESTADO(id_estado, fecha_hora)` y `PEDIDO(id_restaurante)` o `PEDIDO(id_cliente)`), EXPLAIN y tiempos con y sin índice.

### P3 · Juan Andrés Galarza: pedidos y transacciones (núcleo del negocio)
1. Módulo Repartidores (CRUD; placa nula solo si es bicicleta).
2. Funciones usadas en SELECT: `fn_total_pedido`, `fn_estado_actual`, `fn_tiempo_entrega` (agregarlas a `04_funciones.sql`, donde ya está `fn_edad`).
3. Transacción 1 `sp_pedido_crear`: inserta PEDIDO + DETALLE_PEDIDO (n líneas, recibidas como JSON) + HISTORIAL "recibido". Todo o nada.
4. Transacción 2 `sp_pedido_avanzar_estado` con IF/ELSEIF: asigna repartidor si pasa a "en camino", inserta historial, cancela solo desde recibido/preparación. Más `sp_calificar_pedido`.
5. `SIGNAL SQLSTATE` con mensajes específicos (pedido inexistente, producto de otro restaurante, transición inválida).
6. Pantallas: lista de pedidos con filtro por estado, formulario de nuevo pedido, detalle con la línea de tiempo del historial y botón para avanzar estado.
7. `08_transacciones.sql`: demostración manual de COMMIT y ROLLBACK.

### P4 · Tomás Sarmiento: consultas, reportes, pruebas y documentación
1. `06_vistas.sql` y `07_consultas.sql`: 3 consultas por tema (WHERE/ORDER BY, UPDATE, DELETE, INNER JOIN, agregación, GROUP BY, HAVING, subconsulta en WHERE, subconsulta en FROM, vista, LEFT/RIGHT JOIN, self-join, UNION). Cada una con comentario: pregunta de negocio + por qué esa herramienta.
   - Self-join natural del caso: `COMBO_COMPONENTE` con PRODUCTO dos veces, o pedidos del mismo cliente comparados entre sí.
2. Pantalla Reportes en la app (llama SPs que leen las vistas: ranking de restaurantes, repartidores mejor calificados, tiempo promedio de entrega).
3. `tests/`: mínimo 5 (validación zod rechaza datos malos; crear pedido válido; producto de otro restaurante → error claro; **fallo a mitad de `sp_pedido_crear` deja las tablas sin cambios**; transición de estado inválida).
4. `docs/arquitectura.md` (diagrama de punta a punta, qué valida la app y qué la BD y por qué, seguridad: usuario MySQL con solo `EXECUTE`, `.env`, consultas parametrizadas) y README final probado en una máquina limpia.

## 4. Cómo agregar tu módulo (copiando el patrón de Clientes)

1. **SQL** · crea `db/05_sp_<modulo>.sql` copiando la forma de `05_sp_clientes.sql`: `DROP PROCEDURE IF EXISTS`, `DELIMITER $$`, validaciones con `SIGNAL SQLSTATE '45000'` (regla de negocio) o `'45004'` (no existe), y `START TRANSACTION` + handler `ROLLBACK; RESIGNAL;` cuando toques varias tablas. Descomenta tu línea en `db/00_run_all.sql`.
2. **Validación** · `app/validators/<modulo>.js` con zod, reutilizando `comunes.js` (`textoObligatorio`, `fecha`, `telefono`...).
3. **Errores** · si tu tabla tiene UNIQUE o CHECK nuevos, agrega su nombre en `RESTRICCIONES` de `app/db/errores.js` (campo + mensaje).
4. **Rutas** · `app/routes/<modulo>.js` copiando `clientes.js` (listar, nuevo, crear, detalle, editar, eliminar). Solo `callProc(...)`.
5. **Vistas** · `app/views/<modulo>/` copiando las de clientes. Usa `partials/campo`, `partials/aviso` y las clases de `base.css` (`estado--*`, `riel`, `comanda` para pedidos).
6. **Conectar** · en `app/server.js` agrega `app.use('/<ruta>', router)` y en `app/navegacion.js` cambia `listo: true`.
7. **Probar** · `npm run db:setup && npm start` y recorrer crear, editar, un error de validación, un error de la BD y eliminar.

## 5. Reglas del equipo

- Commits con formato `feat(pedidos): ...` y mensaje que diga qué se hizo. Nadie hace `force push`.
- Nunca subir `.env`. Cada quien copia `.env.example`.
- Antes de cada push: `00_run_all.sql` corre sin errores sobre una BD vacía.
- Todos deben poder explicar todo: el viernes antes de la entrega, cada uno le explica su parte a los otros tres (el profesor pregunta a cualquiera).

## 6. Calendario sugerido

| Día | Hito |
|---|---|
| Vie 20 | P1: fundación + Clientes en `main` |
| Sáb 21 – Lun 23 | P2, P3, P4 en paralelo |
| Mar 24 | Integración: seed completo + pedidos + consultas en `main` |
| Mié 25 | Pruebas, índices con 5.000 filas, documentos |
| Jue 26 | README probado en un PC limpio + ensayo de sustentación |
| Vie 27 | Entrega |
