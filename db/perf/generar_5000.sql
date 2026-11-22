-- Carga 5000 pedidos completos para probar el rendimiento de las consultas e índices.
-- Ejecución: npm run db:perf (requiere domicilios creado con npm run db:setup).
USE domicilios;

DROP PROCEDURE IF EXISTS sp_generar_pedidos_perf;
DELIMITER $$

CREATE PROCEDURE sp_generar_pedidos_perf(IN p_cantidad INT)
BEGIN
  DECLARE v_contador INT DEFAULT 0;
  DECLARE v_id_cliente INT DEFAULT NULL;
  DECLARE v_id_restaurante INT DEFAULT NULL;
  DECLARE v_id_repartidor INT DEFAULT NULL;
  DECLARE v_id_pedido INT DEFAULT NULL;
  DECLARE v_id_producto_1 INT DEFAULT NULL;
  DECLARE v_id_producto_2 INT DEFAULT NULL;
  DECLARE v_cantidad_productos INT DEFAULT 1;
  DECLARE v_barrio_restaurante VARCHAR(60) DEFAULT NULL;
  DECLARE v_ciudad VARCHAR(60) DEFAULT NULL;
  DECLARE v_barrio VARCHAR(60) DEFAULT NULL;
  DECLARE v_fecha_actual DATETIME;
  DECLARE v_calle VARCHAR(60);
  DECLARE v_numero VARCHAR(20);

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;

  IF p_cantidad IS NULL OR p_cantidad < 1 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'La cantidad de pedidos debe ser mayor que cero.';
  END IF;

  START TRANSACTION;
  WHILE v_contador < p_cantidad DO
    SET v_id_cliente = NULL;
    SET v_id_restaurante = NULL;
    SET v_id_repartidor = NULL;
    SET v_id_producto_1 = NULL;
    SET v_id_producto_2 = NULL;

    SELECT id_cliente INTO v_id_cliente
      FROM CLIENTE
     WHERE id_cliente BETWEEN 1 AND 50
     ORDER BY RAND()
     LIMIT 1;

    SELECT id_repartidor INTO v_id_repartidor
      FROM REPARTIDOR
     ORDER BY RAND()
     LIMIT 1;

    SELECT r.id_restaurante, SUBSTRING_INDEX(r.direccion, ', ', -1)
      INTO v_id_restaurante, v_barrio_restaurante
      FROM RESTAURANTE r
     WHERE SUBSTRING_INDEX(r.direccion, ', ', -1) IN (
             'Barzal', 'Centro', 'La Esperanza', 'El Buque', 'Caudal',
             'Siete de Agosto', 'La Grama', 'La Rosita', 'Villa María', 'Porfía',
             'Chapinero', 'Usaquén', 'Teusaquillo', 'Suba', 'Cedritos',
             'Fontibón', 'Modelia', 'La Soledad', 'Restrepo', 'Normandía'
           )
       AND (
         SELECT COUNT(*)
           FROM PRODUCTO p
          WHERE p.id_restaurante = r.id_restaurante
            AND p.disponible = TRUE
            AND NOT EXISTS (
              SELECT 1
                FROM COMBO_COMPONENTE cc
               WHERE cc.id_combo = p.id_producto
            )
       ) >= 2
     ORDER BY RAND()
     LIMIT 1;

    IF v_id_cliente IS NULL OR v_id_repartidor IS NULL OR v_id_restaurante IS NULL THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No hay clientes, restaurantes con productos disponibles o repartidores para generar pedidos.';
    END IF;

    SET v_ciudad = CASE
      WHEN v_barrio_restaurante IN (
        'Barzal', 'Centro', 'La Esperanza', 'El Buque', 'Caudal',
        'Siete de Agosto', 'La Grama', 'La Rosita', 'Villa María', 'Porfía'
      ) THEN 'Villavicencio'
      WHEN v_barrio_restaurante IN (
        'Chapinero', 'Usaquén', 'Teusaquillo', 'Suba', 'Cedritos',
        'Fontibón', 'Modelia', 'La Soledad', 'Restrepo', 'Normandía'
      ) THEN 'Bogotá'
      ELSE NULL
    END;

    IF v_ciudad IS NULL THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se pudo determinar la ciudad del restaurante seleccionado.';
    END IF;

    SET v_barrio = CASE
      WHEN v_ciudad = 'Villavicencio' THEN ELT(
        FLOOR(1 + RAND() * 8),
        'Barzal', 'Centro', 'La Esperanza', 'El Buque',
        'Caudal', 'Siete de Agosto', 'La Grama', 'Los Centauros'
      )
      ELSE ELT(
        FLOOR(1 + RAND() * 5),
        'Chapinero', 'Usaquén', 'Teusaquillo', 'Suba', 'Cedritos'
      )
    END;
    SET v_calle = CONCAT('Calle ', FLOOR(3 + RAND() * 80));
    SET v_numero = CONCAT(
      '# ', FLOOR(1 + RAND() * 90), '-',
      LPAD(FLOOR(1 + RAND() * 99), 2, '0')
    );
    SET v_cantidad_productos = FLOOR(1 + RAND() * 2);

    SELECT p.id_producto INTO v_id_producto_1
      FROM PRODUCTO p
     WHERE p.id_restaurante = v_id_restaurante
       AND p.disponible = TRUE
       AND NOT EXISTS (
         SELECT 1
           FROM COMBO_COMPONENTE cc
          WHERE cc.id_combo = p.id_producto
       )
     ORDER BY RAND()
     LIMIT 1;

    IF v_cantidad_productos = 2 THEN
      SELECT p.id_producto INTO v_id_producto_2
        FROM PRODUCTO p
       WHERE p.id_restaurante = v_id_restaurante
         AND p.id_producto <> v_id_producto_1
         AND p.disponible = TRUE
         AND NOT EXISTS (
           SELECT 1
             FROM COMBO_COMPONENTE cc
            WHERE cc.id_combo = p.id_producto
         )
       ORDER BY RAND()
       LIMIT 1;
    END IF;

    IF v_id_producto_1 IS NULL
       OR (v_cantidad_productos = 2 AND v_id_producto_2 IS NULL) THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se encontraron suficientes productos disponibles del restaurante.';
    END IF;

    INSERT INTO PEDIDO (
      id_cliente, id_restaurante, id_repartidor, calle, numero, barrio,
      ciudad, costo_envio, metodo_pago
    ) VALUES (
      v_id_cliente, v_id_restaurante, v_id_repartidor, v_calle, v_numero, v_barrio,
      v_ciudad, (FLOOR(4 + RAND() * 13) * 500),
      ELT(FLOOR(1 + RAND() * 3), 'efectivo', 'tarjeta', 'transferencia')
    );
    SET v_id_pedido = LAST_INSERT_ID();

    INSERT INTO DETALLE_PEDIDO (id_pedido, id_producto, cantidad, precio_unitario)
    SELECT v_id_pedido, p.id_producto, FLOOR(1 + RAND() * 3), p.precio
      FROM PRODUCTO p
     WHERE p.id_producto = v_id_producto_1;

    IF v_cantidad_productos = 2 THEN
      INSERT INTO DETALLE_PEDIDO (id_pedido, id_producto, cantidad, precio_unitario)
      SELECT v_id_pedido, p.id_producto, FLOOR(1 + RAND() * 3), p.precio
        FROM PRODUCTO p
       WHERE p.id_producto = v_id_producto_2;
    END IF;

    SET v_fecha_actual = TIMESTAMPADD(
      SECOND,
      FLOOR(RAND() * TIMESTAMPDIFF(
        SECOND, '2025-01-01 00:00:00', '2026-11-20 22:30:00'
      )),
      '2025-01-01 00:00:00'
    );
    INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion)
    VALUES (v_id_pedido, 1, 1, v_fecha_actual, 'Pedido recibido');

    SET v_fecha_actual = DATE_ADD(v_fecha_actual, INTERVAL (3 + FLOOR(RAND() * 8)) MINUTE);
    INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion)
    VALUES (v_id_pedido, 2, 2, v_fecha_actual, 'Preparación iniciada');

    SET v_fecha_actual = DATE_ADD(v_fecha_actual, INTERVAL (15 + FLOOR(RAND() * 21)) MINUTE);
    INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion)
    VALUES (v_id_pedido, 3, 3, v_fecha_actual, 'Pedido en camino');

    SET v_fecha_actual = DATE_ADD(v_fecha_actual, INTERVAL (15 + FLOOR(RAND() * 26)) MINUTE);
    INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, fecha_hora, observacion)
    VALUES (v_id_pedido, 4, 4, v_fecha_actual, 'Pedido entregado');

    SET v_contador = v_contador + 1;
    IF MOD(v_contador, 500) = 0 THEN
      COMMIT;
      IF v_contador < p_cantidad THEN
        START TRANSACTION;
      END IF;
    END IF;
  END WHILE;

  IF MOD(v_contador, 500) <> 0 THEN
    COMMIT;
  END IF;
END$$

DELIMITER ;

SET @pedidos_antes = (SELECT COUNT(*) FROM PEDIDO);
SET @detalles_antes = (SELECT COUNT(*) FROM DETALLE_PEDIDO);
SET @historiales_antes = (SELECT COUNT(*) FROM HISTORIAL_ESTADO);

CALL sp_generar_pedidos_perf(5000);

SELECT
  (SELECT COUNT(*) FROM PEDIDO) - @pedidos_antes AS pedidos_generados,
  (SELECT COUNT(*) FROM DETALLE_PEDIDO) - @detalles_antes AS detalles_generados,
  (SELECT COUNT(*) FROM HISTORIAL_ESTADO) - @historiales_antes AS historiales_generados;
