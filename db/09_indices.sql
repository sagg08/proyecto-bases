USE domicilios;

-- Acelera pedidos por ciudad y barrio (por ejemplo, el volumen y costo de envíos por zona).
-- ciudad va primero para limitar la ciudad; barrio refina la búsqueda dentro de ella.
-- No se crea PEDIDO(id_restaurante): la FK fk_pedido_restaurante ya genera ese índice.
CREATE INDEX idx_pedido_ciudad_barrio
  ON PEDIDO (ciudad, barrio);

-- Acelera la búsqueda de pedidos entregados durante un periodo.
-- id_estado va primero para igualdad y fecha_hora después para el rango temporal.
-- El índice automático de la FK (fk_historial_estado) solo cubre id_estado: encuentra los
-- entregados, pero luego revisa fecha_hora fila por fila. Además, al crear este índice
-- compuesto InnoDB elimina ese índice automático, porque este ya le sirve a la FK.
CREATE INDEX idx_historial_estado_fecha
  ON HISTORIAL_ESTADO (id_estado, fecha_hora);
