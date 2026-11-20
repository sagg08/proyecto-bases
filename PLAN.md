# Plan de trabajo · Caso 7 Servicio de domicilios · Pista Ingeniería Informática

Entrega final: **viernes 27 de noviembre de 2026** (sección 6.2 del enunciado; la tabla de hitos dice jueves 19, confirmar con el profesor).
Equipo: Samuel Gerena (P1) · Samuel Hernández (P2) · Juan Andrés Galarza (P3) · Tomás Sarmiento (P4).

## 0. Orden de trabajo (obligatorio)

| Turno | Quién | Empieza cuando | Debe dejar funcionando antes de avisar | Fecha límite |
|---|---|---|---|---|
| 1 | Samuel Gerena (P1) | Ya | BD base, app base, Clientes | ✅ Hecho |
| 2 | Samuel Hernández (P2) | Ya | Restaurantes, categorías, productos y combos en la app; `03_seed.sql` con todos los datos; `sp_restaurante_listar` y `sp_producto_menu` | Sáb 21 · 8 p. m. |
| 3 | Juan Andrés (P3) | P2 avisa | Repartidores; funciones; `sp_pedido_crear`, `sp_pedido_avanzar_estado`, `sp_calificar_pedido`; flujo Pedir y panel de Pedidos | Lun 23 · 8 p. m. |
| 4 | Tomás (P4) | P3 avisa | Vistas, banco de consultas, Reportes, pruebas, `docs/arquitectura.md`, README final y revisión visual | Mié 25 · 8 p. m. |
| — | Todos | P4 avisa | Ensayo de la sustentación: cada uno explica una parte que **no** hizo | Jue 26 |

**Al empezar tu turno**
```powershell
git pull
npm install
npm run db:setup      # recrea la BD con todo lo que subieron los anteriores
npm start             # comprueba que lo anterior funciona ANTES de tocar nada
```

**Antes de pasar el turno** (si algo falla, no se sube)
1. `npm run db:setup` termina sin errores sobre la BD vacía.
2. `npm start` y recorrer en el navegador lo tuyo **y** lo de los anteriores.
3. En Source Control no aparecen `.env` ni `node_modules`.
4. Un solo commit con mensaje claro → push → avisar en el grupo: "Listo P_, ya pueden hacer pull".

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

Commits: **uno por persona**, en orden P1 → P2 → P3 → P4 (sección 0). Antes de empezar, `git pull`; antes de hacer push, `npm run db:setup` y `npm start` deben funcionar.

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

**Se trabaja en serie: P1 → P2 → P3 → P4.** Cada uno usa lo que dejó el anterior (P3 necesita los restaurantes y productos de P2; P4 necesita los pedidos de P3 para consultas, reportes y pruebas). Nadie hace commit hasta que el anterior haya subido el suyo y avisado en el grupo. Mientras esperan, pueden leer el código y preparar su parte, pero sin subir nada.

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
1. Módulos Restaurantes, Categorías, Productos y Combos (SPs + validación + vistas, siguiendo el patrón de Clientes). Producto vendido no se borra: `disponible = FALSE`. Pautas visuales del **panel de operación** en la sección 4.
2. **Base del flujo Pedir** (sección 4), que luego usa P3:
   - `sp_restaurante_listar` debe devolver también las categorías que vende y su calificación promedio.
   - `sp_producto_menu(p_id_restaurante)`: productos agrupables por categoría, con `disponible` y, para los combos, sus componentes.
   - Componentes en `base.css`: tarjeta de restaurante (inicial + ícono, sin fotos) y fila de producto del menú con precio y botón **Agregar**.
3. `03_seed.sql`: datos realistas de Villavicencio/Bogotá. Mínimos: tablas principales ≥50 filas (CLIENTE, RESTAURANTE, PRODUCTO, REPARTIDOR), transaccionales ≥150 (PEDIDO, DETALLE_PEDIDO, HISTORIAL_ESTADO, CALIFICACION). El historial debe respetar los triggers.
4. `perf/generar_5000.sql` (procedimiento con bucle) + `09_indices.sql` + `docs/indices.md`: dos índices (sugeridos: `HISTORIAL_ESTADO(id_estado, fecha_hora)` y `PEDIDO(id_restaurante)` o `PEDIDO(id_cliente)`), EXPLAIN y tiempos con y sin índice.

