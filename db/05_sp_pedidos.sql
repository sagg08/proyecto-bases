-- =====================================================================
-- 05_sp_pedidos.sql · Repartidores y Pedidos (P3), núcleo del negocio
--
-- La aplicación solo accede a estos procedimientos mediante callProc().
-- SQLSTATE '45000' indica una regla de negocio; '45004', un registro inexistente.
-- Las reglas entre tablas (secuencia de estados, repartidor obligatorio para
-- "en camino", calificar solo entregados...) ya las hacen cumplir los triggers
-- de 02_triggers.sql; aquí solo se valida lo que el trigger no puede ver
-- (existencia de las llaves foráneas) y se arman las transacciones.
-- =====================================================================
USE domicilios;

DROP PROCEDURE IF EXISTS sp_repartidor_listar;
DROP PROCEDURE IF EXISTS sp_repartidor_obtener;
DROP PROCEDURE IF EXISTS sp_repartidor_crear;
DROP PROCEDURE IF EXISTS sp_repartidor_actualizar;
DROP PROCEDURE IF EXISTS sp_repartidor_eliminar;
DROP PROCEDURE IF EXISTS sp_pedido_listar;
DROP PROCEDURE IF EXISTS sp_pedido_obtener;
DROP PROCEDURE IF EXISTS sp_pedido_crear;
DROP PROCEDURE IF EXISTS sp_pedido_avanzar_estado;
DROP PROCEDURE IF EXISTS sp_calificar_pedido;

DELIMITER $$

-- =====================================================================
-- Repartidores (CRUD, mismo patrón de Clientes/Restaurantes)
-- =====================================================================

-- ---------------------------------------------------------------------
-- sp_repartidor_listar · búsqueda opcional por nombre, documento o placa
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_repartidor_listar(IN p_buscar VARCHAR(100))
BEGIN
  SELECT r.id_repartidor, r.documento, r.nombres, r.primer_apellido, r.segundo_apellido,
         r.telefono, r.tipo_vehiculo, r.placa, r.fecha_ingreso,
         (SELECT COUNT(*) FROM PEDIDO pe
           WHERE pe.id_repartidor = r.id_repartidor) AS num_pedidos,
         (SELECT ROUND(AVG(cal.nota_repartidor), 1)
            FROM PEDIDO pe JOIN CALIFICACION cal ON cal.id_pedido = pe.id_pedido
           WHERE pe.id_repartidor = r.id_repartidor) AS calificacion_promedio
    FROM REPARTIDOR r
   WHERE p_buscar IS NULL OR p_buscar = ''
      OR CONCAT_WS(' ', r.nombres, r.primer_apellido, r.segundo_apellido, r.documento, r.placa)
         LIKE CONCAT('%', p_buscar, '%')
   ORDER BY r.primer_apellido, r.nombres;
END$$

-- ---------------------------------------------------------------------
-- sp_repartidor_obtener · ficha de un repartidor con sus métricas
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_repartidor_obtener(IN p_id INT)
BEGIN
  DECLARE v_msg VARCHAR(200);

  IF NOT EXISTS (SELECT 1 FROM REPARTIDOR WHERE id_repartidor = p_id) THEN
    SET v_msg = CONCAT('No existe un repartidor con id ', COALESCE(p_id, 'NULL'), '.');
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = v_msg;
  END IF;

  SELECT r.id_repartidor, r.documento, r.nombres, r.primer_apellido, r.segundo_apellido,
         r.telefono, r.tipo_vehiculo, r.placa, r.fecha_ingreso,
         (SELECT COUNT(*) FROM PEDIDO pe
           WHERE pe.id_repartidor = r.id_repartidor) AS num_pedidos,
         (SELECT ROUND(AVG(cal.nota_repartidor), 1)
            FROM PEDIDO pe JOIN CALIFICACION cal ON cal.id_pedido = pe.id_pedido
           WHERE pe.id_repartidor = r.id_repartidor) AS calificacion_promedio
    FROM REPARTIDOR r
   WHERE r.id_repartidor = p_id;
END$$

