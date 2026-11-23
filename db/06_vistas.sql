-- =====================================================================
-- 06_vistas.sql · Vistas de análisis (P4)
--
-- Una vista es una consulta guardada con nombre: se usa como si fuera una
-- tabla, pero no guarda datos propios, se recalcula cada vez que se lee.
-- Por qué vistas y no repetir los JOIN en cada reporte:
--   1. Las reglas del negocio quedan escritas UNA vez (qué cuenta como venta,
--      cómo se calcula el tiempo de entrega). Si cambian, se cambian aquí.
--   2. Los procedimientos de 05_sp_reportes.sql y las consultas de
--      07_consultas.sql leen estas vistas en vez de recalcular.
--   3. Los atributos DERIVADOS (total, estado actual, tiempo de entrega) se
--      calculan con la misma definición de las funciones de 04_funciones.sql
--      (P3); ver la nota de rendimiento en vw_pedido_resumen.
--
-- Reglas de negocio de los reportes (supuestos de P4):
--   - "Venta" = pedido cuyo estado actual es "entregado". Los cancelados y
--     los que siguen en curso NO suman ventas.
--   - Ventas del restaurante = suma de las líneas (subtotal), SIN el costo de
--     envío: el envío lo cobra la plataforma, no el restaurante.
--   - Tiempo de entrega = minutos entre "recibido" y "entregado"
--     (fn_tiempo_entrega); NULL si el pedido no se ha entregado.
--
-- Orden: vw_pedido_resumen primero, porque las demás se construyen sobre ella.
-- =====================================================================
USE domicilios;

DROP VIEW IF EXISTS vw_producto_ventas;
DROP VIEW IF EXISTS vw_ventas_mensuales;
DROP VIEW IF EXISTS vw_tiempo_entrega_zona;
DROP VIEW IF EXISTS vw_desempeno_repartidor;
DROP VIEW IF EXISTS vw_ventas_restaurante;
DROP VIEW IF EXISTS vw_pedido_resumen;

-- ---------------------------------------------------------------------
-- vw_pedido_resumen · UNA fila por pedido con todo lo necesario para
-- analizarlo: quién pidió, a quién, quién lo llevó, cuándo se creó, en qué
-- estado está, cuánto costó, cuánto tardó y cómo lo calificaron.
--
-- Atributos DERIVADOS (total, estado actual, tiempo de entrega):
-- se calculan con la MISMA definición de las funciones de 04_funciones.sql
-- (P3), pero con JOIN sobre tablas agrupadas en vez de llamar la función
-- fila por fila. Motivo medido con npm run db:perf (5.250 pedidos):
-- llamando fn_total_pedido / fn_estado_actual / fn_tiempo_entrega por fila,
-- cada reporte tardaba 0,8 a 1,7 s (la página completa ~6 s), porque cada
-- llamada ejecuta sus propios SELECT: miles de consultas pequeñas. Con JOIN
-- MySQL recorre cada tabla una sola vez.
-- Las funciones siguen siendo la definición oficial para UN pedido (panel de
-- pedidos, seguimiento) y tests/pedidos.test.js comprueba que esta vista y
-- las funciones dan exactamente lo mismo para todos los pedidos.
--
--   - lineas:  suma de cantidad × precio_unitario por pedido (= fn_total_pedido sin envío)
--   - ult:     mayor secuencia del historial = estado actual (= fn_estado_actual)
--   - ini:     secuencia 1, que trg_historial_bi obliga a que sea "recibido"
--   - ent:     fila "entregado" del historial, si existe (= fn_tiempo_entrega)
--   - LEFT JOIN a REPARTIDOR: un pedido recién recibido aún no tiene repartidor.
--   - LEFT JOIN a CALIFICACION: la mayoría de pedidos no entregados no tienen nota.
--
-- Las demás vistas filtran por id_estado_actual (4 = entregado, 5 = cancelado)
-- y no por el texto del estado: comparar el texto que devuelve
-- fn_estado_actual con un literal falla con "Illegal mix of collations"
-- cuando el script corre desde Node (npm run db:setup), porque la conexión
-- usa otra collation que la base. El id no tiene ese problema.
-- ---------------------------------------------------------------------
CREATE VIEW vw_pedido_resumen AS
SELECT pe.id_pedido,
       pe.id_cliente,
       CONCAT_WS(' ', c.nombres, c.primer_apellido)       AS cliente,
       pe.id_restaurante,
       r.nombre                                           AS restaurante,
       pe.id_repartidor,
       CONCAT_WS(' ', rep.nombres, rep.primer_apellido)   AS repartidor,
       pe.ciudad,
       pe.barrio,
       pe.metodo_pago,
       ini.fecha_hora                                     AS fecha_creacion,
       est.id_estado                                      AS id_estado_actual,
       est.nombre                                         AS estado_actual,
       COALESCE(lineas.subtotal, 0)                       AS subtotal,
       pe.costo_envio,
       COALESCE(lineas.subtotal, 0) + pe.costo_envio      AS total,
       TIMESTAMPDIFF(MINUTE, ini.fecha_hora, ent.fecha_hora) AS tiempo_entrega_min,
       cal.nota_restaurante,
       cal.nota_repartidor
  FROM PEDIDO pe
  JOIN CLIENTE c            ON c.id_cliente     = pe.id_cliente
  JOIN RESTAURANTE r        ON r.id_restaurante = pe.id_restaurante
  JOIN HISTORIAL_ESTADO ini ON ini.id_pedido    = pe.id_pedido AND ini.secuencia = 1
  JOIN (SELECT id_pedido, MAX(secuencia) AS secuencia
          FROM HISTORIAL_ESTADO
         GROUP BY id_pedido) ult       ON ult.id_pedido = pe.id_pedido
  JOIN HISTORIAL_ESTADO hu  ON hu.id_pedido     = ult.id_pedido AND hu.secuencia = ult.secuencia
  JOIN ESTADO est           ON est.id_estado    = hu.id_estado
  LEFT JOIN (SELECT id_pedido, SUM(cantidad * precio_unitario) AS subtotal
               FROM DETALLE_PEDIDO
              GROUP BY id_pedido) lineas ON lineas.id_pedido = pe.id_pedido
  LEFT JOIN HISTORIAL_ESTADO ent ON ent.id_pedido = pe.id_pedido AND ent.id_estado = 4
  LEFT JOIN REPARTIDOR rep   ON rep.id_repartidor = pe.id_repartidor
  LEFT JOIN CALIFICACION cal ON cal.id_pedido     = pe.id_pedido;

