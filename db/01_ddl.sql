-- =====================================================================
-- 01_ddl.sql · Caso 7 Servicio de domicilios
-- Crea la base de datos desde cero con las 12 tablas del modelo relacional
-- del avance (sección 4). Requiere MySQL 8.0.16+ (desde ahí se aplican los CHECK).
--
-- ATENCIÓN: borra la base "domicilios" si ya existe. Es intencional:
-- el enunciado exige que el script corra de principio a fin sobre una BD vacía.
-- =====================================================================

DROP DATABASE IF EXISTS domicilios;
CREATE DATABASE domicilios
  CHARACTER SET utf8mb4          -- utf8mb4 soporta tildes, ñ y emojis en comentarios
  COLLATE utf8mb4_0900_ai_ci;    -- comparación sin distinguir mayúsculas ni tildes
USE domicilios;

-- ---------------------------------------------------------------------
-- CLIENTE · persona que hace pedidos
-- nombre (compuesto) se guarda por partes; edad (derivado) NO se guarda:
-- se calcula con fn_edad(fecha_nacimiento).
-- ---------------------------------------------------------------------
CREATE TABLE CLIENTE (
  id_cliente        INT          NOT NULL AUTO_INCREMENT,
  nombres           VARCHAR(60)  NOT NULL,
  primer_apellido   VARCHAR(40)  NOT NULL,
  segundo_apellido  VARCHAR(40)  NULL,
  email             VARCHAR(100) NOT NULL,
  fecha_nacimiento  DATE         NOT NULL,
  fecha_registro    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,   -- DEFAULT exigido
  CONSTRAINT pk_cliente       PRIMARY KEY (id_cliente),
  CONSTRAINT uq_cliente_email UNIQUE (email)
);

-- ---------------------------------------------------------------------
-- TELEFONO_CLIENTE · tabla del atributo MULTIVALUADO telefono
-- PK compuesta: un cliente no repite el mismo número.
-- ---------------------------------------------------------------------
CREATE TABLE TELEFONO_CLIENTE (
  id_cliente  INT         NOT NULL,
  telefono    VARCHAR(15) NOT NULL,
  CONSTRAINT pk_telefono_cliente PRIMARY KEY (id_cliente, telefono),
  CONSTRAINT fk_telefono_cliente FOREIGN KEY (id_cliente)
    REFERENCES CLIENTE (id_cliente) ON DELETE CASCADE   -- el teléfono no existe sin su cliente
);

-- ---------------------------------------------------------------------
-- RESTAURANTE · negocio afiliado
-- ---------------------------------------------------------------------
CREATE TABLE RESTAURANTE (
  id_restaurante    INT          NOT NULL AUTO_INCREMENT,
  nit               VARCHAR(15)  NOT NULL,
  nombre            VARCHAR(80)  NOT NULL,
  direccion         VARCHAR(120) NOT NULL,
  telefono          VARCHAR(15)  NOT NULL,
  fecha_afiliacion  DATE         NOT NULL,
  CONSTRAINT pk_restaurante     PRIMARY KEY (id_restaurante),
  CONSTRAINT uq_restaurante_nit UNIQUE (nit)
);

-- ---------------------------------------------------------------------
-- CATEGORIA · tipo de producto, común a todos los restaurantes
-- ---------------------------------------------------------------------
CREATE TABLE CATEGORIA (
  id_categoria  INT         NOT NULL AUTO_INCREMENT,
  nombre        VARCHAR(40) NOT NULL,
  CONSTRAINT pk_categoria        PRIMARY KEY (id_categoria),
  CONSTRAINT uq_categoria_nombre UNIQUE (nombre)
);

-- ---------------------------------------------------------------------
-- PRODUCTO · artículo del menú. Un combo también es un producto.
-- es_combo (derivado) NO se guarda: sale de COMBO_COMPONENTE.
-- ---------------------------------------------------------------------
CREATE TABLE PRODUCTO (
  id_producto     INT          NOT NULL AUTO_INCREMENT,
  id_restaurante  INT          NOT NULL,
  id_categoria    INT          NOT NULL,
  nombre          VARCHAR(80)  NOT NULL,
  descripcion     VARCHAR(200) NULL,
  precio          INT          NOT NULL,                 -- COP sin decimales (supuesto 6)
  disponible      BOOLEAN      NOT NULL DEFAULT TRUE,
  CONSTRAINT pk_producto PRIMARY KEY (id_producto),
  -- UNIQUE compuesta exigida: un restaurante no repite el nombre de un producto
  CONSTRAINT uq_producto_restaurante_nombre UNIQUE (id_restaurante, nombre),
  CONSTRAINT ck_producto_precio CHECK (precio > 0),
  CONSTRAINT fk_producto_restaurante FOREIGN KEY (id_restaurante)
    REFERENCES RESTAURANTE (id_restaurante) ON DELETE RESTRICT,
  CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria)
    REFERENCES CATEGORIA (id_categoria) ON DELETE RESTRICT
);

