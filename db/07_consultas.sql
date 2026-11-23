-- =====================================================================
-- 07_consultas.sql · Banco de consultas (P4) · 13 temas × 3 consultas
--
-- Cada consulta lleva: la PREGUNTA DE NEGOCIO que responde y POR QUÉ se usa
-- esa herramienta de SQL y no otra.
--
-- Cómo correrlo:
--   - MySQL Workbench: abrir el archivo y ejecutar consulta por consulta
--     (Ctrl + Enter con el cursor encima) para ver cada resultado.
--   - Consola: mysql -u root -p --default-character-set=utf8mb4 domicilios < db/07_consultas.sql
--
-- NO está en 00_run_all.sql a propósito: es material de consulta, no parte de
-- la creación de la base. Aun así se puede correr cuantas veces se quiera:
--   - Las secciones UPDATE y DELETE van dentro de START TRANSACTION ... ROLLBACK:
--     se ve el antes y el después, y al final se deshace todo. Así el archivo
--     no daña los datos de prueba ni cambia los números de los reportes.
--   - tests/pedidos.test.js ejecuta este archivo completo contra la base de
--     prueba y comprueba que todas las consultas corren y que los datos quedan
--     iguales.
--
-- Requiere la base creada con npm run db:setup (usa las vistas de 06_vistas.sql).
-- Estados del catálogo ESTADO: 1 recibido, 2 en preparación, 3 en camino,
-- 4 entregado, 5 cancelado.
-- =====================================================================
USE domicilios;

-- Workbench trae activado "safe updates", que bloquea UPDATE/DELETE cuyo WHERE
-- no usa una llave. Se desactiva solo en esta sesión. No hay riesgo porque
-- todo UPDATE/DELETE de este archivo termina en ROLLBACK.
SET SQL_SAFE_UPDATES = 0;


-- =====================================================================
-- TEMA 1 · WHERE y ORDER BY
-- WHERE filtra filas antes de mostrarlas; ORDER BY define el orden del resultado.
-- =====================================================================

-- 1.1 ¿Qué pizzas disponibles puede pedir un cliente con $35.000 de presupuesto,
--     de la más barata a la más cara?
-- Por qué: es un filtro de varias condiciones (categoría, disponibilidad,
-- precio) sobre filas individuales, sin agrupar: justo lo que hace WHERE.
SELECT p.nombre AS producto, r.nombre AS restaurante, p.precio
  FROM PRODUCTO p
  JOIN CATEGORIA cat ON cat.id_categoria = p.id_categoria
  JOIN RESTAURANTE r ON r.id_restaurante = p.id_restaurante
 WHERE cat.nombre = 'Pizzas'
   AND p.disponible = TRUE
   AND p.precio <= 35000
 ORDER BY p.precio ASC, p.nombre;

-- 1.2 ¿Qué clientes tienen 40 años o más? (para una campaña dirigida),
--     del mayor al menor.
-- Por qué: la edad es un atributo DERIVADO, no se guarda; fn_edad la calcula
-- en el momento y se puede usar en WHERE y en ORDER BY igual que una columna.
SELECT id_cliente, nombres, primer_apellido, fecha_nacimiento,
       fn_edad(fecha_nacimiento) AS edad
  FROM CLIENTE
 WHERE fn_edad(fecha_nacimiento) >= 40
 ORDER BY edad DESC, primer_apellido;

-- 1.3 ¿Qué pedidos del barrio Barzal (Villavicencio) se pagaron en efectivo?
--     Los de envío más caro primero: el domiciliario debe llevar cambio.
-- Por qué: WHERE por ciudad + barrio aprovecha el índice compuesto
-- idx_pedido_ciudad_barrio (09_indices.sql); ORDER BY con dos criterios
-- desempata por id cuando el costo de envío es igual.
SELECT id_pedido, calle, numero, barrio, costo_envio
  FROM PEDIDO
 WHERE ciudad = 'Villavicencio'
   AND barrio = 'Barzal'
   AND metodo_pago = 'efectivo'
 ORDER BY costo_envio DESC, id_pedido DESC;


-- =====================================================================
-- TEMA 2 · UPDATE (dentro de una transacción que se deshace al final)
-- =====================================================================
START TRANSACTION;

-- 2.1 El Asadero El Savia Llanero sube sus precios un 5 % (redondeado a $100).
--     ¿Cambia lo que ya pagaron sus clientes en pedidos anteriores?
-- Por qué: UPDATE con una expresión sobre la columna actual. La segunda
-- consulta demuestra el diseño del modelo: DETALLE_PEDIDO guarda el
-- precio_unitario cobrado, así que el total de pedidos viejos NO cambia.
SELECT p.id_producto, p.nombre, p.precio AS precio_antes
  FROM PRODUCTO p JOIN RESTAURANTE r ON r.id_restaurante = p.id_restaurante
 WHERE r.nombre = 'Asadero El Savia Llanero'
 ORDER BY p.id_producto;