-- ---------------------------------------------------------------------
-- sp_repartidor_crear · la bicicleta no lleva placa (ck_repartidor_placa
-- la hace cumplir de todas formas; aquí solo se limpia '' → NULL)
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_repartidor_crear(
  IN p_documento        VARCHAR(15),
  IN p_nombres          VARCHAR(60),
  IN p_primer_apellido  VARCHAR(40),
  IN p_segundo_apellido VARCHAR(40),
  IN p_telefono         VARCHAR(15),
  IN p_tipo_vehiculo    VARCHAR(10),
  IN p_placa            VARCHAR(10),
  IN p_fecha_ingreso    DATE
)
BEGIN
  IF p_fecha_ingreso > CURDATE() THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha de ingreso no puede ser futura.';
  END IF;

  INSERT INTO REPARTIDOR (documento, nombres, primer_apellido, segundo_apellido, telefono, tipo_vehiculo, placa, fecha_ingreso)
  VALUES (p_documento, p_nombres, p_primer_apellido, NULLIF(p_segundo_apellido, ''),
          p_telefono, p_tipo_vehiculo, NULLIF(p_placa, ''), p_fecha_ingreso);

  SELECT LAST_INSERT_ID() AS id_repartidor;
END$$

-- ---------------------------------------------------------------------
-- sp_repartidor_actualizar · actualiza los datos de un repartidor
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_repartidor_actualizar(
  IN p_id               INT,
  IN p_documento        VARCHAR(15),
  IN p_nombres          VARCHAR(60),
  IN p_primer_apellido  VARCHAR(40),
  IN p_segundo_apellido VARCHAR(40),
  IN p_telefono         VARCHAR(15),
  IN p_tipo_vehiculo    VARCHAR(10),
  IN p_placa            VARCHAR(10),
  IN p_fecha_ingreso    DATE
)
BEGIN
  DECLARE v_msg VARCHAR(200);

  IF NOT EXISTS (SELECT 1 FROM REPARTIDOR WHERE id_repartidor = p_id) THEN
    SET v_msg = CONCAT('No existe un repartidor con id ', COALESCE(p_id, 'NULL'), '.');
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = v_msg;
  END IF;

  IF p_fecha_ingreso > CURDATE() THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha de ingreso no puede ser futura.';
  END IF;

  UPDATE REPARTIDOR
     SET documento        = p_documento,
         nombres          = p_nombres,
         primer_apellido  = p_primer_apellido,
         segundo_apellido = NULLIF(p_segundo_apellido, ''),
         telefono         = p_telefono,
         tipo_vehiculo    = p_tipo_vehiculo,
         placa            = NULLIF(p_placa, ''),
         fecha_ingreso    = p_fecha_ingreso
   WHERE id_repartidor = p_id;
END$$

-- ---------------------------------------------------------------------
-- sp_repartidor_eliminar · conserva repartidores con pedidos (historia)
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_repartidor_eliminar(IN p_id INT)
BEGIN
  DECLARE v_pedidos INT;
  DECLARE v_msg     VARCHAR(200);

  IF NOT EXISTS (SELECT 1 FROM REPARTIDOR WHERE id_repartidor = p_id) THEN
    SET v_msg = CONCAT('No existe un repartidor con id ', COALESCE(p_id, 'NULL'), '.');
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = v_msg;
  END IF;

  SELECT COUNT(*) INTO v_pedidos FROM PEDIDO WHERE id_repartidor = p_id;

  IF v_pedidos > 0 THEN
    SET v_msg = CONCAT('No se puede eliminar: el repartidor tiene ', v_pedidos,
                       ' pedido(s) asignados y son historia del negocio.');
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_msg;
  END IF;

  DELETE FROM REPARTIDOR WHERE id_repartidor = p_id;
END$$

-- =====================================================================
-- Pedidos: transacción 1 (crear), transacción 2 (avanzar estado), calificar
-- =====================================================================

