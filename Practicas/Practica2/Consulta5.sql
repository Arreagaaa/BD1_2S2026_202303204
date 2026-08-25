-- Practica 2 - Bases de Datos 1
-- Consulta 5: Auditoria de Bitacoras
-- Lista las colocaciones en estado "Activa" que no tienen ningun registro
-- de bitacora durante el ultimo mes (los 30 dias previos a la fecha en que
-- se ejecuta la consulta), evidenciando el nombre del catedratico
-- supervisor responsable para su respectivo llamado de atencion.

SELECT c.id_colocacion,
       est.nombre_completo AS estudiante,
       cat.nombre AS catedratico_responsable
FROM   colocacion c
       JOIN estado_colocacion ecol
         ON ecol.id_estado = c.id_estado
       JOIN estudiante est
         ON est.id_estudiante = c.estudiante_id_estudiante
       JOIN catedratico cat
         ON cat.id_catedratico = c.catedratico_id_catedratico
WHERE  ecol.nombre = 'Activa'
       AND NOT EXISTS (
              SELECT 1
              FROM   bitacora b
              WHERE  b.colocacion_id_colocacion = c.id_colocacion
                     AND b.fecha >= ADD_MONTHS(SYSDATE, -1)
           )
ORDER  BY cat.nombre;