SELECT pe.id_pedido, fn_total_pedido(pe.id_pedido) AS total_antes
  FROM PEDIDO pe JOIN RESTAURANTE r ON r.id_restaurante = pe.id_restaurante
 WHERE r.nombre = 'Asadero El Savia Llanero'
 ORDER BY pe.id_pedido;

UPDATE PRODUCTO
   SET precio = ROUND(precio * 1.05, -2)
 WHERE id_restaurante = (SELECT id_restaurante FROM RESTAURANTE WHERE nombre = 'Asadero El Savia Llanero');

SELECT p.id_producto, p.nombre, p.precio AS precio_despues
  FROM PRODUCTO p JOIN RESTAURANTE r ON r.id_restaurante = p.id_restaurante
 WHERE r.nombre = 'Asadero El Savia Llanero'
 ORDER BY p.id_producto;

SELECT pe.id_pedido, fn_total_pedido(pe.id_pedido) AS total_despues
  FROM PEDIDO pe JOIN RESTAURANTE r ON r.id_restaurante = pe.id_restaurante
 WHERE r.nombre = 'Asadero El Savia Llanero'
 ORDER BY pe.id_pedido;

-- 2.2 El restaurante 1 decide retirar del menú los productos que nunca ha
--     vendido. ¿Cuáles quedan como "no disponibles"?
-- Por qué: UPDATE con subconsulta NOT EXISTS sobre otra tabla. Se marca
-- disponible = FALSE en vez de borrar (regla del proyecto: un producto se
-- conserva para no romper la historia).
SELECT id_producto, nombre, disponible AS disponible_antes
  FROM PRODUCTO
 WHERE id_restaurante = 1
 ORDER BY id_producto;

UPDATE PRODUCTO p
   SET p.disponible = FALSE
 WHERE p.id_restaurante = 1
   AND NOT EXISTS (SELECT 1 FROM DETALLE_PEDIDO dp WHERE dp.id_producto = p.id_producto);

SELECT id_producto, nombre, disponible AS disponible_despues
  FROM PRODUCTO
 WHERE id_restaurante = 1
 ORDER BY id_producto;

-- 2.3 Promoción: envío gratis para los pedidos de Bogotá que todavía están
--     solo "recibidos" (el restaurante no ha empezado a prepararlos).
-- Por qué: UPDATE de VARIAS tablas (UPDATE ... JOIN). La tabla derivada
-- encuentra los pedidos cuyo historial tiene una sola fila (solo "recibido");
-- el JOIN limita el UPDATE a esos pedidos.
SELECT pe.id_pedido, pe.ciudad, pe.costo_envio AS envio_antes
  FROM PEDIDO pe
  JOIN (SELECT id_pedido FROM HISTORIAL_ESTADO GROUP BY id_pedido HAVING COUNT(*) = 1) solo_recibidos
    ON solo_recibidos.id_pedido = pe.id_pedido
 WHERE pe.ciudad = 'Bogotá';

UPDATE PEDIDO pe
  JOIN (SELECT id_pedido FROM HISTORIAL_ESTADO GROUP BY id_pedido HAVING COUNT(*) = 1) solo_recibidos
    ON solo_recibidos.id_pedido = pe.id_pedido
   SET pe.costo_envio = 0
 WHERE pe.ciudad = 'Bogotá';

SELECT pe.id_pedido, pe.ciudad, pe.costo_envio AS envio_despues
  FROM PEDIDO pe
  JOIN (SELECT id_pedido FROM HISTORIAL_ESTADO GROUP BY id_pedido HAVING COUNT(*) = 1) solo_recibidos
    ON solo_recibidos.id_pedido = pe.id_pedido
 WHERE pe.ciudad = 'Bogotá';

-- Se deshacen los tres UPDATE: los datos de prueba quedan como estaban
ROLLBACK;


-- =====================================================================
-- TEMA 3 · DELETE (dentro de una transacción que se deshace al final)
-- =====================================================================
START TRANSACTION;

-- 3.1 Se depura un pedido cancelado (el primero de la lista). ¿Qué pasa con
--     sus líneas y su historial?
-- Por qué: DELETE simple por llave primaria. Demuestra ON DELETE CASCADE de
-- fk_detalle_pedido y fk_historial_pedido (01_ddl.sql): al borrar el pedido,
-- MySQL borra solo sus líneas e historial, sin DELETE adicionales.
SELECT MIN(id_pedido) INTO @cancelado FROM vw_pedido_resumen WHERE id_estado_actual = 5;

