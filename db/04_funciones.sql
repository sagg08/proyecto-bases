-- =====================================================================
-- 04_funciones.sql · Funciones que calculan los atributos DERIVADOS
-- Los derivados no se guardan (avance, sección 2): se calculan aquí y se
-- usan dentro de cualquier SELECT, p. ej. SELECT fn_edad(fecha_nacimiento) ...
--
-- DETERMINISTIC = mismo resultado para los mismos parámetros.
-- READS SQL DATA = la función lee tablas pero no las modifica.
-- (MySQL exige declarar una de estas características si el binlog está activo.)
-- =====================================================================
USE domicilios;

DROP FUNCTION IF EXISTS fn_edad;
DROP FUNCTION IF EXISTS fn_total_pedido;
DROP FUNCTION IF EXISTS fn_estado_actual;
DROP FUNCTION IF EXISTS fn_tiempo_entrega;

DELIMITER $$

-- edad de CLIENTE: años cumplidos a hoy a partir de fecha_nacimiento.
-- No es DETERMINISTIC porque depende de CURDATE() (cambia con los días).
CREATE FUNCTION fn_edad(p_fecha_nacimiento DATE)
RETURNS INT
NOT DETERMINISTIC
NO SQL
BEGIN
  RETURN TIMESTAMPDIFF(YEAR, p_fecha_nacimiento, CURDATE());
END$$

-- ---------------------------------------------------------------------
-- fn_total_pedido (P3) · total DERIVADO de un pedido: líneas + envío.
-- Nunca se guarda: el precio de cada línea ya quedó fijo en
-- DETALLE_PEDIDO.precio_unitario (el del producto puede cambiar después).
-- NOT DETERMINISTIC: el resultado depende del contenido de las tablas,
-- no solo del parámetro.
-- ---------------------------------------------------------------------
CREATE FUNCTION fn_total_pedido(p_id_pedido INT)
RETURNS INT
NOT DETERMINISTIC
READS SQL DATA
BEGIN
  DECLARE v_lineas     INT;
  DECLARE v_costo_envio INT;

  SELECT COALESCE(SUM(dp.cantidad * dp.precio_unitario), 0) INTO v_lineas
    FROM DETALLE_PEDIDO dp WHERE dp.id_pedido = p_id_pedido;

  SELECT costo_envio INTO v_costo_envio FROM PEDIDO WHERE id_pedido = p_id_pedido;

  RETURN v_lineas + COALESCE(v_costo_envio, 0);
END$$

-- ---------------------------------------------------------------------
-- fn_estado_actual (P3) · nombre del estado DERIVADO de un pedido:
-- el de HISTORIAL_ESTADO con mayor secuencia (el más reciente).
-- ---------------------------------------------------------------------
CREATE FUNCTION fn_estado_actual(p_id_pedido INT)
RETURNS VARCHAR(20)
NOT DETERMINISTIC
READS SQL DATA
BEGIN
  DECLARE v_estado VARCHAR(20);

  SELECT e.nombre INTO v_estado
    FROM HISTORIAL_ESTADO h
    JOIN ESTADO e ON e.id_estado = h.id_estado
   WHERE h.id_pedido = p_id_pedido
   ORDER BY h.secuencia DESC
   LIMIT 1;

  RETURN v_estado;
END$$

-- ---------------------------------------------------------------------
-- fn_tiempo_entrega (P3) · minutos DERIVADOS entre "recibido" y "entregado".
-- NULL si el pedido todavía no fue entregado (no hay nada que medir aún).
-- ---------------------------------------------------------------------
CREATE FUNCTION fn_tiempo_entrega(p_id_pedido INT)
RETURNS INT
NOT DETERMINISTIC
READS SQL DATA
BEGIN
  DECLARE v_recibido  DATETIME;
  DECLARE v_entregado DATETIME;

  SELECT h.fecha_hora INTO v_recibido
    FROM HISTORIAL_ESTADO h JOIN ESTADO e ON e.id_estado = h.id_estado
   WHERE h.id_pedido = p_id_pedido AND e.nombre = 'recibido'
   LIMIT 1;

  SELECT h.fecha_hora INTO v_entregado
    FROM HISTORIAL_ESTADO h JOIN ESTADO e ON e.id_estado = h.id_estado
   WHERE h.id_pedido = p_id_pedido AND e.nombre = 'entregado'
   LIMIT 1;

  IF v_recibido IS NULL OR v_entregado IS NULL THEN
    RETURN NULL;
  END IF;

  RETURN TIMESTAMPDIFF(MINUTE, v_recibido, v_entregado);
END$$

DELIMITER ;
