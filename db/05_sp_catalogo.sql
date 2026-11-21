-- =====================================================================
-- 05_sp_catalogo.sql · Restaurantes y Categorías (P2)
--
-- La aplicación solo accede a estos procedimientos mediante callProc().
-- SQLSTATE '45000' indica una regla de negocio; '45004', un registro inexistente.
-- =====================================================================
USE domicilios;

DROP PROCEDURE IF EXISTS sp_restaurante_listar;
DROP PROCEDURE IF EXISTS sp_restaurante_obtener;
DROP PROCEDURE IF EXISTS sp_restaurante_crear;
DROP PROCEDURE IF EXISTS sp_restaurante_actualizar;
DROP PROCEDURE IF EXISTS sp_restaurante_eliminar;
DROP PROCEDURE IF EXISTS sp_categoria_listar;
DROP PROCEDURE IF EXISTS sp_categoria_obtener;
DROP PROCEDURE IF EXISTS sp_categoria_crear;
DROP PROCEDURE IF EXISTS sp_categoria_actualizar;
DROP PROCEDURE IF EXISTS sp_categoria_eliminar;
DROP PROCEDURE IF EXISTS sp_producto_listar;
DROP PROCEDURE IF EXISTS sp_producto_obtener;
DROP PROCEDURE IF EXISTS sp_producto_crear;
DROP PROCEDURE IF EXISTS sp_producto_actualizar;
DROP PROCEDURE IF EXISTS sp_producto_cambiar_disponible;
DROP PROCEDURE IF EXISTS sp_producto_eliminar;
DROP PROCEDURE IF EXISTS sp_combo_crear;
DROP PROCEDURE IF EXISTS sp_combo_actualizar_componentes;
DROP PROCEDURE IF EXISTS sp_producto_menu;

DELIMITER $$

-- ---------------------------------------------------------------------
-- sp_restaurante_listar · búsqueda opcional por nombre o NIT
-- Incluye métricas del catálogo y calificaciones de los pedidos.
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_restaurante_listar(IN p_buscar VARCHAR(100))
BEGIN
  SELECT r.id_restaurante, r.nit, r.nombre, r.direccion, r.telefono, r.fecha_afiliacion,
         (SELECT COUNT(*) FROM PRODUCTO p
           WHERE p.id_restaurante = r.id_restaurante) AS num_productos,
         (SELECT GROUP_CONCAT(DISTINCT c.nombre ORDER BY c.nombre SEPARATOR ' · ')
            FROM PRODUCTO p
            JOIN CATEGORIA c ON c.id_categoria = p.id_categoria
           WHERE p.id_restaurante = r.id_restaurante) AS categorias,
         (SELECT c.nombre
            FROM PRODUCTO p
            JOIN CATEGORIA c ON c.id_categoria = p.id_categoria
           WHERE p.id_restaurante = r.id_restaurante
           GROUP BY p.id_categoria, c.nombre
           ORDER BY COUNT(*) DESC, c.nombre
           LIMIT 1) AS categoria_principal,
         (SELECT ROUND(AVG(cal.nota_restaurante), 1)
            FROM PEDIDO pe
            JOIN CALIFICACION cal ON cal.id_pedido = pe.id_pedido
           WHERE pe.id_restaurante = r.id_restaurante) AS calificacion_promedio,
         (SELECT COUNT(*)
            FROM PEDIDO pe
            JOIN CALIFICACION cal ON cal.id_pedido = pe.id_pedido
           WHERE pe.id_restaurante = r.id_restaurante) AS num_calificaciones
    FROM RESTAURANTE r
   WHERE p_buscar IS NULL OR p_buscar = ''
      OR r.nombre LIKE CONCAT('%', p_buscar, '%')
      OR r.nit LIKE CONCAT('%', p_buscar, '%')
   ORDER BY r.nombre;
END$$