SELECT (SELECT COUNT(*) FROM PEDIDO           WHERE id_pedido = @cancelado) AS pedido_antes,
       (SELECT COUNT(*) FROM DETALLE_PEDIDO   WHERE id_pedido = @cancelado) AS lineas_antes,
       (SELECT COUNT(*) FROM HISTORIAL_ESTADO WHERE id_pedido = @cancelado) AS estados_antes;

DELETE FROM PEDIDO WHERE id_pedido = @cancelado;

SELECT (SELECT COUNT(*) FROM PEDIDO           WHERE id_pedido = @cancelado) AS pedido_despues,
       (SELECT COUNT(*) FROM DETALLE_PEDIDO   WHERE id_pedido = @cancelado) AS lineas_despues,
       (SELECT COUNT(*) FROM HISTORIAL_ESTADO WHERE id_pedido = @cancelado) AS estados_despues;

-- 3.2 El restaurante 1 limpia su catálogo: borra los productos que nunca
--     vendió y que no forman parte de ningún combo.
-- Por qué: DELETE con subconsultas NOT IN. Las condiciones evitan chocar con
-- las llaves foráneas: un producto vendido (DETALLE_PEDIDO) o usado en un
-- combo (COMBO_COMPONENTE) no se puede borrar (RESTRICT). Las columnas de las
-- subconsultas son NOT NULL, así que NOT IN es seguro (con un NULL, NOT IN
-- no devolvería nada).
SELECT COUNT(*) AS productos_antes FROM PRODUCTO WHERE id_restaurante = 1;

DELETE FROM PRODUCTO
 WHERE id_restaurante = 1
   AND id_producto NOT IN (SELECT id_producto   FROM DETALLE_PEDIDO)
   AND id_producto NOT IN (SELECT id_combo      FROM COMBO_COMPONENTE)
   AND id_producto NOT IN (SELECT id_componente FROM COMBO_COMPONENTE);

SELECT COUNT(*) AS productos_despues FROM PRODUCTO WHERE id_restaurante = 1;

-- 3.3 El cliente con más pedidos pide retirar todas sus reseñas.
-- Por qué: DELETE de VARIAS tablas (DELETE cal FROM ... JOIN). CALIFICACION
-- no tiene id_cliente; se llega al cliente a través de PEDIDO.
SELECT id_cliente INTO @cliente_frecuente
  FROM PEDIDO GROUP BY id_cliente ORDER BY COUNT(*) DESC, id_cliente LIMIT 1;

SELECT COUNT(*) AS resenas_antes
  FROM CALIFICACION cal JOIN PEDIDO pe ON pe.id_pedido = cal.id_pedido
 WHERE pe.id_cliente = @cliente_frecuente;

DELETE cal
  FROM CALIFICACION cal
  JOIN PEDIDO pe ON pe.id_pedido = cal.id_pedido
 WHERE pe.id_cliente = @cliente_frecuente;

SELECT COUNT(*) AS resenas_despues
  FROM CALIFICACION cal JOIN PEDIDO pe ON pe.id_pedido = cal.id_pedido
 WHERE pe.id_cliente = @cliente_frecuente;

-- Se deshacen los tres DELETE
ROLLBACK;


-- =====================================================================
-- TEMA 4 · INNER JOIN
-- INNER JOIN solo devuelve filas que tienen pareja en ambas tablas.
-- =====================================================================

-- 4.1 ¿Qué lleva el pedido #1? (la comanda: producto, categoría, cantidad,
--     precio cobrado y subtotal)
-- Por qué: las líneas solo tienen ids; el JOIN trae los nombres de PRODUCTO y
-- CATEGORIA. Toda línea tiene producto y categoría, así que INNER JOIN no
-- pierde filas.
SELECT dp.id_pedido, p.nombre AS producto, cat.nombre AS categoria,
       dp.cantidad, dp.precio_unitario,
       dp.cantidad * dp.precio_unitario AS subtotal
  FROM DETALLE_PEDIDO dp
  JOIN PRODUCTO p    ON p.id_producto    = dp.id_producto
  JOIN CATEGORIA cat ON cat.id_categoria = p.id_categoria
 WHERE dp.id_pedido = 1
 ORDER BY p.nombre;

