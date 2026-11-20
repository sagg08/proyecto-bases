-- =====================================================================
-- 05_sp_clientes.sql · Procedimientos del módulo Clientes
--
-- La aplicación NUNCA escribe SQL suelto: solo llama estos procedimientos
-- (requisito 4.2). Este archivo es la PLANTILLA para los demás módulos.
--
-- Convención de errores (la usa app/db/errores.js para responder):
--   SQLSTATE '45000' → regla de negocio violada   → la app responde 400
--   SQLSTATE '45004' → el registro no existe      → la app responde 404
-- SIGNAL corta el procedimiento y devuelve el mensaje a quien lo llamó.
--
-- Teléfonos (atributo multivaluado): llegan como arreglo JSON, p. ej.
--   '["3104558821", "3009127734"]'
-- y se convierten en filas con JSON_TABLE.
-- =====================================================================
USE domicilios;

DROP PROCEDURE IF EXISTS sp_cliente_listar;
DROP PROCEDURE IF EXISTS sp_cliente_obtener;
DROP PROCEDURE IF EXISTS sp_cliente_crear;
DROP PROCEDURE IF EXISTS sp_cliente_actualizar;
DROP PROCEDURE IF EXISTS sp_cliente_eliminar;

DELIMITER $$

-- ---------------------------------------------------------------------
-- sp_cliente_listar · lista clientes con búsqueda opcional
-- p_buscar NULL o '' = todos. Busca en nombre completo y correo.
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_cliente_listar(IN p_buscar VARCHAR(100))
BEGIN
  SELECT c.id_cliente,
         c.nombres, c.primer_apellido, c.segundo_apellido,
         c.email,
         fn_edad(c.fecha_nacimiento) AS edad,              -- derivado calculado
         c.fecha_registro,
         (SELECT GROUP_CONCAT(t.telefono ORDER BY t.telefono SEPARATOR ' · ')
            FROM TELEFONO_CLIENTE t WHERE t.id_cliente = c.id_cliente) AS telefonos,
         (SELECT COUNT(*) FROM PEDIDO p WHERE p.id_cliente = c.id_cliente) AS num_pedidos
    FROM CLIENTE c
   WHERE p_buscar IS NULL OR p_buscar = ''
      OR CONCAT_WS(' ', c.nombres, c.primer_apellido, c.segundo_apellido, c.email)
         LIKE CONCAT('%', p_buscar, '%')
   ORDER BY c.primer_apellido, c.nombres;
END$$

-- ---------------------------------------------------------------------
-- sp_cliente_obtener · un cliente + sus teléfonos (dos conjuntos de resultados)
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_cliente_obtener(IN p_id INT)
BEGIN
  DECLARE v_msg VARCHAR(200);

  IF NOT EXISTS (SELECT 1 FROM CLIENTE WHERE id_cliente = p_id) THEN
    SET v_msg = CONCAT('No existe un cliente con id ', COALESCE(p_id, 'NULL'), '.');
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = v_msg;
  END IF;

  -- Resultado 1: datos del cliente
  SELECT c.id_cliente, c.nombres, c.primer_apellido, c.segundo_apellido, c.email,
         c.fecha_nacimiento, fn_edad(c.fecha_nacimiento) AS edad, c.fecha_registro,
         (SELECT COUNT(*) FROM PEDIDO p WHERE p.id_cliente = c.id_cliente) AS num_pedidos
    FROM CLIENTE c
   WHERE c.id_cliente = p_id;

  -- Resultado 2: sus teléfonos
  SELECT telefono FROM TELEFONO_CLIENTE WHERE id_cliente = p_id ORDER BY telefono;
END$$