-- ---------------------------------------------------------------------
-- sp_restaurante_obtener · detalle y métricas para una sola ficha
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_restaurante_obtener(IN p_id INT)
BEGIN
  DECLARE v_msg VARCHAR(200);

  IF NOT EXISTS (SELECT 1 FROM RESTAURANTE WHERE id_restaurante = p_id) THEN
    SET v_msg = CONCAT('No existe un restaurante con id ', COALESCE(p_id, 'NULL'), '.');
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = v_msg;
  END IF;

  SELECT r.id_restaurante, r.nit, r.nombre, r.direccion, r.telefono, r.fecha_afiliacion,
         (SELECT COUNT(*) FROM PRODUCTO p
           WHERE p.id_restaurante = r.id_restaurante) AS num_productos,
         (SELECT GROUP_CONCAT(DISTINCT c.nombre ORDER BY c.nombre SEPARATOR ' · ')
            FROM PRODUCTO p
            JOIN CATEGORIA c ON c.id_categoria = p.id_categoria
           WHERE p.id_restaurante = r.id_restaurante) AS categorias,
         (SELECT c.nombre
            FROM PRODUCTO p
            JOIN CATEGORIA c ON c.id_categoria = p.id_categoria
           WHERE p.id_restaurante = r.id_restaurante
           GROUP BY p.id_categoria, c.nombre
           ORDER BY COUNT(*) DESC, c.nombre
           LIMIT 1) AS categoria_principal,
         (SELECT COUNT(*) FROM PEDIDO pe
           WHERE pe.id_restaurante = r.id_restaurante) AS num_pedidos,
         (SELECT ROUND(AVG(cal.nota_restaurante), 1)
            FROM PEDIDO pe
            JOIN CALIFICACION cal ON cal.id_pedido = pe.id_pedido
           WHERE pe.id_restaurante = r.id_restaurante) AS calificacion_promedio,
         (SELECT COUNT(*)
            FROM PEDIDO pe
            JOIN CALIFICACION cal ON cal.id_pedido = pe.id_pedido
           WHERE pe.id_restaurante = r.id_restaurante) AS num_calificaciones
    FROM RESTAURANTE r
   WHERE r.id_restaurante = p_id;
END$$

-- ---------------------------------------------------------------------
-- sp_restaurante_crear · crea un restaurante
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_restaurante_crear(
  IN p_nit              VARCHAR(15),
  IN p_nombre           VARCHAR(80),
  IN p_direccion        VARCHAR(120),
  IN p_telefono         VARCHAR(15),
  IN p_fecha_afiliacion DATE
)
BEGIN
  IF p_fecha_afiliacion > CURDATE() THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'La fecha de afiliación no puede ser futura.';
  END IF;

  INSERT INTO RESTAURANTE (nit, nombre, direccion, telefono, fecha_afiliacion)
  VALUES (p_nit, p_nombre, p_direccion, p_telefono, p_fecha_afiliacion);

  SELECT LAST_INSERT_ID() AS id_restaurante;
END$$

-- ---------------------------------------------------------------------
-- sp_restaurante_actualizar · actualiza los datos de un restaurante
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_restaurante_actualizar(
  IN p_id               INT,
  IN p_nit              VARCHAR(15),
  IN p_nombre           VARCHAR(80),
  IN p_direccion        VARCHAR(120),
  IN p_telefono         VARCHAR(15),
  IN p_fecha_afiliacion DATE
)
BEGIN
  DECLARE v_msg VARCHAR(200);

  IF NOT EXISTS (SELECT 1 FROM RESTAURANTE WHERE id_restaurante = p_id) THEN
    SET v_msg = CONCAT('No existe un restaurante con id ', COALESCE(p_id, 'NULL'), '.');
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = v_msg;
  END IF;

  IF p_fecha_afiliacion > CURDATE() THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'La fecha de afiliación no puede ser futura.';
  END IF;

  UPDATE RESTAURANTE
     SET nit = p_nit,
         nombre = p_nombre,
         direccion = p_direccion,
         telefono = p_telefono,
         fecha_afiliacion = p_fecha_afiliacion
   WHERE id_restaurante = p_id;
END$$

-- ---------------------------------------------------------------------
-- sp_restaurante_eliminar · conserva restaurantes con productos o pedidos
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_restaurante_eliminar(IN p_id INT)
BEGIN
  DECLARE v_productos INT;
  DECLARE v_pedidos   INT;
  DECLARE v_msg       VARCHAR(200);

  IF NOT EXISTS (SELECT 1 FROM RESTAURANTE WHERE id_restaurante = p_id) THEN
    SET v_msg = CONCAT('No existe un restaurante con id ', COALESCE(p_id, 'NULL'), '.');
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = v_msg;
  END IF;

  SELECT COUNT(*) INTO v_productos FROM PRODUCTO WHERE id_restaurante = p_id;
  SELECT COUNT(*) INTO v_pedidos FROM PEDIDO WHERE id_restaurante = p_id;

  IF v_productos > 0 THEN
    SET v_msg = CONCAT('No se puede eliminar: el restaurante tiene ', v_productos,
                       ' productos registrados.');
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_msg;
  END IF;

  IF v_pedidos > 0 THEN
    SET v_msg = CONCAT('No se puede eliminar: el restaurante tiene ', v_pedidos,
                       ' pedidos registrados.');
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_msg;
  END IF;

  DELETE FROM RESTAURANTE WHERE id_restaurante = p_id;