-- 4.2 ¿Quién pidió, a qué restaurante y quién entregó cada pedido entregado
--     en noviembre de 2026?
-- Por qué: cinco tablas unidas. Es INNER y no LEFT porque un pedido
-- entregado SIEMPRE tiene repartidor (el trigger lo exige desde "en camino").
SELECT pe.id_pedido,
       CONCAT_WS(' ', c.nombres, c.primer_apellido)     AS cliente,
       r.nombre                                         AS restaurante,
       CONCAT_WS(' ', rep.nombres, rep.primer_apellido) AS repartidor,
       rep.tipo_vehiculo,
       h.fecha_hora                                     AS entregado_en
  FROM PEDIDO pe
  JOIN CLIENTE c          ON c.id_cliente       = pe.id_cliente
  JOIN RESTAURANTE r      ON r.id_restaurante   = pe.id_restaurante
  JOIN REPARTIDOR rep     ON rep.id_repartidor  = pe.id_repartidor
  JOIN HISTORIAL_ESTADO h ON h.id_pedido        = pe.id_pedido AND h.id_estado = 4
 WHERE h.fecha_hora >= '2026-11-01' AND h.fecha_hora < '2026-12-01'
 ORDER BY h.fecha_hora;

-- 4.3 ¿Qué quejas hay contra repartidores? (calificaciones de repartidor de
--     2 estrellas o menos, con el comentario del cliente)
-- Por qué: CALIFICACION solo conoce el pedido; el JOIN con PEDIDO y
-- REPARTIDOR dice a quién va dirigida la queja.
SELECT cal.id_pedido,
       CONCAT_WS(' ', rep.nombres, rep.primer_apellido) AS repartidor,
       cal.nota_repartidor, cal.comentario, cal.fecha
  FROM CALIFICACION cal
  JOIN PEDIDO pe      ON pe.id_pedido      = cal.id_pedido
  JOIN REPARTIDOR rep ON rep.id_repartidor = pe.id_repartidor
 WHERE cal.nota_repartidor <= 2
 ORDER BY cal.nota_repartidor, cal.fecha DESC;


-- =====================================================================
-- TEMA 5 · Funciones de agregación (sin GROUP BY: un solo resultado)
-- COUNT, SUM, AVG, MIN y MAX resumen muchas filas en un valor.
-- =====================================================================

-- 5.1 ¿Cuánto ha vendido la plataforma en total, en cuántos pedidos entregados
--     y cuál es el valor promedio de un pedido?
-- Por qué: SUM y COUNT(DISTINCT) sobre las líneas de pedidos entregados.
-- COUNT(DISTINCT) porque un pedido tiene varias líneas y se contaría varias veces.
SELECT COUNT(DISTINCT dp.id_pedido)                                     AS pedidos_entregados,
       SUM(dp.cantidad * dp.precio_unitario)                            AS ventas,
       ROUND(SUM(dp.cantidad * dp.precio_unitario) / COUNT(DISTINCT dp.id_pedido)) AS ticket_promedio
  FROM DETALLE_PEDIDO dp
  JOIN HISTORIAL_ESTADO h ON h.id_pedido = dp.id_pedido AND h.id_estado = 4;

-- 5.2 ¿Cuál es el rango de precios del catálogo disponible?
-- Por qué: MIN, MAX y AVG en una sola pasada; COUNT(DISTINCT) cuenta cuántas
-- categorías distintas se ofrecen.
SELECT COUNT(*)                     AS productos_disponibles,
       MIN(precio)                  AS precio_minimo,
       MAX(precio)                  AS precio_maximo,
       ROUND(AVG(precio))           AS precio_promedio,
       COUNT(DISTINCT id_categoria) AS categorias_ofrecidas
  FROM PRODUCTO
 WHERE disponible = TRUE;

-- 5.3 ¿Qué tan satisfechos están los clientes? Nota promedio y porcentaje de
--     calificaciones de 5 estrellas.
-- Por qué: AVG de una comparación (nota = 5) devuelve la proporción de filas
-- que la cumplen, porque en MySQL TRUE vale 1 y FALSE vale 0.
SELECT COUNT(*)                              AS calificaciones,
       ROUND(AVG(nota_restaurante), 2)       AS nota_restaurantes,
       ROUND(AVG(nota_repartidor), 2)        AS nota_repartidores,
       ROUND(100 * AVG(nota_restaurante = 5), 1) AS pct_restaurante_5_estrellas
  FROM CALIFICACION;


-- =====================================================================
-- TEMA 6 · GROUP BY
-- GROUP BY parte las filas en grupos y aplica la agregación a cada grupo.
-- =====================================================================

-- 6.1 ¿Cuántos pedidos y cuántas ventas tiene cada ciudad?
-- Por qué: se necesita un resultado POR ciudad, no uno total.
SELECT v.ciudad,
       COUNT(*)                                                    AS pedidos,
       SUM(v.id_estado_actual = 4)                                 AS entregados,
       SUM(CASE WHEN v.id_estado_actual = 4 THEN v.subtotal ELSE 0 END) AS ventas
  FROM vw_pedido_resumen v
 GROUP BY v.ciudad
 ORDER BY ventas DESC;

