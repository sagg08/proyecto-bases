-- =====================================================================
-- 08_transacciones.sql · Demostración manual de COMMIT y ROLLBACK (P3)
--
-- Este script NO se agrega a 00_run_all.sql: es para correrlo a mano
-- (Workbench o el cliente mysql) en la sustentación, mostrando que
-- sp_pedido_crear es "todo o nada" (avance, sección 4.2).
--
-- Requiere la base "domicilios" ya creada con datos (npm run db:setup).
-- La demostración 2 lanza un error A PROPÓSITO: si se corre con
-- "mysql ... < db/08_transacciones.sql" el cliente se detiene ahí (es lo
-- esperado); para ver el conteo final basta correr la última consulta
-- aparte, o ejecutar el archivo statement por statement en Workbench.
-- =====================================================================
USE domicilios;

-- ---------------------------------------------------------------------
-- Demostración 1 · COMMIT
-- sp_pedido_crear inserta PEDIDO + DETALLE_PEDIDO + HISTORIAL_ESTADO
-- "recibido" dentro de START TRANSACTION ... COMMIT. Con datos válidos,
-- las tres tablas quedan escritas.
-- ---------------------------------------------------------------------
SELECT COUNT(*) AS pedidos_antes FROM PEDIDO;

-- Un cliente, un restaurante y uno de sus productos cualquiera, solo para la demo
SELECT id_cliente     INTO @cliente     FROM CLIENTE     ORDER BY id_cliente     LIMIT 1;
SELECT id_restaurante INTO @restaurante FROM RESTAURANTE ORDER BY id_restaurante LIMIT 1;
SELECT id_producto    INTO @producto1   FROM PRODUCTO WHERE id_restaurante = @restaurante ORDER BY id_producto LIMIT 1;

CALL sp_pedido_crear(
  @cliente, @restaurante,
  'Calle 10', '# 5-23', 'Centro', 'Villavicencio',
  4000, 'efectivo',
  JSON_ARRAY(JSON_OBJECT('id_producto', @producto1, 'cantidad', 2))
);

SELECT COUNT(*) AS pedidos_despues FROM PEDIDO;   -- uno más: el COMMIT quedó

-- ---------------------------------------------------------------------
-- Demostración 2 · ROLLBACK
-- Se pide un producto de OTRO restaurante: trg_detalle_bi rechaza el
-- INSERT en DETALLE_PEDIDO, pero el PEDIDO ya se había insertado antes
-- en la misma transacción. El EXIT HANDLER de sp_pedido_crear hace
-- ROLLBACK y RESIGNAL: no debe quedar ningún rastro del pedido fallido.
-- ---------------------------------------------------------------------
SELECT COUNT(*) AS pedidos_antes_rollback FROM PEDIDO;

SELECT id_restaurante INTO @restaurante2
  FROM RESTAURANTE WHERE id_restaurante <> @restaurante ORDER BY id_restaurante LIMIT 1;
SELECT id_producto INTO @producto_ajeno
  FROM PRODUCTO WHERE id_restaurante = @restaurante2 ORDER BY id_producto LIMIT 1;

-- Debe fallar con: "El producto no pertenece al restaurante del pedido."
CALL sp_pedido_crear(
  @cliente, @restaurante,
  'Calle 10', '# 5-23', 'Centro', 'Villavicencio',
  4000, 'efectivo',
  JSON_ARRAY(JSON_OBJECT('id_producto', @producto_ajeno, 'cantidad', 1))
);

-- Igual al de "antes": el ROLLBACK funcionó, el pedido fallido no quedó a medias.
SELECT COUNT(*) AS pedidos_despues_rollback FROM PEDIDO;