END$$

-- ---------------------------------------------------------------------
-- sp_categoria_listar · categorías con su cantidad de productos
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_categoria_listar()
BEGIN
  SELECT c.id_categoria, c.nombre,
         (SELECT COUNT(*) FROM PRODUCTO p
           WHERE p.id_categoria = c.id_categoria) AS num_productos
    FROM CATEGORIA c
   ORDER BY c.nombre;
END$$

-- ---------------------------------------------------------------------
-- sp_categoria_obtener · detalle de una categoría
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_categoria_obtener(IN p_id INT)
BEGIN
  DECLARE v_msg VARCHAR(200);

  IF NOT EXISTS (SELECT 1 FROM CATEGORIA WHERE id_categoria = p_id) THEN
    SET v_msg = CONCAT('No existe una categoría con id ', COALESCE(p_id, 'NULL'), '.');
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = v_msg;
  END IF;

  SELECT c.id_categoria, c.nombre,
         (SELECT COUNT(*) FROM PRODUCTO p
           WHERE p.id_categoria = c.id_categoria) AS num_productos
    FROM CATEGORIA c
   WHERE c.id_categoria = p_id;
END$$

-- ---------------------------------------------------------------------
-- sp_categoria_crear · crea una categoría
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_categoria_crear(IN p_nombre VARCHAR(40))
BEGIN
  INSERT INTO CATEGORIA (nombre) VALUES (p_nombre);
  SELECT LAST_INSERT_ID() AS id_categoria;
END$$

-- ---------------------------------------------------------------------
-- sp_categoria_actualizar · actualiza el nombre de una categoría
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_categoria_actualizar(IN p_id INT, IN p_nombre VARCHAR(40))
BEGIN
  DECLARE v_msg VARCHAR(200);

  IF NOT EXISTS (SELECT 1 FROM CATEGORIA WHERE id_categoria = p_id) THEN
    SET v_msg = CONCAT('No existe una categoría con id ', COALESCE(p_id, 'NULL'), '.');
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = v_msg;
  END IF;

  UPDATE CATEGORIA SET nombre = p_nombre WHERE id_categoria = p_id;
END$$

-- ---------------------------------------------------------------------
-- sp_categoria_eliminar · no elimina categorías referenciadas por productos
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_categoria_eliminar(IN p_id INT)
BEGIN
  DECLARE v_productos INT;
  DECLARE v_msg       VARCHAR(200);

  IF NOT EXISTS (SELECT 1 FROM CATEGORIA WHERE id_categoria = p_id) THEN
    SET v_msg = CONCAT('No existe una categoría con id ', COALESCE(p_id, 'NULL'), '.');
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = v_msg;
  END IF;

  SELECT COUNT(*) INTO v_productos FROM PRODUCTO WHERE id_categoria = p_id;

  IF v_productos > 0 THEN
    SET v_msg = CONCAT('No se puede eliminar: la categoría tiene ', v_productos,
                       ' productos registrados.');
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_msg;
  END IF;

  DELETE FROM CATEGORIA WHERE id_categoria = p_id;
END$$

-- Productos y combos (Fase 2)