-- 6.2 ¿Cómo pagan los clientes? Pedidos por método de pago y su porcentaje.
-- Por qué: GROUP BY por método; SUM(COUNT(*)) OVER () es una función de
-- ventana que suma TODOS los grupos para sacar el porcentaje sin otra consulta.
SELECT metodo_pago,
       COUNT(*)                                          AS pedidos,
       ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 1)  AS porcentaje
  FROM PEDIDO
 GROUP BY metodo_pago
 ORDER BY pedidos DESC;

-- 6.3 ¿Cuántos productos y a qué precio promedio ofrece cada categoría?
-- Por qué: GROUP BY sobre una tabla unida; se agrupa por el nombre de la
-- categoría (y su id, para no mezclar dos categorías con el mismo nombre).
SELECT cat.nombre AS categoria,
       COUNT(*)           AS productos,
       ROUND(AVG(p.precio)) AS precio_promedio
  FROM PRODUCTO p
  JOIN CATEGORIA cat ON cat.id_categoria = p.id_categoria
 GROUP BY cat.id_categoria, cat.nombre
 ORDER BY productos DESC;


-- =====================================================================
-- TEMA 7 · HAVING
-- HAVING filtra GRUPOS después de agregar; WHERE filtra filas antes.
-- =====================================================================

-- 7.1 ¿Qué clientes son frecuentes (más de 6 pedidos)?
-- Por qué: "más de 6 pedidos" es una condición sobre COUNT(*), que solo
-- existe después de agrupar; no se puede poner en WHERE.
SELECT c.id_cliente, CONCAT_WS(' ', c.nombres, c.primer_apellido) AS cliente,
       COUNT(*) AS pedidos
  FROM PEDIDO pe
  JOIN CLIENTE c ON c.id_cliente = pe.id_cliente
 GROUP BY c.id_cliente, c.nombres, c.primer_apellido
HAVING COUNT(*) > 6
 ORDER BY pedidos DESC;

-- 7.2 ¿Qué restaurantes tienen problemas de calidad? Nota promedio menor a
--     3,8 con al menos 3 calificaciones (para no juzgar por una sola).
-- Por qué: dos condiciones sobre agregados (AVG y COUNT) en el mismo HAVING.
SELECT r.nombre AS restaurante,
       COUNT(*)                        AS calificaciones,
       ROUND(AVG(cal.nota_restaurante), 2) AS nota_promedio
  FROM CALIFICACION cal
  JOIN PEDIDO pe     ON pe.id_pedido      = cal.id_pedido
  JOIN RESTAURANTE r ON r.id_restaurante  = pe.id_restaurante
 GROUP BY r.id_restaurante, r.nombre
HAVING COUNT(*) >= 3 AND AVG(cal.nota_restaurante) < 3.8
 ORDER BY nota_promedio;

-- 7.3 ¿Qué barrios de Villavicencio tienen mucho movimiento (más de 10
--     pedidos) y un envío promedio caro (más de $5.000)?
-- Por qué: WHERE y HAVING juntos. WHERE deja solo Villavicencio ANTES de
-- agrupar (más eficiente); HAVING filtra los barrios DESPUÉS.
SELECT barrio,
       COUNT(*)               AS pedidos,
       ROUND(AVG(costo_envio)) AS envio_promedio
  FROM PEDIDO
 WHERE ciudad = 'Villavicencio'
 GROUP BY barrio
HAVING COUNT(*) > 10 AND AVG(costo_envio) > 5000
 ORDER BY pedidos DESC;


-- =====================================================================
-- TEMA 8 · Subconsulta en WHERE
-- =====================================================================

-- 8.1 ¿Qué productos son más caros que el promedio de SU categoría?
-- Por qué: subconsulta CORRELACIONADA. El promedio cambia según la categoría
-- de cada fila, así que la subconsulta se evalúa con p.id_categoria de afuera.
SELECT p.nombre AS producto, cat.nombre AS categoria, p.precio
  FROM PRODUCTO p
  JOIN CATEGORIA cat ON cat.id_categoria = p.id_categoria
 WHERE p.precio > (SELECT AVG(p2.precio)
                     FROM PRODUCTO p2
                    WHERE p2.id_categoria = p.id_categoria)
 ORDER BY cat.nombre, p.precio DESC;

