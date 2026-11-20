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

DELIMITER ;