-- ---------------------------------------------------------------------
-- sp_producto_listar · filtros opcionales por texto, restaurante y categoría
-- es_combo se deriva de COMBO_COMPONENTE; las ventas cuentan sus líneas.
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_producto_listar(
  IN p_buscar        VARCHAR(100),
  IN p_id_restaurante INT,
  IN p_id_categoria   INT
)
BEGIN
  SELECT p.id_producto, p.nombre, p.descripcion, p.precio, p.disponible,
         r.id_restaurante, r.nombre AS restaurante,
         c.id_categoria, c.nombre AS categoria,
         EXISTS (SELECT 1 FROM COMBO_COMPONENTE cc
                  WHERE cc.id_combo = p.id_producto) AS es_combo,
         (SELECT COUNT(*) FROM COMBO_COMPONENTE cc
           WHERE cc.id_combo = p.id_producto) AS num_componentes,
         (SELECT COUNT(*) FROM DETALLE_PEDIDO dp
           WHERE dp.id_producto = p.id_producto) AS veces_vendido
    FROM PRODUCTO p
    JOIN RESTAURANTE r ON r.id_restaurante = p.id_restaurante
    JOIN CATEGORIA c ON c.id_categoria = p.id_categoria
   WHERE (p_buscar IS NULL OR p_buscar = ''
          OR p.nombre LIKE CONCAT('%', p_buscar, '%'))
     AND (p_id_restaurante IS NULL OR p.id_restaurante = p_id_restaurante)
     AND (p_id_categoria IS NULL OR p.id_categoria = p_id_categoria)
   ORDER BY r.nombre, c.nombre, p.nombre;
END$$

-- ---------------------------------------------------------------------
-- sp_producto_obtener · ficha, componentes y combos que incluyen el producto
-- Devuelve tres conjuntos de resultados, incluso si los dos últimos están vacíos.
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_producto_obtener(IN p_id INT)
BEGIN
  DECLARE v_msg VARCHAR(200);

  IF NOT EXISTS (SELECT 1 FROM PRODUCTO WHERE id_producto = p_id) THEN
    SET v_msg = CONCAT('No existe un producto con id ', COALESCE(p_id, 'NULL'), '.');
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = v_msg;
  END IF;

  SELECT p.id_producto, p.nombre, p.descripcion, p.precio, p.disponible,
         r.id_restaurante, r.nombre AS restaurante,
         c.id_categoria, c.nombre AS categoria,
         EXISTS (SELECT 1 FROM COMBO_COMPONENTE cc
                  WHERE cc.id_combo = p.id_producto) AS es_combo,
         (SELECT COUNT(*) FROM COMBO_COMPONENTE cc
           WHERE cc.id_combo = p.id_producto) AS num_componentes,
         (SELECT COUNT(*) FROM DETALLE_PEDIDO dp
           WHERE dp.id_producto = p.id_producto) AS veces_vendido
    FROM PRODUCTO p
    JOIN RESTAURANTE r ON r.id_restaurante = p.id_restaurante
    JOIN CATEGORIA c ON c.id_categoria = p.id_categoria
   WHERE p.id_producto = p_id;

  SELECT componente.id_producto, componente.nombre, componente.precio, cc.cantidad
    FROM COMBO_COMPONENTE cc
    JOIN PRODUCTO componente ON componente.id_producto = cc.id_componente
   WHERE cc.id_combo = p_id
   ORDER BY componente.nombre;

  SELECT combo.id_producto, combo.nombre
    FROM COMBO_COMPONENTE cc
    JOIN PRODUCTO combo ON combo.id_producto = cc.id_combo
   WHERE cc.id_componente = p_id
   ORDER BY combo.nombre;
END$$

-- ---------------------------------------------------------------------
-- sp_producto_crear · crea un producto disponible
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_producto_crear(
  IN p_id_restaurante INT,
  IN p_id_categoria   INT,
  IN p_nombre         VARCHAR(80),
  IN p_descripcion    VARCHAR(200),
  IN p_precio         INT
)
BEGIN
  INSERT INTO PRODUCTO (id_restaurante, id_categoria, nombre, descripcion, precio)
  VALUES (p_id_restaurante, p_id_categoria, p_nombre, NULLIF(p_descripcion, ''), p_precio);

  SELECT LAST_INSERT_ID() AS id_producto;
END$$

-- ---------------------------------------------------------------------
-- sp_producto_actualizar · actualiza los datos descriptivos del producto
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_producto_actualizar(
  IN p_id              INT,
  IN p_id_restaurante  INT,
  IN p_id_categoria    INT,
  IN p_nombre          VARCHAR(80),
  IN p_descripcion     VARCHAR(200),
  IN p_precio          INT
)
BEGIN
  DECLARE v_msg VARCHAR(200);

  IF NOT EXISTS (SELECT 1 FROM PRODUCTO WHERE id_producto = p_id) THEN
    SET v_msg = CONCAT('No existe un producto con id ', COALESCE(p_id, 'NULL'), '.');
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = v_msg;
  END IF;

  UPDATE PRODUCTO
     SET id_restaurante = p_id_restaurante,
         id_categoria = p_id_categoria,
         nombre = p_nombre,
         descripcion = NULLIF(p_descripcion, ''),
         precio = p_precio
   WHERE id_producto = p_id;