-- 8.2 ¿Qué pedidos entregados costaron más que el pedido promedio entregado?
-- Por qué: subconsulta ESCALAR (devuelve un solo número) que se compara contra
-- cada fila. Se usa fn_total_pedido, el atributo derivado de P3.
SELECT pe.id_pedido, fn_total_pedido(pe.id_pedido) AS total
  FROM PEDIDO pe
 WHERE pe.id_pedido IN (SELECT id_pedido FROM HISTORIAL_ESTADO WHERE id_estado = 4)
   AND fn_total_pedido(pe.id_pedido) > (SELECT AVG(v.total)
                                          FROM vw_pedido_resumen v
                                         WHERE v.id_estado_actual = 4)
 ORDER BY total DESC;

-- 8.3 ¿Qué productos nunca se han vendido, en restaurantes que sí venden?
--     (candidatos a sacar del menú)
-- Por qué: NOT EXISTS para "nunca vendido" e IN para "restaurante con ventas".
-- NOT EXISTS es la forma segura de expresar "no hay ninguna fila que...".
SELECT r.nombre AS restaurante, p.nombre AS producto, p.precio
  FROM PRODUCTO p
  JOIN RESTAURANTE r ON r.id_restaurante = p.id_restaurante
 WHERE NOT EXISTS (SELECT 1 FROM DETALLE_PEDIDO dp WHERE dp.id_producto = p.id_producto)
   AND p.id_restaurante IN (SELECT DISTINCT id_restaurante FROM PEDIDO)
 ORDER BY r.nombre, p.nombre;


-- =====================================================================
-- TEMA 9 · Subconsulta en FROM (tabla derivada)
-- El resultado de una consulta se usa como si fuera una tabla.
-- =====================================================================

-- 9.1 ¿Cuántos pedidos hace en promedio un cliente, y cuál es el mínimo y el máximo?
-- Por qué: hay que agregar DOS veces: primero contar pedidos por cliente,
-- después promediar esos conteos. Un AVG(COUNT(*)) directo no está permitido.
SELECT ROUND(AVG(t.pedidos), 2) AS promedio_por_cliente,
       MIN(t.pedidos)           AS minimo,
       MAX(t.pedidos)           AS maximo
  FROM (SELECT id_cliente, COUNT(*) AS pedidos
          FROM PEDIDO
         GROUP BY id_cliente) AS t;

-- 9.2 ¿Cuál es el producto más vendido de cada restaurante?
-- Por qué: la tabla derivada numera los productos dentro de cada restaurante
-- con ROW_NUMBER() OVER (PARTITION BY ...); afuera se toma el número 1.
-- Con WHERE no se puede filtrar una función de ventana directamente.
SELECT t.restaurante, t.producto, t.unidades_vendidas
  FROM (SELECT pv.restaurante, pv.producto, pv.unidades_vendidas,
               ROW_NUMBER() OVER (PARTITION BY pv.id_restaurante
                                  ORDER BY pv.unidades_vendidas DESC, pv.producto) AS puesto
          FROM vw_producto_ventas pv
         WHERE pv.unidades_vendidas > 0) AS t
 WHERE t.puesto = 1
 ORDER BY t.unidades_vendidas DESC, t.restaurante;

-- 9.3 ¿Cuántos pedidos se entregan en menos de 45 minutos, entre 45 y 60, y
--     en más de 60?
-- Por qué: la tabla derivada clasifica cada pedido en un rango con CASE;
-- afuera se cuenta cuántos hay en cada rango.
SELECT t.rango, COUNT(*) AS pedidos
  FROM (SELECT CASE
                 WHEN v.tiempo_entrega_min < 45  THEN '1. menos de 45 min'
                 WHEN v.tiempo_entrega_min <= 60 THEN '2. de 45 a 60 min'
                 ELSE                                 '3. más de 60 min'
               END AS rango
          FROM vw_pedido_resumen v
         WHERE v.id_estado_actual = 4) AS t
 GROUP BY t.rango
 ORDER BY t.rango;


-- =====================================================================
-- TEMA 10 · Consultas sobre vistas (06_vistas.sql)
-- Una vista guarda una consulta con nombre; se consulta como una tabla.
-- =====================================================================

-- 10.1 ¿Cuáles son los 5 restaurantes que más venden?
-- Por qué: vw_ventas_restaurante ya tiene la regla "venta = pedido entregado,
-- sin envío"; la consulta solo ordena y limita, sin repetir los JOIN.
SELECT nombre, pedidos_entregados, ventas, ticket_promedio, calificacion_promedio
  FROM vw_ventas_restaurante
 ORDER BY ventas DESC
 LIMIT 5;