### P3 · Juan Andrés Galarza: pedidos y transacciones (núcleo del negocio)
1. Módulo Repartidores (CRUD; placa nula solo si es bicicleta).
2. Funciones usadas en SELECT: `fn_total_pedido`, `fn_estado_actual`, `fn_tiempo_entrega` (agregarlas a `04_funciones.sql`, donde ya está `fn_edad`).
3. Transacción 1 `sp_pedido_crear`: inserta PEDIDO + DETALLE_PEDIDO (n líneas, recibidas como JSON) + HISTORIAL "recibido". Todo o nada.
4. Transacción 2 `sp_pedido_avanzar_estado` con IF/ELSEIF: asigna repartidor si pasa a "en camino", inserta historial, cancela solo desde recibido/preparación. Más `sp_calificar_pedido`.
5. `SIGNAL SQLSTATE` con mensajes específicos (pedido inexistente, producto de otro restaurante, transición inválida).
6. Pantallas (sección 4):
   - **Flujo Pedir** tipo Rappi en `/pedir`: elegir cliente → restaurantes → menú (reutiliza lo de P2) → carrito → confirmar con `sp_pedido_crear` → seguimiento con el `riel` → calificar con estrellas. Agregar el grupo "Pedir" en `navegacion.js`.
   - **Panel de pedidos**: pestañas por estado, detalle con la línea de tiempo y un botón con la siguiente acción.
   - Componentes nuevos en `base.css`: carrito, selector de método de pago, estrellas.
7. `08_transacciones.sql`: demostración manual de COMMIT y ROLLBACK.

### P4 · Tomás Sarmiento: consultas, reportes, pruebas y documentación
1. `06_vistas.sql` y `07_consultas.sql`: 3 consultas por tema (WHERE/ORDER BY, UPDATE, DELETE, INNER JOIN, agregación, GROUP BY, HAVING, subconsulta en WHERE, subconsulta en FROM, vista, LEFT/RIGHT JOIN, self-join, UNION). Cada una con comentario: pregunta de negocio + por qué esa herramienta.
   - Self-join natural del caso: `COMBO_COMPONENTE` con PRODUCTO dos veces, o pedidos del mismo cliente comparados entre sí.
2. Pantalla Reportes en la app (llama SPs que leen las vistas: ranking de restaurantes, repartidores mejor calificados, tiempo promedio de entrega). Cada reporte con la pregunta de negocio como título, tabla y barras horizontales en CSS (sección 4).
3. `tests/`: mínimo 5 (validación zod rechaza datos malos; crear pedido válido; producto de otro restaurante → error claro; **fallo a mitad de `sp_pedido_crear` deja las tablas sin cambios**; transición de estado inválida).
4. `docs/arquitectura.md` (diagrama de punta a punta, qué valida la app y qué la BD y por qué, seguridad: usuario MySQL con solo `EXECUTE`, `.env`, consultas parametrizadas) y README final probado en una máquina limpia.
5. **Revisión final de la interfaz**: recorrer el flujo Pedir y cada módulo del panel a 1440 px y 390 px, y corregir lo que no siga las reglas de la sección 4. Ensayar con el grupo la demo de sustentación (pedir como cliente → avanzar estados en el panel → provocar un error de trigger).

## 4. Guía visual: dos caras de la misma app

El enunciado exige que el profesor pueda **crear, consultar, actualizar y eliminar** sin SQL; eso es el **panel de operación** (lo que ya existe con Clientes). Pero el corazón del caso es **pedir un domicilio**, así que ese flujo se diseña como lo vería un cliente en Rappi. Las dos caras usan el mismo sistema visual (`tokens.css` + `base.css`) y los mismos procedimientos almacenados.

| Cara | Para qué | Módulos |
|---|---|---|
| **Pedir** (vista cliente, tipo Rappi) | Hacer un pedido de punta a punta y seguirlo | `/pedir` (P3), reutiliza restaurantes y productos de P2 |
| **Operación** (panel) | CRUD completo de cada tabla y reportes | Clientes, Restaurantes, Productos, Repartidores, Pedidos, Reportes |

### Flujo "Pedir" (P3, apoyado en las vistas de P2)
1. **¿Quién pide?** Selector de cliente (simula "iniciar sesión"; no hay login real).
2. **Restaurantes** · lista con nombre, categorías que vende y calificación promedio (`★ 4,6`). Sin fotos: inicial del restaurante en un bloque de color + ícono de su categoría principal.
3. **Menú** · productos agrupados por categoría, precio en `mono`, botón **Agregar**; los combos muestran qué incluyen. Productos con `disponible = FALSE` aparecen atenuados y sin botón.
4. **Carrito** · columna fija a la derecha (abajo en móvil) con cantidades `− 2 +`, subtotal, costo de envío y total en COP. Solo admite productos de un restaurante (regla del caso): si se cambia de restaurante, avisar en línea que el carrito se vacía.
5. **Confirmar** · dirección por partes (calle, número, barrio, ciudad) y método de pago como tres opciones grandes (efectivo, tarjeta, transferencia). Al enviar → `sp_pedido_crear` (transacción). Si falla, el mensaje de MySQL se muestra arriba del botón y el carrito se conserva.
6. **Seguimiento** · página del pedido con el `riel` de estados y la `comanda`. Cuando está entregado, aparece **Calificar** con dos filas de 5 estrellas (restaurante y repartidor) y comentario opcional.

