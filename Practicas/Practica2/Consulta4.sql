-- Practica 2 - Bases de Datos 1
-- Consulta 4: Estudiantes en Repitencia
-- Lista a los estudiantes que realizan su practica en calidad de repitencia
-- (es_repitencia = 1), junto con el instituto del que provienen, el
-- contacto empresarial que valida sus bitacoras y el estado actual de su
-- colocacion. Se usa LEFT JOIN hacia bitacora y contacto_empresarial porque
-- un estudiante en repitencia puede no tener todavia ninguna bitacora
-- registrada (en ese caso, nombre_contacto_validador sale en NULL). Se usa
-- DISTINCT porque un mismo contacto puede validar varias entradas de
-- bitacora de la misma colocacion.

SELECT DISTINCT
       est.nombre_completo,
       i.nombre AS nombre_instituto,
       ce.nombre AS nombre_contacto_validador,
       ecol.nombre AS estado_colocacion
FROM   estudiante est
       JOIN instituto i
         ON i.id_instituto = est.instituto_id_instituto
       JOIN colocacion c
         ON c.estudiante_id_estudiante = est.id_estudiante
       JOIN estado_colocacion ecol
         ON ecol.id_estado = c.id_estado
       LEFT JOIN bitacora b
         ON b.colocacion_id_colocacion = c.id_colocacion
       LEFT JOIN contacto_empresarial ce
         ON ce.id_contacto = b.id_contacto
WHERE  est.es_repitencia = 1
ORDER  BY est.nombre_completo;