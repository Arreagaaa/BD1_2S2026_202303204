-- Script para limpiar el esquema antes de correr DDL.sql (Practica 2)
-- Borra las tablas heredadas de la Practica 1 (y cualquier intento previo)
-- CASCADE CONSTRAINTS evita que se quejen las FKs por el orden de borrado.
-- PURGE evita que se queden en la papelera de reciclaje de Oracle.

DROP TABLE evaluacion_criterio CASCADE CONSTRAINTS PURGE;
DROP TABLE bitacora CASCADE CONSTRAINTS PURGE;
DROP TABLE evaluacion CASCADE CONSTRAINTS PURGE;
DROP TABLE colocacion CASCADE CONSTRAINTS PURGE;
DROP TABLE plaza CASCADE CONSTRAINTS PURGE;
DROP TABLE contacto_empresarial CASCADE CONSTRAINTS PURGE;
DROP TABLE catedratico CASCADE CONSTRAINTS PURGE;
DROP TABLE estudiante CASCADE CONSTRAINTS PURGE;
DROP TABLE municipio CASCADE CONSTRAINTS PURGE;
DROP TABLE empresa CASCADE CONSTRAINTS PURGE;
DROP TABLE criterio_evaluacion CASCADE CONSTRAINTS PURGE;
DROP TABLE instituto CASCADE CONSTRAINTS PURGE;
DROP TABLE departamento CASCADE CONSTRAINTS PURGE;
DROP TABLE estado_colocacion CASCADE CONSTRAINTS PURGE;
DROP TABLE sector_economico CASCADE CONSTRAINTS PURGE;
DROP TABLE tipo_evaluacion CASCADE CONSTRAINTS PURGE;