END$$

-- ---------------------------------------------------------------------
-- sp_producto_cambiar_disponible · activa o desactiva un producto
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_producto_cambiar_disponible(IN p_id INT, IN p_disponible BOOLEAN)
BEGIN
  DECLARE v_msg VARCHAR(200);

  IF NOT EXISTS (SELECT 1 FROM PRODUCTO WHERE id_producto = p_id) THEN
    SET v_msg = CONCAT('No existe un producto con id ', COALESCE(p_id, 'NULL'), '.');
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = v_msg;
  END IF;

  UPDATE PRODUCTO SET disponible = p_disponible WHERE id_producto = p_id;
END$$

-- ---------------------------------------------------------------------
-- sp_producto_eliminar · conserva productos vendidos o usados en combos
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_producto_eliminar(IN p_id INT)
BEGIN
  DECLARE v_msg VARCHAR(200);

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;

  IF NOT EXISTS (SELECT 1 FROM PRODUCTO WHERE id_producto = p_id) THEN
    SET v_msg = CONCAT('No existe un producto con id ', COALESCE(p_id, 'NULL'), '.');
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = v_msg;
  END IF;

  IF EXISTS (SELECT 1 FROM DETALLE_PEDIDO WHERE id_producto = p_id)
     OR EXISTS (SELECT 1 FROM COMBO_COMPONENTE WHERE id_componente = p_id) THEN
    UPDATE PRODUCTO SET disponible = FALSE WHERE id_producto = p_id;
    SELECT 'desactivado' AS accion,
           'El producto ya fue vendido o forma parte de un combo; quedó no disponible para conservar el historial.' AS mensaje;
  ELSEIF EXISTS (SELECT 1 FROM COMBO_COMPONENTE WHERE id_combo = p_id) THEN
    START TRANSACTION;
      DELETE FROM COMBO_COMPONENTE WHERE id_combo = p_id;
      DELETE FROM PRODUCTO WHERE id_producto = p_id;
    COMMIT;
    SELECT 'eliminado' AS accion, 'Combo eliminado junto con sus componentes.' AS mensaje;
  ELSE
    DELETE FROM PRODUCTO WHERE id_producto = p_id;
    SELECT 'eliminado' AS accion, 'Producto eliminado.' AS mensaje;
  END IF;
END$$

-- ---------------------------------------------------------------------
-- sp_combo_crear · crea el producto combo y sus componentes en una transacción
-- Las reglas de restaurante y nivel único las aplica trg_combo_bi.
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_combo_crear(
  IN p_id_restaurante INT,
  IN p_id_categoria   INT,
  IN p_nombre         VARCHAR(80),
  IN p_descripcion    VARCHAR(200),
  IN p_precio         INT,
  IN p_componentes    JSON
)
BEGIN
  DECLARE v_id INT;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;

  IF p_componentes IS NULL
     OR JSON_TYPE(p_componentes) <> 'ARRAY'
     OR JSON_LENGTH(p_componentes) = 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'El combo debe tener al menos un producto componente.';
  END IF;

  START TRANSACTION;

    INSERT INTO PRODUCTO (id_restaurante, id_categoria, nombre, descripcion, precio)
    VALUES (p_id_restaurante, p_id_categoria, p_nombre, NULLIF(p_descripcion, ''), p_precio);

    SET v_id = LAST_INSERT_ID();

    INSERT INTO COMBO_COMPONENTE (id_combo, id_componente, cantidad)
    SELECT v_id, jt.id_producto, jt.cantidad
      FROM JSON_TABLE(
        p_componentes,
        '$[*]' COLUMNS (
          id_producto INT PATH '$.id_producto',
          cantidad    INT PATH '$.cantidad'
        )
      ) AS jt;

  COMMIT;

  SELECT v_id AS id_producto;
END$$