En `app/navegacion.js` se agrega un grupo arriba de todo: `{ grupo: 'Pedir', items: [{ ruta: '/pedir', texto: 'Pedir a domicilio', icono: 'tienda' }] }`.

### Panel de operación: pautas por módulo
- **Restaurantes (P2)** · lista con NIT en `mono` y nº de productos; el detalle muestra su menú (lo mismo que reutiliza `/pedir`).
- **Productos (P2)** · filtro por restaurante y categoría; etiqueta `combo` y, en el detalle, sus componentes con cantidad. "Eliminar" un producto vendido = marcar no disponible (explicarlo en el botón).
- **Repartidores (P3)** · ícono del vehículo + placa en `mono` (o "sin placa" para bicicleta); el formulario oculta el campo placa cuando eligen bicicleta.
- **Pedidos (P3)** · pestañas por estado arriba de la tabla (`Todos · Recibido · En preparación · En camino · Entregado · Cancelado`) usando las etiquetas `estado--*`; el detalle tiene un único botón principal con la siguiente acción ("Pasar a en camino") y, si falta repartidor, un selector en línea antes del botón.
- **Reportes (P4)** · cada reporte = título con la pregunta de negocio + tabla. Para comparar (ventas por restaurante, notas por repartidor) usar barras horizontales hechas con CSS (`width` en %), sin librerías de gráficos.

### Reglas para no romper la consistencia
- Solo colores y tamaños de `tokens.css`; nada de `#hex` sueltos en las vistas.
- Un componente nuevo (tarjeta de restaurante, carrito, estrellas) va en `base.css` con un comentario, para que los demás lo reutilicen.
- Sin fotos descargadas de internet (derechos de autor y peso del repo): iniciales, íconos SVG y color.
- Íconos solo del set de `partials/iconos.ejs`; si falta uno, se agrega ahí con el mismo trazo.
- Revisar cada pantalla a 1440 px y a 390 px de ancho antes del commit.

## 5. Cómo agregar tu módulo (copiando el patrón de Clientes)

1. **SQL** · crea `db/05_sp_<modulo>.sql` copiando la forma de `05_sp_clientes.sql`: `DROP PROCEDURE IF EXISTS`, `DELIMITER $$`, validaciones con `SIGNAL SQLSTATE '45000'` (regla de negocio) o `'45004'` (no existe), y `START TRANSACTION` + handler `ROLLBACK; RESIGNAL;` cuando toques varias tablas. Descomenta tu línea en `db/00_run_all.sql`.
2. **Validación** · `app/validators/<modulo>.js` con zod, reutilizando `comunes.js` (`textoObligatorio`, `fecha`, `telefono`...).
3. **Errores** · si tu tabla tiene UNIQUE o CHECK nuevos, agrega su nombre en `RESTRICCIONES` de `app/db/errores.js` (campo + mensaje).
4. **Rutas** · `app/routes/<modulo>.js` copiando `clientes.js` (listar, nuevo, crear, detalle, editar, eliminar). Solo `callProc(...)`.
5. **Vistas** · `app/views/<modulo>/` copiando las de clientes. Usa `partials/campo`, `partials/aviso` y las clases de `base.css` (`estado--*`, `riel`, `comanda` para pedidos).
6. **Conectar** · en `app/server.js` agrega `app.use('/<ruta>', router)` y en `app/navegacion.js` cambia `listo: true`.
7. **Probar** · `npm run db:setup && npm start` y recorrer crear, editar, un error de validación, un error de la BD y eliminar.

## 6. Reglas del equipo

- Commits con formato `feat(pedidos): ...` y mensaje que diga qué se hizo. Nadie hace `force push`.
- Nunca subir `.env`. Cada quien copia `.env.example`.
- Antes de cada push: `00_run_all.sql` corre sin errores sobre una BD vacía.
- Todos deben poder explicar todo: el viernes antes de la entrega, cada uno le explica su parte a los otros tres (el profesor pregunta a cualquiera).

## 7. Calendario

Ver la tabla de la sección 0. Entrega: viernes 27 de noviembre.
