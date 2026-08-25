-- Practica 2 - Bases de Datos 1
-- Consulta 2: Oferta de Plazas por Empresa
-- Muestra el nombre de cada empresa afiliada junto con la cantidad total de
-- plazas de practica que ofrece. Se usa LEFT JOIN para que tambien aparezcan
-- las empresas que, eventualmente, no tuvieran ninguna plaza registrada.
-- El resultado se ordena mostrando primero las empresas con mas plazas.

SELECT emp.nombre AS nombre_empresa,
       COUNT(p.id_plaza) AS cantidad_plazas
FROM   empresa emp
       LEFT JOIN plaza p
         ON p.empresa_id_empresa = emp.id_empresa
GROUP  BY emp.nombre
ORDER  BY cantidad_plazas DESC;