-- ---------------------------------------------------------------------
-- sp_combo_actualizar_componentes · reemplaza componentes sin perder los previos
-- Si una regla del trigger falla, el handler revierte el DELETE y los INSERT.
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_combo_actualizar_componentes(IN p_id_combo INT, IN p_componentes JSON)
BEGIN
  DECLARE v_msg VARCHAR(200);

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;

  IF NOT EXISTS (SELECT 1 FROM PRODUCTO WHERE id_producto = p_id_combo) THEN
    SET v_msg = CONCAT('No existe un producto con id ', COALESCE(p_id_combo, 'NULL'), '.');
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = v_msg;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM COMBO_COMPONENTE WHERE id_combo = p_id_combo) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'El producto indicado no es un combo y no tiene componentes para actualizar.';
  END IF;

  IF p_componentes IS NULL
     OR JSON_TYPE(p_componentes) <> 'ARRAY'
     OR JSON_LENGTH(p_componentes) = 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'El combo debe tener al menos un producto componente.';
  END IF;

  START TRANSACTION;

    DELETE FROM COMBO_COMPONENTE WHERE id_combo = p_id_combo;

    INSERT INTO COMBO_COMPONENTE (id_combo, id_componente, cantidad)
    SELECT p_id_combo, jt.id_producto, jt.cantidad
      FROM JSON_TABLE(
        p_componentes,
        '$[*]' COLUMNS (
          id_producto INT PATH '$.id_producto',
          cantidad    INT PATH '$.cantidad'
        )
      ) AS jt;

  COMMIT;
END$$

-- ---------------------------------------------------------------------
-- sp_producto_menu · ficha del restaurante, productos y componentes de combos
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_producto_menu(IN p_id_restaurante INT)
BEGIN
  DECLARE v_msg VARCHAR(200);

  IF NOT EXISTS (SELECT 1 FROM RESTAURANTE WHERE id_restaurante = p_id_restaurante) THEN
    SET v_msg = CONCAT('No existe un restaurante con id ', COALESCE(p_id_restaurante, 'NULL'), '.');
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = v_msg;
  END IF;

  SELECT r.id_restaurante, r.nit, r.nombre, r.direccion, r.telefono, r.fecha_afiliacion,
         (SELECT COUNT(*) FROM PRODUCTO p
           WHERE p.id_restaurante = r.id_restaurante) AS num_productos,
         (SELECT GROUP_CONCAT(DISTINCT c.nombre ORDER BY c.nombre SEPARATOR ' · ')
            FROM PRODUCTO p
            JOIN CATEGORIA c ON c.id_categoria = p.id_categoria
           WHERE p.id_restaurante = r.id_restaurante) AS categorias,
         (SELECT c.nombre
            FROM PRODUCTO p
            JOIN CATEGORIA c ON c.id_categoria = p.id_categoria
           WHERE p.id_restaurante = r.id_restaurante
           GROUP BY p.id_categoria, c.nombre
           ORDER BY COUNT(*) DESC, c.nombre
           LIMIT 1) AS categoria_principal,
         (SELECT COUNT(*) FROM PEDIDO pe
           WHERE pe.id_restaurante = r.id_restaurante) AS num_pedidos,
         (SELECT ROUND(AVG(cal.nota_restaurante), 1)
            FROM PEDIDO pe
            JOIN CALIFICACION cal ON cal.id_pedido = pe.id_pedido
           WHERE pe.id_restaurante = r.id_restaurante) AS calificacion_promedio,
         (SELECT COUNT(*)
            FROM PEDIDO pe
            JOIN CALIFICACION cal ON cal.id_pedido = pe.id_pedido
           WHERE pe.id_restaurante = r.id_restaurante) AS num_calificaciones
    FROM RESTAURANTE r
   WHERE r.id_restaurante = p_id_restaurante;

  SELECT p.id_producto, p.nombre, p.descripcion, p.precio, p.disponible,
         p.id_categoria, c.nombre AS categoria,
         EXISTS (SELECT 1 FROM COMBO_COMPONENTE cc
                  WHERE cc.id_combo = p.id_producto) AS es_combo
    FROM PRODUCTO p
    JOIN CATEGORIA c ON c.id_categoria = p.id_categoria
   WHERE p.id_restaurante = p_id_restaurante
   ORDER BY c.nombre, p.nombre;

  SELECT cc.id_combo, cc.id_componente,
         componente.nombre AS nombre_componente, cc.cantidad
    FROM COMBO_COMPONENTE cc
    JOIN PRODUCTO combo ON combo.id_producto = cc.id_combo
    JOIN PRODUCTO componente ON componente.id_producto = cc.id_componente
   WHERE combo.id_restaurante = p_id_restaurante
   ORDER BY cc.id_combo, componente.nombre;
END$$

DELIMITER ;
