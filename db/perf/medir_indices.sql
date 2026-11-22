USE domicilios;

-- Q1: ¿Cuántos pedidos y cuánto costo de envío hay en Barzal, Villavicencio?
SELECT COUNT(*), SUM(costo_envio)
  FROM PEDIDO
 WHERE ciudad = 'Villavicencio'
   AND barrio = 'Barzal';

-- Q1 sin índice: quitarlo y revisar el plan y el tiempo real de la consulta.
DROP INDEX idx_pedido_ciudad_barrio ON PEDIDO;
EXPLAIN FORMAT=TREE
SELECT COUNT(*), SUM(costo_envio)
  FROM PEDIDO
 WHERE ciudad = 'Villavicencio'
   AND barrio = 'Barzal';
EXPLAIN ANALYZE
SELECT COUNT(*), SUM(costo_envio)
  FROM PEDIDO
 WHERE ciudad = 'Villavicencio'
   AND barrio = 'Barzal';

-- Q1 con índice: recrearlo y repetir las mediciones.
CREATE INDEX idx_pedido_ciudad_barrio
  ON PEDIDO (ciudad, barrio);
EXPLAIN FORMAT=TREE
SELECT COUNT(*), SUM(costo_envio)
  FROM PEDIDO
 WHERE ciudad = 'Villavicencio'
   AND barrio = 'Barzal';
EXPLAIN ANALYZE
SELECT COUNT(*), SUM(costo_envio)
  FROM PEDIDO
 WHERE ciudad = 'Villavicencio'
   AND barrio = 'Barzal';

-- Q2: ¿Cuántos pedidos se entregaron en septiembre de 2026?
SELECT COUNT(DISTINCT id_pedido)
  FROM HISTORIAL_ESTADO
 WHERE id_estado = 4
   AND fecha_hora BETWEEN '2026-09-01' AND '2026-09-30 23:59:59';

-- Q2 sin el índice compuesto: medir primero el plan normal (puede usar la FK).
-- Al crear idx_historial_estado_fecha, InnoDB eliminó el índice automático de la FK
-- (fk_historial_estado) porque el compuesto ya le sirve. Sin recrearlo, MySQL no deja
-- quitar el compuesto: Error 1553 (needed in a foreign key constraint).
CREATE INDEX fk_historial_estado ON HISTORIAL_ESTADO (id_estado);
DROP INDEX idx_historial_estado_fecha ON HISTORIAL_ESTADO;
EXPLAIN FORMAT=TREE
SELECT COUNT(DISTINCT id_pedido)
  FROM HISTORIAL_ESTADO
 WHERE id_estado = 4
   AND fecha_hora BETWEEN '2026-09-01' AND '2026-09-30 23:59:59';
EXPLAIN ANALYZE
SELECT COUNT(DISTINCT id_pedido)
  FROM HISTORIAL_ESTADO
 WHERE id_estado = 4
   AND fecha_hora BETWEEN '2026-09-01' AND '2026-09-30 23:59:59';

-- Q2 sin ningún índice útil: ignorar el índice automático de la FK en id_estado.
EXPLAIN FORMAT=TREE
SELECT COUNT(DISTINCT id_pedido)
  FROM HISTORIAL_ESTADO IGNORE INDEX (fk_historial_estado)
 WHERE id_estado = 4
   AND fecha_hora BETWEEN '2026-09-01' AND '2026-09-30 23:59:59';
EXPLAIN ANALYZE
SELECT COUNT(DISTINCT id_pedido)
  FROM HISTORIAL_ESTADO IGNORE INDEX (fk_historial_estado)
 WHERE id_estado = 4
   AND fecha_hora BETWEEN '2026-09-01' AND '2026-09-30 23:59:59';

-- Q2 con índice: recrearlo y repetir las mediciones.
CREATE INDEX idx_historial_estado_fecha
  ON HISTORIAL_ESTADO (id_estado, fecha_hora);
-- Se quita el índice simple de la FK para dejar la base igual que npm run db:setup
-- (el compuesto vuelve a cubrir la FK).
DROP INDEX fk_historial_estado ON HISTORIAL_ESTADO;
EXPLAIN FORMAT=TREE
SELECT COUNT(DISTINCT id_pedido)
  FROM HISTORIAL_ESTADO
 WHERE id_estado = 4
   AND fecha_hora BETWEEN '2026-09-01' AND '2026-09-30 23:59:59';
EXPLAIN ANALYZE
SELECT COUNT(DISTINCT id_pedido)
  FROM HISTORIAL_ESTADO
 WHERE id_estado = 4
   AND fecha_hora BETWEEN '2026-09-01' AND '2026-09-30 23:59:59';