-- ---------------------------------------------------------------------
-- COMBO_COMPONENTE · tabla puente de la relación RECURSIVA "compone"
-- Sus dos FK apuntan a PRODUCTO (roles: combo y componente).
-- Las FK van SIN ON DELETE: MySQL no permite acciones referenciales sobre
-- columnas usadas en un CHECK (ver nota del avance, sección 4).
-- ---------------------------------------------------------------------
CREATE TABLE COMBO_COMPONENTE (
  id_combo       INT NOT NULL,
  id_componente  INT NOT NULL,
  cantidad       INT NOT NULL,
  CONSTRAINT pk_combo_componente PRIMARY KEY (id_combo, id_componente),
  CONSTRAINT ck_combo_no_si_mismo CHECK (id_combo <> id_componente),
  CONSTRAINT ck_combo_cantidad    CHECK (cantidad > 0),
  CONSTRAINT fk_combo_combo      FOREIGN KEY (id_combo)      REFERENCES PRODUCTO (id_producto),
  CONSTRAINT fk_combo_componente FOREIGN KEY (id_componente) REFERENCES PRODUCTO (id_producto)
);

-- ---------------------------------------------------------------------
-- REPARTIDOR · persona que entrega pedidos, con un único vehículo propio
-- ---------------------------------------------------------------------
CREATE TABLE REPARTIDOR (
  id_repartidor     INT         NOT NULL AUTO_INCREMENT,
  documento         VARCHAR(15) NOT NULL,
  nombres           VARCHAR(60) NOT NULL,
  primer_apellido   VARCHAR(40) NOT NULL,
  segundo_apellido  VARCHAR(40) NULL,
  telefono          VARCHAR(15) NOT NULL,
  tipo_vehiculo     VARCHAR(10) NOT NULL,
  placa             VARCHAR(10) NULL,
  fecha_ingreso     DATE        NOT NULL,
  CONSTRAINT pk_repartidor           PRIMARY KEY (id_repartidor),
  CONSTRAINT uq_repartidor_documento UNIQUE (documento),
  CONSTRAINT uq_repartidor_placa     UNIQUE (placa),          -- varios NULL sí se permiten (bicicletas)
  CONSTRAINT ck_repartidor_vehiculo  CHECK (tipo_vehiculo IN ('moto', 'bicicleta', 'carro')),
  -- La bicicleta no tiene placa; la moto y el carro sí (supuesto 9)
  CONSTRAINT ck_repartidor_placa CHECK (
       (tipo_vehiculo =  'bicicleta' AND placa IS NULL)
    OR (tipo_vehiculo <> 'bicicleta' AND placa IS NOT NULL)
  )
);

-- ---------------------------------------------------------------------
-- PEDIDO · compra de un cliente a un restaurante
-- direccion_entrega (compuesto) por partes. total, fecha_creacion,
-- estado_actual y tiempo_entrega son DERIVADOS: no se guardan.
-- ---------------------------------------------------------------------
CREATE TABLE PEDIDO (
  id_pedido       INT         NOT NULL AUTO_INCREMENT,
  id_cliente      INT         NOT NULL,
  id_restaurante  INT         NOT NULL,
  id_repartidor   INT         NULL,                       -- NULL hasta que se asigna (supuesto 1)
  calle           VARCHAR(60) NOT NULL,
  numero          VARCHAR(20) NOT NULL,                   -- texto: en Colombia es "# 5-23"
  barrio          VARCHAR(60) NOT NULL,
  ciudad          VARCHAR(60) NOT NULL,
  costo_envio     INT         NOT NULL DEFAULT 0,
  metodo_pago     VARCHAR(15) NOT NULL,
  CONSTRAINT pk_pedido PRIMARY KEY (id_pedido),
  CONSTRAINT ck_pedido_costo_envio CHECK (costo_envio >= 0),
  CONSTRAINT ck_pedido_metodo_pago CHECK (metodo_pago IN ('efectivo', 'tarjeta', 'transferencia')),
  -- RESTRICT: los pedidos son historia, no se pierden al borrar el cliente/restaurante/repartidor
  CONSTRAINT fk_pedido_cliente     FOREIGN KEY (id_cliente)     REFERENCES CLIENTE (id_cliente)         ON DELETE RESTRICT,
  CONSTRAINT fk_pedido_restaurante FOREIGN KEY (id_restaurante) REFERENCES RESTAURANTE (id_restaurante) ON DELETE RESTRICT,
  CONSTRAINT fk_pedido_repartidor  FOREIGN KEY (id_repartidor)  REFERENCES REPARTIDOR (id_repartidor)   ON DELETE RESTRICT
);

