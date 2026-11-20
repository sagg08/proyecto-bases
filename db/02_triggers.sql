-- =====================================================================
-- 02_triggers.sql · Reglas de negocio que un CHECK no puede expresar
--
-- Un CHECK solo ve columnas de la MISMA fila. Estas reglas comparan datos
-- de varias tablas, así que se garantizan con triggers BEFORE INSERT/UPDATE.
-- Si la regla falla, el trigger lanza SIGNAL SQLSTATE '45000' con un mensaje
-- claro: la operación se cancela y el mensaje le llega a la aplicación.
--
-- Por qué trigger y no solo procedimiento: un procedimiento se puede saltar
-- con un INSERT directo; el trigger se ejecuta SIEMPRE (avance, sección 5).
--
-- Nota: DELIMITER cambia el fin de instrucción a $$ para que los ";" internos
-- del cuerpo no corten el CREATE TRIGGER. Funciona en el cliente mysql y en
-- MySQL Workbench; scripts/db-setup.js también lo entiende.
-- =====================================================================
USE domicilios;

DELIMITER $$

-- ---------------------------------------------------------------------
-- 1. DETALLE_PEDIDO: todos los productos son del restaurante del pedido
-- ---------------------------------------------------------------------
CREATE TRIGGER trg_detalle_bi BEFORE INSERT ON DETALLE_PEDIDO
FOR EACH ROW
BEGIN
  IF (SELECT id_restaurante FROM PRODUCTO WHERE id_producto = NEW.id_producto)
     <> (SELECT id_restaurante FROM PEDIDO WHERE id_pedido = NEW.id_pedido) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'El producto no pertenece al restaurante del pedido.';
  END IF;
END$$

CREATE TRIGGER trg_detalle_bu BEFORE UPDATE ON DETALLE_PEDIDO
FOR EACH ROW
BEGIN
  IF (SELECT id_restaurante FROM PRODUCTO WHERE id_producto = NEW.id_producto)
     <> (SELECT id_restaurante FROM PEDIDO WHERE id_pedido = NEW.id_pedido) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'El producto no pertenece al restaurante del pedido.';
  END IF;
END$$

-- ---------------------------------------------------------------------
-- 2. COMBO_COMPONENTE: mismo restaurante y un solo nivel (supuesto 5)
--    - el componente no puede ser a su vez un combo
--    - el combo no puede ser componente de otro combo
--    Un solo nivel también hace imposibles los ciclos.
-- ---------------------------------------------------------------------
CREATE PROCEDURE validar_combo_componente(IN p_combo INT, IN p_componente INT)
BEGIN
  IF (SELECT id_restaurante FROM PRODUCTO WHERE id_producto = p_combo)
     <> (SELECT id_restaurante FROM PRODUCTO WHERE id_producto = p_componente) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'El combo y su componente deben ser del mismo restaurante.';
  END IF;

  IF EXISTS (SELECT 1 FROM COMBO_COMPONENTE WHERE id_combo = p_componente) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Un combo no puede contener otro combo.';
  END IF;

  IF EXISTS (SELECT 1 FROM COMBO_COMPONENTE WHERE id_componente = p_combo) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Este producto ya es componente de un combo; no puede ser combo.';
  END IF;
END$$

CREATE TRIGGER trg_combo_bi BEFORE INSERT ON COMBO_COMPONENTE
FOR EACH ROW
BEGIN
  CALL validar_combo_componente(NEW.id_combo, NEW.id_componente);
END$$

CREATE TRIGGER trg_combo_bu BEFORE UPDATE ON COMBO_COMPONENTE
FOR EACH ROW
BEGIN
  CALL validar_combo_componente(NEW.id_combo, NEW.id_componente);
END$$

