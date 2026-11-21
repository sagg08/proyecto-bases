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

DELIMITER ;

-- Productos y combos (Fase 2)