-- ---------------------------------------------------------------------
-- sp_pedido_listar · pestañas por estado del panel de operación.
-- p_id_estado NULL = todos. El estado actual es el de mayor secuencia
-- en HISTORIAL_ESTADO (atributo derivado, igual que fn_estado_actual).
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_pedido_listar(IN p_id_estado INT)
BEGIN
  SELECT pe.id_pedido,
         pe.id_cliente, c.nombres AS cliente_nombres, c.primer_apellido AS cliente_apellido,
         pe.id_restaurante, r.nombre AS restaurante,
         pe.id_repartidor, rep.nombres AS repartidor_nombres, rep.primer_apellido AS repartidor_apellido,
         pe.barrio, pe.ciudad, pe.metodo_pago,
         h.fecha_hora AS fecha_estado,
         est.id_estado, est.nombre AS estado_actual,
         fn_total_pedido(pe.id_pedido) AS total
    FROM PEDIDO pe
    JOIN CLIENTE c ON c.id_cliente = pe.id_cliente
    JOIN RESTAURANTE r ON r.id_restaurante = pe.id_restaurante
    LEFT JOIN REPARTIDOR rep ON rep.id_repartidor = pe.id_repartidor
    JOIN (SELECT id_pedido, MAX(secuencia) AS ultima FROM HISTORIAL_ESTADO GROUP BY id_pedido) u
      ON u.id_pedido = pe.id_pedido
    JOIN HISTORIAL_ESTADO h ON h.id_pedido = u.id_pedido AND h.secuencia = u.ultima
    JOIN ESTADO est ON est.id_estado = h.id_estado
   WHERE p_id_estado IS NULL OR est.id_estado = p_id_estado
   ORDER BY pe.id_pedido DESC;
END$$

-- ---------------------------------------------------------------------
-- sp_pedido_obtener · encabezado + líneas + historial + calificación
-- (4 conjuntos de resultados; el último puede venir vacío).
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_pedido_obtener(IN p_id INT)
BEGIN
  DECLARE v_msg VARCHAR(200);

  IF NOT EXISTS (SELECT 1 FROM PEDIDO WHERE id_pedido = p_id) THEN
    SET v_msg = CONCAT('No existe un pedido con id ', COALESCE(p_id, 'NULL'), '.');
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = v_msg;
  END IF;

  -- 1) Encabezado: datos propios + derivados (total, estado actual, tiempo de entrega)
  SELECT pe.id_pedido,
         pe.id_cliente, c.nombres AS cliente_nombres, c.primer_apellido AS cliente_apellido,
         c.segundo_apellido AS cliente_segundo_apellido, c.email AS cliente_email,
         pe.id_restaurante, r.nombre AS restaurante, r.direccion AS restaurante_direccion,
         pe.id_repartidor, rep.nombres AS repartidor_nombres, rep.primer_apellido AS repartidor_apellido,
         rep.telefono AS repartidor_telefono, rep.tipo_vehiculo AS repartidor_vehiculo,
         pe.calle, pe.numero, pe.barrio, pe.ciudad,
         pe.costo_envio, pe.metodo_pago,
         fn_total_pedido(pe.id_pedido)  AS total,
         fn_estado_actual(pe.id_pedido) AS estado_actual,
         fn_tiempo_entrega(pe.id_pedido) AS tiempo_entrega_minutos,
         (SELECT h.id_estado FROM HISTORIAL_ESTADO h
           WHERE h.id_pedido = pe.id_pedido ORDER BY h.secuencia DESC LIMIT 1) AS id_estado_actual,
         (SELECT h.fecha_hora FROM HISTORIAL_ESTADO h
           WHERE h.id_pedido = pe.id_pedido ORDER BY h.secuencia ASC LIMIT 1) AS fecha_creacion
    FROM PEDIDO pe
    JOIN CLIENTE c ON c.id_cliente = pe.id_cliente
    JOIN RESTAURANTE r ON r.id_restaurante = pe.id_restaurante
    LEFT JOIN REPARTIDOR rep ON rep.id_repartidor = pe.id_repartidor
   WHERE pe.id_pedido = p_id;

  -- 2) Líneas del pedido (la "comanda")
  SELECT dp.id_producto, p.nombre, dp.cantidad, dp.precio_unitario,
         (dp.cantidad * dp.precio_unitario) AS subtotal
    FROM DETALLE_PEDIDO dp
    JOIN PRODUCTO p ON p.id_producto = dp.id_producto
   WHERE dp.id_pedido = p_id
   ORDER BY p.nombre;

  -- 3) Historial de estados (el "riel")
  SELECT h.secuencia, h.id_estado, e.nombre AS estado, e.orden, h.fecha_hora, h.observacion
    FROM HISTORIAL_ESTADO h
    JOIN ESTADO e ON e.id_estado = h.id_estado
   WHERE h.id_pedido = p_id
   ORDER BY h.secuencia;

  -- 4) Calificación, si ya existe
  SELECT nota_restaurante, nota_repartidor, comentario, fecha
    FROM CALIFICACION
   WHERE id_pedido = p_id;