-- ---------------------------------------------------------------------
-- 3. HISTORIAL_ESTADO: secuencia automática + flujo de estados (supuestos 1-3)
--    recibido(1) → en preparación(2) → en camino(3) → entregado(4)
--    cancelado(0) solo desde recibido o en preparación.
--    Nada después de entregado o cancelado.
--    Para pasar a "en camino" el pedido debe tener repartidor.
-- ---------------------------------------------------------------------
CREATE TRIGGER trg_historial_bi BEFORE INSERT ON HISTORIAL_ESTADO
FOR EACH ROW
BEGIN
  DECLARE v_orden_nuevo  TINYINT;
  DECLARE v_orden_actual TINYINT DEFAULT NULL;   -- NULL = el pedido aún no tiene estados

  -- Secuencia consecutiva dentro del pedido: 1, 2, 3...
  SET NEW.secuencia = (SELECT COALESCE(MAX(secuencia), 0) + 1
                         FROM HISTORIAL_ESTADO WHERE id_pedido = NEW.id_pedido);

  SELECT orden INTO v_orden_nuevo FROM ESTADO WHERE id_estado = NEW.id_estado;

  -- Estado actual = el de mayor secuencia (atributo derivado estado_actual)
  SELECT e.orden INTO v_orden_actual
    FROM HISTORIAL_ESTADO h JOIN ESTADO e ON e.id_estado = h.id_estado
   WHERE h.id_pedido = NEW.id_pedido
   ORDER BY h.secuencia DESC
   LIMIT 1;

  IF v_orden_actual IS NULL THEN
    -- Primer estado del pedido: tiene que ser "recibido"
    IF v_orden_nuevo <> 1 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El primer estado de un pedido debe ser "recibido".';
    END IF;
  ELSEIF v_orden_actual IN (0, 4) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'El pedido ya fue entregado o cancelado; no admite más cambios de estado.';
  ELSEIF v_orden_nuevo = 0 THEN
    IF v_orden_actual NOT IN (1, 2) THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Solo se puede cancelar un pedido "recibido" o "en preparación".';
    END IF;
  ELSEIF v_orden_nuevo <> v_orden_actual + 1 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Transición inválida: los estados avanzan en orden, sin saltos ni retrocesos.';
  END IF;

  IF v_orden_nuevo = 3
     AND (SELECT id_repartidor FROM PEDIDO WHERE id_pedido = NEW.id_pedido) IS NULL THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Para pasar a "en camino" el pedido debe tener un repartidor asignado.';
  END IF;
END$$

-- ---------------------------------------------------------------------
-- 4. PEDIDO: no se asigna repartidor a un pedido entregado o cancelado
--    (la cancelación sí puede dejarlo en NULL: supuesto 2)
-- ---------------------------------------------------------------------
CREATE TRIGGER trg_pedido_bu BEFORE UPDATE ON PEDIDO
FOR EACH ROW
BEGIN
  IF NEW.id_repartidor IS NOT NULL
     AND NOT (NEW.id_repartidor <=> OLD.id_repartidor)   -- <=> compara tratando NULL como valor
     AND (SELECT e.orden
            FROM HISTORIAL_ESTADO h JOIN ESTADO e ON e.id_estado = h.id_estado
           WHERE h.id_pedido = NEW.id_pedido
           ORDER BY h.secuencia DESC LIMIT 1) IN (0, 4) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'No se puede asignar repartidor a un pedido entregado o cancelado.';
  END IF;
END$$

-- ---------------------------------------------------------------------
-- 5. CALIFICACION: solo pedidos cuyo estado actual es "entregado" (supuesto 4)
-- ---------------------------------------------------------------------
CREATE TRIGGER trg_calificacion_bi BEFORE INSERT ON CALIFICACION
FOR EACH ROW
BEGIN
  IF COALESCE((SELECT h.id_estado
                 FROM HISTORIAL_ESTADO h
                WHERE h.id_pedido = NEW.id_pedido
                ORDER BY h.secuencia DESC LIMIT 1), 0) <> 4 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Solo se pueden calificar pedidos entregados.';
  END IF;
END$$

DELIMITER ;
