-- =====================================================================
-- 05_sp_reportes.sql · Procedimientos de la pantalla Reportes (P4)
--
-- Regla del proyecto (enunciado 4.2): la aplicación solo ejecuta CALL sp_...
-- Por eso cada reporte es un procedimiento que LEE una vista de 06_vistas.sql
-- (va después de las vistas en 00_run_all.sql). Los procedimientos no
-- recalculan nada: filtran, ordenan, numeran el ranking y limitan filas.
--
-- SQLSTATE '45000' = parámetro fuera de rango (regla de negocio del reporte).
-- =====================================================================
USE domicilios;

DROP PROCEDURE IF EXISTS sp_reporte_resumen;
DROP PROCEDURE IF EXISTS sp_reporte_restaurantes;
DROP PROCEDURE IF EXISTS sp_reporte_repartidores;
DROP PROCEDURE IF EXISTS sp_reporte_tiempos_entrega;
DROP PROCEDURE IF EXISTS sp_reporte_ventas_mensuales;

DELIMITER $$

-- ---------------------------------------------------------------------
-- sp_reporte_resumen · indicadores generales para el encabezado de Reportes.
-- ¿Cuánto se ha vendido, cuántos pedidos se cancelan y qué tan rápido y bien
-- se entrega? Una sola fila.
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_reporte_resumen()
BEGIN
  SELECT COUNT(*)                                                                    AS pedidos,
         CAST(SUM(v.id_estado_actual = 4) AS SIGNED)                                 AS entregados,
         CAST(SUM(v.id_estado_actual = 5) AS SIGNED)                                 AS cancelados,
         CAST(SUM(v.id_estado_actual IN (1, 2, 3)) AS SIGNED)                        AS en_curso,
         CAST(COALESCE(SUM(CASE WHEN v.id_estado_actual = 4 THEN v.subtotal END), 0) AS SIGNED) AS ventas,
         CAST(ROUND(AVG(CASE WHEN v.id_estado_actual = 4 THEN v.subtotal END)) AS SIGNED)       AS ticket_promedio,
         CAST(ROUND(AVG(v.tiempo_entrega_min)) AS SIGNED)                            AS tiempo_promedio_min,
         ROUND(AVG(v.nota_restaurante), 2)                                           AS nota_restaurantes,
         ROUND(AVG(v.nota_repartidor), 2)                                            AS nota_repartidores,
         ROUND(100 * SUM(v.id_estado_actual = 5) / NULLIF(COUNT(*), 0), 1)           AS porcentaje_cancelados
    FROM vw_pedido_resumen v;
END$$

-- ---------------------------------------------------------------------
-- sp_reporte_restaurantes · ¿Qué restaurantes venden más?
-- RANK() es una función de ventana: numera el puesto sin agrupar filas;
-- dos restaurantes con las mismas ventas comparten puesto.
-- p_limite: cuántos mostrar (1 a 100).
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_reporte_restaurantes(IN p_limite INT)
BEGIN
  IF p_limite IS NULL OR p_limite < 1 OR p_limite > 100 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El número de restaurantes a mostrar debe estar entre 1 y 100.';
  END IF;

  SELECT RANK() OVER (ORDER BY vr.ventas DESC) AS puesto,
         vr.id_restaurante, vr.nombre, vr.nit,
         vr.pedidos_totales, vr.pedidos_entregados, vr.pedidos_cancelados,
         vr.ventas, vr.ticket_promedio,
         vr.calificacion_promedio, vr.num_calificaciones, vr.tiempo_promedio_min
    FROM vw_ventas_restaurante vr
   ORDER BY vr.ventas DESC, vr.nombre
   LIMIT p_limite;
END$$

-- ---------------------------------------------------------------------
-- sp_reporte_repartidores · ¿Qué repartidores están mejor calificados?
-- p_min_calificaciones evita que alguien con UNA sola nota de 5 quede de
-- primero: solo entran quienes tienen al menos ese número de notas.
-- Empates en la nota: gana quien tiene más calificaciones (más evidencia).
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_reporte_repartidores(IN p_min_calificaciones INT, IN p_limite INT)
BEGIN
  IF p_min_calificaciones IS NULL OR p_min_calificaciones < 1 OR p_min_calificaciones > 50 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El mínimo de calificaciones debe estar entre 1 y 50.';
  END IF;
  IF p_limite IS NULL OR p_limite < 1 OR p_limite > 100 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El número de repartidores a mostrar debe estar entre 1 y 100.';
  END IF;

  SELECT RANK() OVER (ORDER BY d.calificacion_promedio DESC, d.num_calificaciones DESC) AS puesto,
         d.id_repartidor, d.nombres, d.primer_apellido, d.tipo_vehiculo, d.placa,
         d.pedidos_asignados, d.entregas,
         d.calificacion_promedio, d.num_calificaciones, d.tiempo_promedio_min
    FROM vw_desempeno_repartidor d
   WHERE d.num_calificaciones >= p_min_calificaciones
   ORDER BY d.calificacion_promedio DESC, d.num_calificaciones DESC, d.primer_apellido
   LIMIT p_limite;
END$$

-- ---------------------------------------------------------------------
-- sp_reporte_tiempos_entrega · ¿En qué zonas tardamos más en entregar?
-- p_ciudad NULL o '' = todas. Ordenado de la zona más lenta a la más rápida.
-- Devuelve 2 conjuntos: (1) zonas, (2) ciudades disponibles para el filtro.
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_reporte_tiempos_entrega(IN p_ciudad VARCHAR(60))
BEGIN
  SELECT z.ciudad, z.barrio, z.entregas,
         z.tiempo_promedio_min, z.tiempo_minimo_min, z.tiempo_maximo_min
    FROM vw_tiempo_entrega_zona z
   WHERE p_ciudad IS NULL OR p_ciudad = '' OR z.ciudad = p_ciudad
   ORDER BY z.tiempo_promedio_min DESC, z.entregas DESC, z.ciudad, z.barrio;

  SELECT DISTINCT z.ciudad
    FROM vw_tiempo_entrega_zona z
   ORDER BY z.ciudad;
END$$

-- ---------------------------------------------------------------------
-- sp_reporte_ventas_mensuales · ¿Cómo evolucionan las ventas mes a mes?
-- ---------------------------------------------------------------------
CREATE PROCEDURE sp_reporte_ventas_mensuales()
BEGIN
  SELECT m.mes, m.pedidos, m.entregados, m.cancelados,
         m.ventas, m.ingresos_envio, m.ticket_promedio
    FROM vw_ventas_mensuales m
   ORDER BY m.mes;
END$$

DELIMITER ;