END$$

-- ---------------------------------------------------------------------
-- sp_pedido_crear · TRANSACCIÓN 1: PEDIDO + DETALLE_PEDIDO (n líneas,
-- recibidas como JSON) + HISTORIAL "recibido". Todo o nada: si una línea
-- viola un trigger (p. ej. producto de otro restaurante), el handler
-- deshace el pedido completo y reenvía el mensaje original.
--
-- p_detalle: '[{"id_producto":3,"cantidad":2}, {"id_producto":9,"cantidad":1}]'
-- El precio cobrado (precio_unitario) se toma de PRODUCTO.precio en este
-- instante: si el precio cambia después, la línea ya guardada no cambia.
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_pedido_crear(
  IN p_id_cliente     INT,
  IN p_id_restaurante INT,
  IN p_calle          VARCHAR(60),
  IN p_numero         VARCHAR(20),
  IN p_barrio         VARCHAR(60),
  IN p_ciudad         VARCHAR(60),
  IN p_costo_envio    INT,
  IN p_metodo_pago    VARCHAR(15),
  IN p_detalle        JSON
)
BEGIN
  DECLARE v_id  INT;
  DECLARE v_msg VARCHAR(200);

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;

  IF NOT EXISTS (SELECT 1 FROM CLIENTE WHERE id_cliente = p_id_cliente) THEN
    SET v_msg = CONCAT('No existe un cliente con id ', COALESCE(p_id_cliente, 'NULL'), '.');
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = v_msg;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM RESTAURANTE WHERE id_restaurante = p_id_restaurante) THEN
    SET v_msg = CONCAT('No existe un restaurante con id ', COALESCE(p_id_restaurante, 'NULL'), '.');
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = v_msg;
  END IF;

  IF p_detalle IS NULL OR JSON_TYPE(p_detalle) <> 'ARRAY' OR JSON_LENGTH(p_detalle) = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El pedido debe tener al menos un producto.';
  END IF;

  -- Regla de negocio que ni el CHECK ni el trigger ven: no se piden productos no disponibles
  IF EXISTS (
    SELECT 1
      FROM JSON_TABLE(p_detalle, '$[*]' COLUMNS (id_producto INT PATH '$.id_producto')) AS jt
      JOIN PRODUCTO prod ON prod.id_producto = jt.id_producto
     WHERE prod.disponible = FALSE
  ) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Uno de los productos del carrito ya no está disponible.';
  END IF;

  START TRANSACTION;

    INSERT INTO PEDIDO (id_cliente, id_restaurante, calle, numero, barrio, ciudad, costo_envio, metodo_pago)
    VALUES (p_id_cliente, p_id_restaurante, p_calle, p_numero, p_barrio, p_ciudad, COALESCE(p_costo_envio, 0), p_metodo_pago);

    SET v_id = LAST_INSERT_ID();

    -- Cada elemento del JSON se vuelve una línea; el precio se toma de PRODUCTO
    -- en este instante. Si el id_producto no existe, el INNER JOIN lo descarta
    -- y la FK fk_detalle_producto de todas formas lo habría rechazado:
    -- se valida antes para dar un mensaje claro en vez de uno genérico de FK.
    IF (SELECT COUNT(*) FROM JSON_TABLE(p_detalle, '$[*]' COLUMNS (id_producto INT PATH '$.id_producto')) AS jt)
       <> (SELECT COUNT(*)
             FROM JSON_TABLE(p_detalle, '$[*]' COLUMNS (id_producto INT PATH '$.id_producto')) AS jt
             JOIN PRODUCTO prod ON prod.id_producto = jt.id_producto) THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Uno de los productos del carrito ya no existe.';
    END IF;

    INSERT INTO DETALLE_PEDIDO (id_pedido, id_producto, cantidad, precio_unitario)
    SELECT v_id, jt.id_producto, jt.cantidad, prod.precio
      FROM JSON_TABLE(p_detalle, '$[*]' COLUMNS (
             id_producto INT PATH '$.id_producto',
             cantidad    INT PATH '$.cantidad'
           )) AS jt
      JOIN PRODUCTO prod ON prod.id_producto = jt.id_producto;

    -- Primer estado del pedido. El trigger trg_historial_bi calcula la
    -- secuencia real (1) y exige que el primero sea "recibido" (id_estado 1).
    INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado)
    VALUES (v_id, 1, 1);

  COMMIT;

  SELECT v_id AS id_pedido;