-- ---------------------------------------------------------------------
-- vw_ventas_restaurante · desempeño comercial de cada restaurante.
-- LEFT JOIN desde RESTAURANTE: los restaurantes SIN pedidos también salen
-- (con 0), porque "no vende nada" también es información para el negocio.
-- CAST(... AS SIGNED): SUM() en MySQL devuelve DECIMAL; se convierte a entero
-- para que la aplicación reciba números y no texto.
-- ---------------------------------------------------------------------
CREATE VIEW vw_ventas_restaurante AS
SELECT r.id_restaurante,
       r.nombre,
       r.nit,
       COUNT(v.id_pedido)                                                        AS pedidos_totales,
       CAST(COALESCE(SUM(v.id_estado_actual = 4), 0) AS SIGNED)          AS pedidos_entregados,
       CAST(COALESCE(SUM(v.id_estado_actual = 5), 0) AS SIGNED)          AS pedidos_cancelados,
       CAST(COALESCE(SUM(CASE WHEN v.id_estado_actual = 4 THEN v.subtotal END), 0) AS SIGNED) AS ventas,
       CAST(ROUND(AVG(CASE WHEN v.id_estado_actual = 4 THEN v.subtotal END)) AS SIGNED)       AS ticket_promedio,
       ROUND(AVG(v.nota_restaurante), 2)                                         AS calificacion_promedio,
       COUNT(v.nota_restaurante)                                                 AS num_calificaciones,
       CAST(ROUND(AVG(v.tiempo_entrega_min)) AS SIGNED)                          AS tiempo_promedio_min
  FROM RESTAURANTE r
  LEFT JOIN vw_pedido_resumen v ON v.id_restaurante = r.id_restaurante
 GROUP BY r.id_restaurante, r.nombre, r.nit;

-- ---------------------------------------------------------------------
-- vw_desempeno_repartidor · entregas, nota promedio y rapidez por repartidor.
-- LEFT JOIN desde REPARTIDOR: los recién ingresados sin pedidos salen con 0.
-- num_calificaciones se expone para no premiar a quien tiene UNA sola nota de
-- 5,0 (el reporte filtra por un mínimo de calificaciones).
-- ---------------------------------------------------------------------
CREATE VIEW vw_desempeno_repartidor AS
SELECT rep.id_repartidor,
       rep.nombres,
       rep.primer_apellido,
       rep.tipo_vehiculo,
       rep.placa,
       COUNT(v.id_pedido)                                               AS pedidos_asignados,
       CAST(COALESCE(SUM(v.id_estado_actual = 4), 0) AS SIGNED) AS entregas,
       ROUND(AVG(v.nota_repartidor), 2)                                 AS calificacion_promedio,
       COUNT(v.nota_repartidor)                                         AS num_calificaciones,
       CAST(ROUND(AVG(v.tiempo_entrega_min)) AS SIGNED)                 AS tiempo_promedio_min
  FROM REPARTIDOR rep
  LEFT JOIN vw_pedido_resumen v ON v.id_repartidor = rep.id_repartidor
 GROUP BY rep.id_repartidor, rep.nombres, rep.primer_apellido, rep.tipo_vehiculo, rep.placa;

