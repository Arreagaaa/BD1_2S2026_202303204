-- Practica 2 - Bases de Datos 1
-- Consulta 1: Directorio de Estudiantes Activos
-- Muestra el carne, el nombre completo del estudiante, la empresa donde se
-- encuentra colocado y la especialidad de la plaza que ocupa, unicamente
-- para colocaciones cuyo estado sea "Activa".

SELECT e.carne,
       e.nombre_completo,
       emp.nombre AS nombre_empresa,
       p.especialidad_tecnica
FROM   estudiante e
       JOIN colocacion c
         ON c.estudiante_id_estudiante = e.id_estudiante
       JOIN estado_colocacion ec
         ON ec.id_estado = c.id_estado
       JOIN plaza p
         ON p.id_plaza = c.plaza_id_plaza
       JOIN empresa emp
         ON emp.id_empresa = p.empresa_id_empresa
WHERE  ec.nombre = 'Activa'
ORDER  BY e.nombre_completo;