-- 10.2 ¿Influye el vehículo en la rapidez y en la nota del repartidor?
-- Por qué: se agrupa una vista que ya calculó el desempeño de cada repartidor.
-- Se pondera por entregas (SUM(promedio × entregas) / SUM(entregas)) para
-- que un repartidor con 1 entrega no pese lo mismo que uno con 10.
SELECT tipo_vehiculo,
       COUNT(*)      AS repartidores,
       SUM(entregas) AS entregas,
       ROUND(SUM(tiempo_promedio_min * entregas) / NULLIF(SUM(entregas), 0)) AS minutos_promedio,
       ROUND(AVG(calificacion_promedio), 2) AS nota_promedio
  FROM vw_desempeno_repartidor
 WHERE entregas > 0
 GROUP BY tipo_vehiculo
 ORDER BY minutos_promedio;

-- 10.3 ¿En qué mes se cancelaron proporcionalmente más pedidos?
-- Por qué: vw_ventas_mensuales ya separa entregados y cancelados por mes;
-- solo falta calcular la tasa.
SELECT mes, pedidos, cancelados,
       ROUND(100 * cancelados / pedidos, 1) AS pct_cancelados
  FROM vw_ventas_mensuales
 ORDER BY pct_cancelados DESC, mes;


-- =====================================================================
-- TEMA 11 · LEFT JOIN y RIGHT JOIN
-- Conservan TODAS las filas de una tabla aunque no tengan pareja en la otra
-- (las columnas de la otra tabla salen NULL).
-- =====================================================================

-- 11.1 ¿Qué restaurantes afiliados no han recibido ni un pedido?
-- Por qué: LEFT JOIN conserva todos los restaurantes; los que no tienen
-- pedido quedan con pe.id_pedido NULL, y eso es lo que se filtra.
-- Con INNER JOIN estos restaurantes desaparecerían del resultado.
SELECT r.id_restaurante, r.nombre, r.fecha_afiliacion
  FROM RESTAURANTE r
  LEFT JOIN PEDIDO pe ON pe.id_restaurante = r.id_restaurante
 WHERE pe.id_pedido IS NULL
 ORDER BY r.fecha_afiliacion;

-- 11.2 ¿Qué pedidos entregados no han sido calificados todavía?
--      (para enviar un recordatorio al cliente)
-- Por qué: LEFT JOIN con CALIFICACION + IS NULL = "entregado sin nota".
SELECT pe.id_pedido, CONCAT_WS(' ', c.nombres, c.primer_apellido) AS cliente, c.email
  FROM PEDIDO pe
  JOIN HISTORIAL_ESTADO h ON h.id_pedido = pe.id_pedido AND h.id_estado = 4
  JOIN CLIENTE c          ON c.id_cliente = pe.id_cliente
  LEFT JOIN CALIFICACION cal ON cal.id_pedido = pe.id_pedido
 WHERE cal.id_pedido IS NULL
 ORDER BY pe.id_pedido;

-- 11.3 ¿Qué repartidores están libres ahora (sin pedidos "en camino")?
-- Por qué: RIGHT JOIN conserva todas las filas de la tabla de la DERECHA
-- (REPARTIDOR) aunque no tengan pedido en camino. La condición de estado va
-- en el ON y no en el WHERE: en el WHERE eliminaría a los repartidores sin
-- pedido y el RIGHT JOIN no serviría de nada.
SELECT rep.id_repartidor,
       CONCAT_WS(' ', rep.nombres, rep.primer_apellido) AS repartidor,
       rep.tipo_vehiculo,
       COUNT(v.id_pedido) AS pedidos_en_camino
  FROM vw_pedido_resumen v
 RIGHT JOIN REPARTIDOR rep
    ON rep.id_repartidor = v.id_repartidor AND v.id_estado_actual = 3
 GROUP BY rep.id_repartidor, rep.nombres, rep.primer_apellido, rep.tipo_vehiculo
 ORDER BY pedidos_en_camino, rep.primer_apellido;


-- =====================================================================
-- TEMA 12 · Self-join (una tabla unida consigo misma)
-- Se usa la misma tabla dos veces con alias distintos, cada uno en un papel.
-- =====================================================================

-- 12.1 ¿Cuánto se ahorra el cliente con cada combo frente a comprar sus
--      componentes por separado?
-- Por qué: COMBO_COMPONENTE es la relación RECURSIVA de PRODUCTO consigo
-- mismo. PRODUCTO aparece dos veces: "combo" y "comp" (componente).
SELECT combo.nombre                              AS combo,
       combo.precio                              AS precio_combo,
       SUM(comp.precio * cc.cantidad)            AS precio_por_separado,
       SUM(comp.precio * cc.cantidad) - combo.precio AS ahorro
  FROM COMBO_COMPONENTE cc
  JOIN PRODUCTO combo ON combo.id_producto = cc.id_combo
  JOIN PRODUCTO comp  ON comp.id_producto  = cc.id_componente
 GROUP BY combo.id_producto, combo.nombre, combo.precio
 ORDER BY ahorro DESC;

