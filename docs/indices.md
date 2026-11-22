# Índices y medición de consultas

Mediciones con `EXPLAIN ANALYZE` en MySQL local, con la carga de rendimiento aplicada
(`npm run db:perf`): **5.250 pedidos** y **20.910 estados** en el historial. Cada consulta se
ejecutó una vez antes de medir para que los datos estuvieran en memoria.

## PEDIDO (ciudad, barrio)

**Pregunta de negocio:** ¿Cuántos pedidos y cuánto costo de envío hay en Barzal, Villavicencio?

```sql
SELECT COUNT(*), SUM(costo_envio)
FROM PEDIDO
WHERE ciudad = 'Villavicencio' AND barrio = 'Barzal';
```

El índice compuesto empieza por `ciudad`, una condición de igualdad, y luego usa `barrio` para restringir la zona dentro de esa ciudad. No se agrega otro índice para `PEDIDO(id_restaurante)`: la clave foránea `fk_pedido_restaurante` ya hace que InnoDB cree el índice necesario.

| Medición | Filas examinadas | Tipo de acceso | Tiempo |
|---|---|---|---|
| Sin índice | 5.250 | Table scan (recorre toda la tabla) | 2,10 ms |
| Con índice | 467 | Index lookup en `idx_pedido_ciudad_barrio` | 0,83 ms |

## HISTORIAL_ESTADO (id_estado, fecha_hora)

**Pregunta de negocio:** ¿Cuántos pedidos se entregaron durante septiembre de 2026?

```sql
SELECT COUNT(DISTINCT id_pedido)
FROM HISTORIAL_ESTADO
WHERE id_estado = 4
  AND fecha_hora BETWEEN '2026-09-01' AND '2026-09-30 23:59:59';
```

El índice empieza por `id_estado` para resolver la igualdad y continúa con `fecha_hora` para acotar el rango temporal. La medición sin el índice compuesto incluye también una ejecución que ignora `fk_historial_estado`, el índice automático de la FK sobre el estado.

| Medición | Filas examinadas | Tipo de acceso | Tiempo |
|---|---|---|---|
| Sin índice compuesto, plan normal | 5.200 | Index lookup en `fk_historial_estado` (id_estado = 4) + filtro de fecha | 6,65 ms |
| Sin índice útil (`IGNORE INDEX`) | 20.910 | Table scan + filtro de estado y fecha | 4,77 ms |
| Con índice | 275 | Covering index range scan en `idx_historial_estado_fecha` | 0,16 ms |

**Nota (Error 1553).** Al crear `idx_historial_estado_fecha`, InnoDB elimina el índice automático
`fk_historial_estado`, porque el compuesto (que empieza por `id_estado`) ya le sirve a la llave
foránea. Por eso, para medir "sin índice", `medir_indices.sql` primero recrea un índice simple en
`id_estado`; si no, MySQL no deja borrar el compuesto (*Cannot drop index … needed in a foreign key constraint*).

## Conclusiones

- **Q1:** con el índice MySQL va directo a los 467 pedidos de Barzal en vez de recorrer los 5.250
  (11 veces menos filas examinadas, 2,5 veces menos tiempo).
- **Q2:** el índice de la FK es *más lento* que recorrer la tabla (6,65 ms contra 4,77 ms): encuentra los
  5.200 entregados, pero tiene que ir a la tabla fila por fila a revisar la fecha. El índice compuesto
  resuelve estado y rango de fechas en una sola lectura ordenada y sin tocar la tabla ("covering"):
  examina solo las 275 filas del resultado y es unas 40 veces más rápido que con la FK.
- Un índice de una sola columna no siempre ayuda: el orden y la combinación de columnas debe seguir
  la consulta de negocio (igualdad primero, rango después).
- Los tiempos cambian entre equipos; lo que se mantiene es el tipo de acceso y las filas examinadas.

## Cómo reproducir

1. `npm run db:setup`
2. `npm run db:perf`
3. Ejecutar `db/perf/medir_indices.sql` en MySQL Workbench.
4. Comparar el tipo de acceso y las filas examinadas de cada `EXPLAIN ANALYZE` con las tablas de arriba.