END$$

-- ---------------------------------------------------------------------
-- sp_pedido_avanzar_estado · TRANSACCIÓN 2: IF/ELSEIF según el estado destino.
--
-- - Si p_id_repartidor llega (no NULL), se asigna ANTES de insertar el nuevo
--   estado: para pasar a "en camino" el trigger exige que el pedido YA tenga
--   repartidor en ese momento (ver docs/estado del proyecto).
-- - La secuencia, el flujo 1→2→3→4, la cancelación solo desde 1/2 y el
--   repartidor obligatorio para "en camino" los valida trg_historial_bi;
--   aquí solo se resuelven las llaves foráneas (pedido, estado, repartidor).
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_pedido_avanzar_estado(
  IN p_id_pedido     INT,
  IN p_id_estado     INT,
  IN p_id_repartidor INT,
  IN p_observacion   VARCHAR(150)
)
BEGIN
  DECLARE v_msg VARCHAR(200);

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;

  IF NOT EXISTS (SELECT 1 FROM PEDIDO WHERE id_pedido = p_id_pedido) THEN
    SET v_msg = CONCAT('No existe un pedido con id ', COALESCE(p_id_pedido, 'NULL'), '.');
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = v_msg;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM ESTADO WHERE id_estado = p_id_estado) THEN
    SET v_msg = CONCAT('No existe un estado con id ', COALESCE(p_id_estado, 'NULL'), '.');
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = v_msg;
  END IF;

  IF p_id_repartidor IS NOT NULL
     AND NOT EXISTS (SELECT 1 FROM REPARTIDOR WHERE id_repartidor = p_id_repartidor) THEN
    SET v_msg = CONCAT('No existe un repartidor con id ', p_id_repartidor, '.');
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = v_msg;
  END IF;

  START TRANSACTION;

    IF p_id_repartidor IS NOT NULL THEN
      UPDATE PEDIDO SET id_repartidor = p_id_repartidor WHERE id_pedido = p_id_pedido;
    END IF;

    -- secuencia = 1 es solo un valor de relleno: trg_historial_bi la recalcula
    -- (MAX(secuencia) + 1 para este pedido) antes de insertar.
    INSERT INTO HISTORIAL_ESTADO (id_pedido, secuencia, id_estado, observacion)
    VALUES (p_id_pedido, 1, p_id_estado, NULLIF(p_observacion, ''));

  COMMIT;

  SELECT fn_estado_actual(p_id_pedido) AS estado_actual;
END$$

-- ---------------------------------------------------------------------
-- sp_calificar_pedido · dos notas 1-5 y comentario opcional.
-- trg_calificacion_bi ya exige que el pedido esté "entregado"; PRIMARY KEY
-- (id_pedido) de CALIFICACION ya impide dos calificaciones, pero se valida
-- antes para dar un mensaje claro en vez de un error 1062 genérico.
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_calificar_pedido(
  IN p_id_pedido        INT,
  IN p_nota_restaurante TINYINT,
  IN p_nota_repartidor  TINYINT,
  IN p_comentario       VARCHAR(300)
)
BEGIN
  DECLARE v_msg VARCHAR(200);

  IF NOT EXISTS (SELECT 1 FROM PEDIDO WHERE id_pedido = p_id_pedido) THEN
    SET v_msg = CONCAT('No existe un pedido con id ', COALESCE(p_id_pedido, 'NULL'), '.');
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = v_msg;
  END IF;

  IF EXISTS (SELECT 1 FROM CALIFICACION WHERE id_pedido = p_id_pedido) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Este pedido ya fue calificado.';
  END IF;

  INSERT INTO CALIFICACION (id_pedido, nota_restaurante, nota_repartidor, comentario)
  VALUES (p_id_pedido, p_nota_restaurante, p_nota_repartidor, NULLIF(p_comentario, ''));
END$$

DELIMITER ;