-- 12.2 ¿Cuánto tarda cada restaurante en empezar a preparar un pedido
--      después de recibirlo?
-- Por qué: HISTORIAL_ESTADO consigo misma. "rec" es la fila "recibido" y
-- "prep" la fila "en preparación" DEL MISMO pedido; la diferencia de horas
-- entre las dos filas es el tiempo de aceptación.
SELECT r.nombre AS restaurante,
       COUNT(*) AS pedidos,
       ROUND(AVG(TIMESTAMPDIFF(MINUTE, rec.fecha_hora, prep.fecha_hora)), 1) AS minutos_para_aceptar
  FROM HISTORIAL_ESTADO rec
  JOIN HISTORIAL_ESTADO prep ON prep.id_pedido = rec.id_pedido AND prep.id_estado = 2
  JOIN PEDIDO pe             ON pe.id_pedido   = rec.id_pedido
  JOIN RESTAURANTE r         ON r.id_restaurante = pe.id_restaurante
 WHERE rec.id_estado = 1
 GROUP BY r.id_restaurante, r.nombre
 ORDER BY minutos_para_aceptar DESC;

-- 12.3 ¿Qué clientes repiten restaurante? (cuántas veces volvieron a pedirle
--      al mismo restaurante)
-- Por qué: PEDIDO consigo misma. p1 y p2 son dos pedidos del MISMO cliente al
-- MISMO restaurante; p1.id_pedido < p2.id_pedido cuenta cada pareja una sola
-- vez y evita unir un pedido consigo mismo.
SELECT CONCAT_WS(' ', c.nombres, c.primer_apellido) AS cliente,
       r.nombre                                     AS restaurante,
       COUNT(*)                                     AS veces_que_volvio
  FROM PEDIDO p1
  JOIN PEDIDO p2     ON p2.id_cliente     = p1.id_cliente
                    AND p2.id_restaurante = p1.id_restaurante
                    AND p2.id_pedido      > p1.id_pedido
  JOIN CLIENTE c     ON c.id_cliente      = p1.id_cliente
  JOIN RESTAURANTE r ON r.id_restaurante  = p1.id_restaurante
 GROUP BY c.id_cliente, c.nombres, c.primer_apellido, r.id_restaurante, r.nombre
 ORDER BY veces_que_volvio DESC, cliente;


-- =====================================================================
-- TEMA 13 · UNION
-- Junta los resultados de varias consultas con las mismas columnas.
-- UNION quita filas repetidas; UNION ALL las deja (y es más rápido).
-- =====================================================================

-- 13.1 Directorio telefónico de la operación: clientes, repartidores y
--      restaurantes en una sola lista.
-- Por qué: son tres tablas distintas con la misma "forma" (tipo, nombre,
-- teléfono). UNION ALL porque no puede haber repetidos entre tipos distintos
-- y así MySQL no gasta tiempo buscándolos.
SELECT 'cliente' AS tipo, CONCAT_WS(' ', c.nombres, c.primer_apellido) AS nombre, t.telefono
  FROM CLIENTE c JOIN TELEFONO_CLIENTE t ON t.id_cliente = c.id_cliente
UNION ALL
SELECT 'repartidor', CONCAT_WS(' ', nombres, primer_apellido), telefono
  FROM REPARTIDOR
UNION ALL
SELECT 'restaurante', nombre, telefono
  FROM RESTAURANTE
 ORDER BY tipo, nombre;

-- 13.2 ¿Qué pedidos entregados tienen alguna mala calificación (2 o menos),
--      ya sea del restaurante o del repartidor?
-- Por qué: UNION (sin ALL) a propósito. Un pedido con mala nota en AMBAS
-- cosas saldría en las dos consultas; UNION lo deja una sola vez.
SELECT id_pedido FROM CALIFICACION WHERE nota_restaurante <= 2
UNION
SELECT id_pedido FROM CALIFICACION WHERE nota_repartidor  <= 2
 ORDER BY id_pedido;

-- 13.3 ¿Cuántos pedidos hay en cada estado, con una fila final de TOTAL?
-- Por qué: UNION ALL agrega la fila del total debajo del detalle. La columna
-- "orden" fuerza a que la fila TOTAL quede de última.
SELECT e.orden, e.nombre AS estado, COUNT(*) AS pedidos
  FROM vw_pedido_resumen v
  JOIN ESTADO e ON e.id_estado = v.id_estado_actual
 GROUP BY e.orden, e.nombre
UNION ALL
SELECT 99, 'TOTAL', COUNT(*)
  FROM PEDIDO
 ORDER BY orden;