-- ---------------------------------------------------------------------
-- sp_cliente_crear · TRANSACCIÓN: CLIENTE + TELEFONO_CLIENTE (todo o nada)
-- Si falla cualquier INSERT (p. ej. teléfono repetido), el handler hace
-- ROLLBACK y RESIGNAL reenvía el error original a la aplicación.
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_cliente_crear(
  IN p_nombres          VARCHAR(60),
  IN p_primer_apellido  VARCHAR(40),
  IN p_segundo_apellido VARCHAR(40),
  IN p_email            VARCHAR(100),
  IN p_fecha_nacimiento DATE,
  IN p_telefonos        JSON
)
BEGIN
  DECLARE v_id  INT;
  DECLARE v_msg VARCHAR(200);

  -- Ante cualquier error SQL: deshacer y reenviar el error tal cual
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;

  -- Validaciones con mensajes específicos (antes de tocar las tablas)
  IF p_telefonos IS NULL OR JSON_LENGTH(p_telefonos) = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El cliente debe tener al menos un teléfono.';
  END IF;

  IF p_fecha_nacimiento > CURDATE() THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha de nacimiento no puede ser futura.';
  END IF;

  IF EXISTS (SELECT 1 FROM CLIENTE WHERE email = p_email) THEN
    SET v_msg = CONCAT('Ya existe un cliente con el correo ', p_email, '.');
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_msg;
  END IF;

  START TRANSACTION;

    INSERT INTO CLIENTE (nombres, primer_apellido, segundo_apellido, email, fecha_nacimiento)
    VALUES (p_nombres, p_primer_apellido, NULLIF(p_segundo_apellido, ''), p_email, p_fecha_nacimiento);

    SET v_id = LAST_INSERT_ID();   -- id generado por AUTO_INCREMENT en esta conexión

    -- Cada elemento del arreglo JSON se vuelve una fila de TELEFONO_CLIENTE
    INSERT INTO TELEFONO_CLIENTE (id_cliente, telefono)
    SELECT v_id, jt.telefono
      FROM JSON_TABLE(p_telefonos, '$[*]' COLUMNS (telefono VARCHAR(15) PATH '$')) AS jt;

  COMMIT;

  SELECT v_id AS id_cliente;
END$$

-- ---------------------------------------------------------------------
-- sp_cliente_actualizar · TRANSACCIÓN: actualiza datos y reemplaza teléfonos
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_cliente_actualizar(
  IN p_id               INT,
  IN p_nombres          VARCHAR(60),
  IN p_primer_apellido  VARCHAR(40),
  IN p_segundo_apellido VARCHAR(40),
  IN p_email            VARCHAR(100),
  IN p_fecha_nacimiento DATE,
  IN p_telefonos        JSON
)
BEGIN
  DECLARE v_msg VARCHAR(200);

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;

  IF NOT EXISTS (SELECT 1 FROM CLIENTE WHERE id_cliente = p_id) THEN
    SET v_msg = CONCAT('No existe un cliente con id ', COALESCE(p_id, 'NULL'), '.');
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = v_msg;
  END IF;

  IF p_telefonos IS NULL OR JSON_LENGTH(p_telefonos) = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El cliente debe tener al menos un teléfono.';
  END IF;

  IF p_fecha_nacimiento > CURDATE() THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha de nacimiento no puede ser futura.';
  END IF;

  -- El correo puede ser el mismo del cliente, pero no el de OTRO cliente
  IF EXISTS (SELECT 1 FROM CLIENTE WHERE email = p_email AND id_cliente <> p_id) THEN
    SET v_msg = CONCAT('Ya existe otro cliente con el correo ', p_email, '.');
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_msg;
  END IF;

  START TRANSACTION;

    UPDATE CLIENTE
       SET nombres          = p_nombres,
           primer_apellido  = p_primer_apellido,
           segundo_apellido = NULLIF(p_segundo_apellido, ''),
           email            = p_email,
           fecha_nacimiento = p_fecha_nacimiento
     WHERE id_cliente = p_id;

    -- Reemplazo completo del multivaluado: más simple y correcto que comparar uno a uno
    DELETE FROM TELEFONO_CLIENTE WHERE id_cliente = p_id;

    INSERT INTO TELEFONO_CLIENTE (id_cliente, telefono)
    SELECT p_id, jt.telefono
      FROM JSON_TABLE(p_telefonos, '$[*]' COLUMNS (telefono VARCHAR(15) PATH '$')) AS jt;

  COMMIT;
END$$

-- ---------------------------------------------------------------------
-- sp_cliente_eliminar · borra un cliente sin pedidos
-- Sus teléfonos se borran solos (ON DELETE CASCADE). Si tiene pedidos,
-- la FK RESTRICT lo impediría con un error genérico; aquí damos uno claro.
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_cliente_eliminar(IN p_id INT)
BEGIN
  DECLARE v_pedidos INT;
  DECLARE v_msg     VARCHAR(200);

  IF NOT EXISTS (SELECT 1 FROM CLIENTE WHERE id_cliente = p_id) THEN
    SET v_msg = CONCAT('No existe un cliente con id ', COALESCE(p_id, 'NULL'), '.');
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = v_msg;
  END IF;

  SELECT COUNT(*) INTO v_pedidos FROM PEDIDO WHERE id_cliente = p_id;

  IF v_pedidos > 0 THEN
    SET v_msg = CONCAT('No se puede eliminar: el cliente tiene ', v_pedidos,
                       ' pedido(s) y los pedidos son historia del negocio.');
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_msg;
  END IF;

  DELETE FROM CLIENTE WHERE id_cliente = p_id;
END$$

DELIMITER ;
