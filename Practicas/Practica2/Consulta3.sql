-- Practica 2 - Bases de Datos 1
-- Consulta 3: Carga de Validacion por Contacto Empresarial
-- Para el rango de fechas de julio a agosto de 2026, muestra el nombre del
-- contacto empresarial, el nombre de la empresa a la que pertenece y la
-- suma total de horas que dicho contacto ha validado en las bitacoras de
-- los estudiantes.

SELECT ce.nombre AS nombre_contacto,
       emp.nombre AS nombre_empresa,
       SUM(b.horas_trabajadas) AS total_horas_validadas
FROM   bitacora b
       JOIN contacto_empresarial ce
         ON ce.id_contacto = b.id_contacto
       JOIN empresa emp
         ON emp.id_empresa = ce.empresa_id_empresa
WHERE  b.fecha BETWEEN DATE '2026-07-01' AND DATE '2026-08-31'
GROUP  BY ce.nombre, emp.nombre
ORDER  BY total_horas_validadas DESC;