-- ---------------------------------------------------------------------
-- DETALLE_PEDIDO · ENTIDAD ASOCIATIVA (resuelve la N:M PEDIDO–PRODUCTO)
-- precio_unitario guarda el precio cobrado (el del producto puede cambiar).
-- ---------------------------------------------------------------------
CREATE TABLE DETALLE_PEDIDO (
  id_pedido        INT NOT NULL,
  id_producto      INT NOT NULL,
  cantidad         INT NOT NULL,
  precio_unitario  INT NOT NULL,
  CONSTRAINT pk_detalle_pedido PRIMARY KEY (id_pedido, id_producto),
  CONSTRAINT ck_detalle_cantidad CHECK (cantidad > 0),
  CONSTRAINT ck_detalle_precio   CHECK (precio_unitario > 0),
  CONSTRAINT fk_detalle_pedido   FOREIGN KEY (id_pedido)   REFERENCES PEDIDO (id_pedido)     ON DELETE CASCADE,
  CONSTRAINT fk_detalle_producto FOREIGN KEY (id_producto) REFERENCES PRODUCTO (id_producto) ON DELETE RESTRICT
);

-- ---------------------------------------------------------------------
-- ESTADO · catálogo fijo (sin AUTO_INCREMENT)
-- orden = posición en el flujo; 0 = cancelado (fuera del flujo normal)
-- ---------------------------------------------------------------------
CREATE TABLE ESTADO (
  id_estado  INT         NOT NULL,
  nombre     VARCHAR(20) NOT NULL,
  orden      TINYINT     NOT NULL,
  CONSTRAINT pk_estado        PRIMARY KEY (id_estado),
  CONSTRAINT uq_estado_nombre UNIQUE (nombre),
  CONSTRAINT uq_estado_orden  UNIQUE (orden),
  CONSTRAINT ck_estado_orden  CHECK (orden BETWEEN 0 AND 4)
);

-- ---------------------------------------------------------------------
-- HISTORIAL_ESTADO · ENTIDAD DÉBIL (dueña: PEDIDO)
-- PK = id_pedido (de la dueña) + secuencia (discriminador).
-- La secuencia la asigna el trigger trg_historial_bi (02_triggers.sql).
-- ---------------------------------------------------------------------
CREATE TABLE HISTORIAL_ESTADO (
  id_pedido    INT          NOT NULL,
  secuencia    INT          NOT NULL,
  id_estado    INT          NOT NULL,
  fecha_hora   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  observacion  VARCHAR(150) NULL,
  CONSTRAINT pk_historial_estado PRIMARY KEY (id_pedido, secuencia),
  -- UNIQUE compuesta: cada estado aparece máximo una vez por pedido (supuesto 3)
  CONSTRAINT uq_historial_pedido_estado UNIQUE (id_pedido, id_estado),
  CONSTRAINT fk_historial_pedido FOREIGN KEY (id_pedido) REFERENCES PEDIDO (id_pedido) ON DELETE CASCADE,
  CONSTRAINT fk_historial_estado FOREIGN KEY (id_estado) REFERENCES ESTADO (id_estado) ON DELETE RESTRICT
);

-- ---------------------------------------------------------------------
-- CALIFICACION · ENTIDAD DÉBIL 1:1 (dueña: PEDIDO)
-- PK = id_pedido: garantiza una sola calificación por pedido.
-- ---------------------------------------------------------------------
CREATE TABLE CALIFICACION (
  id_pedido         INT          NOT NULL,
  nota_restaurante  TINYINT      NOT NULL,
  nota_repartidor   TINYINT      NOT NULL,
  comentario        VARCHAR(300) NULL,
  fecha             DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_calificacion PRIMARY KEY (id_pedido),
  CONSTRAINT ck_calificacion_nota_rest CHECK (nota_restaurante BETWEEN 1 AND 5),
  CONSTRAINT ck_calificacion_nota_rep  CHECK (nota_repartidor  BETWEEN 1 AND 5),
  CONSTRAINT fk_calificacion_pedido FOREIGN KEY (id_pedido) REFERENCES PEDIDO (id_pedido) ON DELETE CASCADE
);

-- ---------------------------------------------------------------------
-- Datos del catálogo ESTADO (valores fijos del avance)
-- ---------------------------------------------------------------------
INSERT INTO ESTADO (id_estado, nombre, orden) VALUES
  (1, 'recibido',       1),
  (2, 'en preparación', 2),
  (3, 'en camino',      3),
  (4, 'entregado',      4),
  (5, 'cancelado',      0);