-- ---------------------------------------------------------------------
-- vw_tiempo_entrega_zona · tiempo de entrega por ciudad y barrio.
-- Solo pedidos entregados (los demás no tienen tiempo de entrega).
-- ---------------------------------------------------------------------
CREATE VIEW vw_tiempo_entrega_zona AS
SELECT v.ciudad,
       v.barrio,
       COUNT(*)                                       AS entregas,
       CAST(ROUND(AVG(v.tiempo_entrega_min)) AS SIGNED) AS tiempo_promedio_min,
       MIN(v.tiempo_entrega_min)                      AS tiempo_minimo_min,
       MAX(v.tiempo_entrega_min)                      AS tiempo_maximo_min
  FROM vw_pedido_resumen v
 WHERE v.id_estado_actual = 4
 GROUP BY v.ciudad, v.barrio;

-- ---------------------------------------------------------------------
-- vw_ventas_mensuales · evolución del negocio mes a mes (por fecha de creación).
-- ---------------------------------------------------------------------
CREATE VIEW vw_ventas_mensuales AS
SELECT DATE_FORMAT(v.fecha_creacion, '%Y-%m')                                    AS mes,
       COUNT(*)                                                                  AS pedidos,
       CAST(SUM(v.id_estado_actual = 4) AS SIGNED)                       AS entregados,
       CAST(SUM(v.id_estado_actual = 5) AS SIGNED)                       AS cancelados,
       CAST(COALESCE(SUM(CASE WHEN v.id_estado_actual = 4 THEN v.subtotal END), 0) AS SIGNED)    AS ventas,
       CAST(COALESCE(SUM(CASE WHEN v.id_estado_actual = 4 THEN v.costo_envio END), 0) AS SIGNED) AS ingresos_envio,
       CAST(ROUND(AVG(CASE WHEN v.id_estado_actual = 4 THEN v.subtotal END)) AS SIGNED)          AS ticket_promedio
  FROM vw_pedido_resumen v
 GROUP BY DATE_FORMAT(v.fecha_creacion, '%Y-%m');

-- ---------------------------------------------------------------------
-- vw_producto_ventas · unidades e ingresos de cada producto en pedidos
-- ENTREGADOS. LEFT JOIN: los productos nunca vendidos salen con 0.
-- es_combo es derivado (avance, sección 2): un producto es combo si aparece
-- como id_combo en COMBO_COMPONENTE.
-- ---------------------------------------------------------------------
CREATE VIEW vw_producto_ventas AS
SELECT p.id_producto,
       p.id_restaurante,
       r.nombre                                                   AS restaurante,
       p.nombre                                                   AS producto,
       cat.nombre                                                 AS categoria,
       p.precio,
       p.disponible,
       EXISTS (SELECT 1 FROM COMBO_COMPONENTE cc WHERE cc.id_combo = p.id_producto) AS es_combo,
       CAST(COALESCE(SUM(vend.cantidad), 0) AS SIGNED)                              AS unidades_vendidas,
       CAST(COALESCE(SUM(vend.cantidad * vend.precio_unitario), 0) AS SIGNED)       AS ingresos
  FROM PRODUCTO p
  JOIN RESTAURANTE r  ON r.id_restaurante = p.id_restaurante
  JOIN CATEGORIA cat  ON cat.id_categoria = p.id_categoria
  LEFT JOIN (
        -- Líneas de pedidos entregados. "entregado" es un estado FINAL (el trigger
        -- trg_historial_bi no admite nada después), así que tener una fila
        -- "entregado" en el historial equivale a que ese sea el estado actual.
        -- Así se usa el índice UNIQUE (id_pedido, id_estado) en vez de llamar
        -- una función por cada línea.
        SELECT dp.id_producto, dp.cantidad, dp.precio_unitario
          FROM DETALLE_PEDIDO dp
          JOIN HISTORIAL_ESTADO h ON h.id_pedido = dp.id_pedido AND h.id_estado = 4
       ) vend ON vend.id_producto = p.id_producto
 GROUP BY p.id_producto, p.id_restaurante, r.nombre, p.nombre, cat.nombre, p.precio, p.disponible;
