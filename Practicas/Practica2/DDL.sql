-- Generado por Oracle SQL Developer Data Modeler 24.3.1.347.1153
--   en:        2026-08-13 15:33:11 CST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g
--
-- NOTA DE PRACTICA 2: este script parte del DDL.sql entregado en la Practica 1.
-- Se conservan todos los comentarios generados originalmente por la herramienta.
-- Debajo de cada comentario "-- ERROR" original se agrega un comentario
-- "-- CORREGIDO" que explica el ajuste aplicado para dejar el script ejecutable
-- en Oracle 11g (limite de 30 caracteres por identificador) y para que el
-- modelo pueda alojar el set de datos proporcionado (catalogos normalizados
-- de sector economico, departamento, municipio, estado de colocacion y tipo
-- de evaluacion, que la Practica 1 habia dejado como atributos VARCHAR2).


-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE bitacora (
    id_bitacora                      NUMBER(6) NOT NULL,
    correlativo_mensual              NUMBER(3),
    fecha                            DATE,
    horas_trabajadas                 NUMBER(4, 2),
    actividades_realizadas           VARCHAR2(500),
    observaciones                    VARCHAR2(500),
    colocacion_id_colocacion         NUMBER(6) NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
--  CORREGIDO: contacto_empresarial_id_contacto (33 caracteres) se renombra a id_contacto
    id_contacto                      NUMBER(6) NOT NULL
);

ALTER TABLE bitacora ADD CONSTRAINT bitacora_pk PRIMARY KEY ( id_bitacora );

CREATE TABLE catedratico (
    id_catedratico         NUMBER(6) NOT NULL,
    nombre                 VARCHAR2(150),
    identificacion         VARCHAR2(30),
    telefono               VARCHAR2(20),
    especialidad           VARCHAR2(100),
    instituto_id_instituto NUMBER(6) NOT NULL
);

ALTER TABLE catedratico ADD CONSTRAINT catedratico_pk PRIMARY KEY ( id_catedratico );

CREATE TABLE colocacion (
    id_colocacion              NUMBER(6) NOT NULL,
    fecha_inicio               DATE,
    fecha_fin                  DATE,
--  AJUSTE PRACTICA 2: la columna "estado" (VARCHAR2(15)) se normaliza como
--  llave foranea hacia el catalogo estado_colocacion, tal como lo requiere
--  el dataset entregado (hoja ESTADO_COLOCACION).
    id_estado                  NUMBER(2) NOT NULL,
    estudiante_id_estudiante   NUMBER(7) NOT NULL,
    plaza_id_plaza              NUMBER(6) NOT NULL,
    catedratico_id_catedratico NUMBER(6) NOT NULL
);

ALTER TABLE colocacion ADD CONSTRAINT colocacion_pk PRIMARY KEY ( id_colocacion );

CREATE TABLE contacto_empresarial (
    id_contacto        NUMBER(6) NOT NULL,
    nombre             VARCHAR2(150),
    telefono           VARCHAR2(20),
    correo             VARCHAR2(120),
    empresa_id_empresa NUMBER(6) NOT NULL
);

ALTER TABLE contacto_empresarial ADD CONSTRAINT contacto_empresarial_pk PRIMARY KEY ( id_contacto );

CREATE TABLE criterio_evaluacion (
    id_criterio     NUMBER(4) NOT NULL,
    nombre_criterio VARCHAR2(100),
    descripcion     VARCHAR2(300)
);

ALTER TABLE criterio_evaluacion ADD CONSTRAINT criterio_evaluacion_pk PRIMARY KEY ( id_criterio );

--  AJUSTE PRACTICA 2: tabla nueva. La Practica 1 no la modelaba porque el
--  departamento de residencia del estudiante se guardaba como VARCHAR2 libre.
--  El dataset entregado la exige como catalogo (hoja DEPARTAMENTO).
CREATE TABLE departamento (
    id_departamento NUMBER(2) NOT NULL,
    nombre          VARCHAR2(60)
);

ALTER TABLE departamento ADD CONSTRAINT departamento_pk PRIMARY KEY ( id_departamento );

CREATE TABLE empresa (
    id_empresa       NUMBER(6) NOT NULL,
    nombre           VARCHAR2(150),
    direccion        VARCHAR2(200),
--  AJUSTE PRACTICA 2: "sector_economico" (VARCHAR2(20)) se normaliza como
--  llave foranea hacia el catalogo sector_economico (hoja SECTOR_ECONOMICO).
    id_sector        NUMBER(2) NOT NULL
);

ALTER TABLE empresa ADD CONSTRAINT empresa_pk PRIMARY KEY ( id_empresa );

--  AJUSTE PRACTICA 2: tabla nueva (hoja ESTADO_COLOCACION del dataset).
CREATE TABLE estado_colocacion (
    id_estado NUMBER(2) NOT NULL,
    nombre    VARCHAR2(15)
);

ALTER TABLE estado_colocacion ADD CONSTRAINT estado_colocacion_pk PRIMARY KEY ( id_estado );

CREATE TABLE estudiante (
--  AJUSTE PRACTICA 2: se amplia de NUMBER(6) a NUMBER(7) porque el dataset
--  identifica a cada estudiante con su carne (por ejemplo 2024001), que ya
--  ocupa 7 digitos.
    id_estudiante           NUMBER(7) NOT NULL,
    nombre_completo         VARCHAR2(150),
    carne                   VARCHAR2(20),
    carrera_tecnica         VARCHAR2(100),
    direccion               VARCHAR2(200),
    telefono                VARCHAR2(20),
    fecha_nacimiento        DATE,
    genero                  VARCHAR2(20),
--  AJUSTE PRACTICA 2: "departamento_residencia" y "municipio_residencia"
--  (dos VARCHAR2 independientes) se reemplazan por una unica llave foranea
--  hacia municipio, que a su vez referencia a departamento. Ademas de
--  ajustarse al dataset entregado, elimina la dependencia transitiva que
--  tenia el modelo de la Practica 1 (el departamento se deducia del
--  municipio, por lo que guardarlo aparte violaba 3FN).
    id_municipio            NUMBER(3) NOT NULL,
--  AJUSTE PRACTICA 2: "es_repitencia" cambia de CHAR(1) ('S'/'N') a
--  NUMBER(1) (0/1), dominio que usan tanto el dataset (hoja ESTUDIANTE)
--  como el enunciado de la practica ("es_repitencia = 1").
    es_repitencia           NUMBER(1),
    instituto_id_instituto  NUMBER(6) NOT NULL
);

ALTER TABLE estudiante ADD CONSTRAINT estudiante_pk PRIMARY KEY ( id_estudiante );

CREATE TABLE evaluacion (
    id_evaluacion              NUMBER(8) NOT NULL,
--  AJUSTE PRACTICA 2: "tipo_evaluacion" (VARCHAR2(10)) se normaliza como
--  llave foranea hacia el catalogo tipo_evaluacion (hoja TIPO_EVALUACION).
    id_tipo_evaluacion         NUMBER(2) NOT NULL,
    fecha_evaluacion           DATE,
    colocacion_id_colocacion   NUMBER(6) NOT NULL,
    catedratico_id_catedratico NUMBER(6) NOT NULL
);

ALTER TABLE evaluacion ADD CONSTRAINT evaluacion_pk PRIMARY KEY ( id_evaluacion );

CREATE TABLE evaluacion_criterio (
    punteo                          NUMBER(1),
    evaluacion_id_evaluacion        NUMBER(8) NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
--  CORREGIDO: criterio_evaluacion_id_criterio (32 caracteres) se renombra a id_criterio
    id_criterio                     NUMBER(4) NOT NULL
);

ALTER TABLE evaluacion_criterio ADD CONSTRAINT evaluacion_criterio_pk PRIMARY KEY ( evaluacion_id_evaluacion,
                                                                                    id_criterio );

CREATE TABLE instituto (
    id_instituto        NUMBER(6) NOT NULL,
    nombre              VARCHAR2(150),
    direccion           VARCHAR2(200),
    codigo_autorizacion VARCHAR2(30)
);

ALTER TABLE instituto ADD CONSTRAINT instituto_pk PRIMARY KEY ( id_instituto );

--  AJUSTE PRACTICA 2: tabla nueva (hoja MUNICIPIO del dataset). Depende de
--  departamento.
CREATE TABLE municipio (
    id_municipio    NUMBER(3) NOT NULL,
    nombre          VARCHAR2(60),
    id_departamento NUMBER(2) NOT NULL
);

ALTER TABLE municipio ADD CONSTRAINT municipio_pk PRIMARY KEY ( id_municipio );

CREATE TABLE plaza (
    id_plaza                         NUMBER(6) NOT NULL,
    especialidad_tecnica             VARCHAR2(100),
    descripcion                      VARCHAR2(300),
    empresa_id_empresa               NUMBER(6) NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
--  CORREGIDO: contacto_empresarial_id_contacto (33 caracteres) se renombra a id_contacto
    id_contacto                      NUMBER(6) NOT NULL
);

ALTER TABLE plaza ADD CONSTRAINT plaza_pk PRIMARY KEY ( id_plaza );

--  AJUSTE PRACTICA 2: tabla nueva (hoja SECTOR_ECONOMICO del dataset).
CREATE TABLE sector_economico (
    id_sector NUMBER(2) NOT NULL,
    nombre    VARCHAR2(60)
);

ALTER TABLE sector_economico ADD CONSTRAINT sector_economico_pk PRIMARY KEY ( id_sector );

--  AJUSTE PRACTICA 2: tabla nueva (hoja TIPO_EVALUACION del dataset).
CREATE TABLE tipo_evaluacion (
    id_tipo_evaluacion NUMBER(2) NOT NULL,
    nombre             VARCHAR2(10)
);

ALTER TABLE tipo_evaluacion ADD CONSTRAINT tipo_evaluacion_pk PRIMARY KEY ( id_tipo_evaluacion );

ALTER TABLE bitacora
    ADD CONSTRAINT bitacora_colocacion_fk FOREIGN KEY ( colocacion_id_colocacion )
        REFERENCES colocacion ( id_colocacion );

--  ERROR: FK name length exceeds maximum allowed length(30) 
--  CORREGIDO: bitacora_contacto_empresarial_fk (32 caracteres) se renombra a bitacora_contacto_fk
ALTER TABLE bitacora
    ADD CONSTRAINT bitacora_contacto_fk FOREIGN KEY ( id_contacto )
        REFERENCES contacto_empresarial ( id_contacto );

ALTER TABLE catedratico
    ADD CONSTRAINT catedratico_instituto_fk FOREIGN KEY ( instituto_id_instituto )
        REFERENCES instituto ( id_instituto );

ALTER TABLE colocacion
    ADD CONSTRAINT colocacion_catedratico_fk FOREIGN KEY ( catedratico_id_catedratico )
        REFERENCES catedratico ( id_catedratico );

ALTER TABLE colocacion
    ADD CONSTRAINT colocacion_estudiante_fk FOREIGN KEY ( estudiante_id_estudiante )
        REFERENCES estudiante ( id_estudiante );

ALTER TABLE colocacion
    ADD CONSTRAINT colocacion_plaza_fk FOREIGN KEY ( plaza_id_plaza )
        REFERENCES plaza ( id_plaza );

--  AJUSTE PRACTICA 2: nueva llave foranea por la normalizacion de "estado".
ALTER TABLE colocacion
    ADD CONSTRAINT colocacion_estado_fk FOREIGN KEY ( id_estado )
        REFERENCES estado_colocacion ( id_estado );

--  ERROR: FK name length exceeds maximum allowed length(30) 
--  CORREGIDO: contacto_empresarial_empresa_fk (31 caracteres) se renombra a contacto_empresarial_fk
ALTER TABLE contacto_empresarial
    ADD CONSTRAINT contacto_empresarial_fk FOREIGN KEY ( empresa_id_empresa )
        REFERENCES empresa ( id_empresa );

--  AJUSTE PRACTICA 2: nueva llave foranea por la normalizacion de "sector_economico".
ALTER TABLE empresa
    ADD CONSTRAINT empresa_sector_fk FOREIGN KEY ( id_sector )
        REFERENCES sector_economico ( id_sector );

ALTER TABLE estudiante
    ADD CONSTRAINT estudiante_instituto_fk FOREIGN KEY ( instituto_id_instituto )
        REFERENCES instituto ( id_instituto );

--  AJUSTE PRACTICA 2: nueva llave foranea por la normalizacion de
--  departamento_residencia / municipio_residencia en un unico id_municipio.
ALTER TABLE estudiante
    ADD CONSTRAINT estudiante_municipio_fk FOREIGN KEY ( id_municipio )
        REFERENCES municipio ( id_municipio );

ALTER TABLE evaluacion
    ADD CONSTRAINT evaluacion_catedratico_fk FOREIGN KEY ( catedratico_id_catedratico )
        REFERENCES catedratico ( id_catedratico );

ALTER TABLE evaluacion
    ADD CONSTRAINT evaluacion_colocacion_fk FOREIGN KEY ( colocacion_id_colocacion )
        REFERENCES colocacion ( id_colocacion );

--  AJUSTE PRACTICA 2: nueva llave foranea por la normalizacion de "tipo_evaluacion".
ALTER TABLE evaluacion
    ADD CONSTRAINT evaluacion_tipo_fk FOREIGN KEY ( id_tipo_evaluacion )
        REFERENCES tipo_evaluacion ( id_tipo_evaluacion );

--  ERROR: FK name length exceeds maximum allowed length(30) 
--  CORREGIDO: evaluacion_criterio_criterio_evaluacion_fk (43 caracteres) se renombra a evalcrit_criterio_fk
ALTER TABLE evaluacion_criterio
    ADD CONSTRAINT evalcrit_criterio_fk FOREIGN KEY ( id_criterio )
        REFERENCES criterio_evaluacion ( id_criterio );

--  ERROR: FK name length exceeds maximum allowed length(30) 
--  CORREGIDO: evaluacion_criterio_evaluacion_fk (33 caracteres) se renombra a evalcrit_evaluacion_fk
ALTER TABLE evaluacion_criterio
    ADD CONSTRAINT evalcrit_evaluacion_fk FOREIGN KEY ( evaluacion_id_evaluacion )
        REFERENCES evaluacion ( id_evaluacion );

--  AJUSTE PRACTICA 2: nueva llave foranea (municipio depende de departamento).
ALTER TABLE municipio
    ADD CONSTRAINT municipio_departamento_fk FOREIGN KEY ( id_departamento )
        REFERENCES departamento ( id_departamento );

ALTER TABLE plaza
    ADD CONSTRAINT plaza_contacto_empresarial_fk FOREIGN KEY ( id_contacto )
        REFERENCES contacto_empresarial ( id_contacto );

ALTER TABLE plaza
    ADD CONSTRAINT plaza_empresa_fk FOREIGN KEY ( empresa_id_empresa )
        REFERENCES empresa ( id_empresa );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            16
-- CREATE INDEX                             0
-- ALTER TABLE                             35
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS (script original)                 7  -> corregidos, ver comentarios "CORREGIDO"
-- WARNINGS                                 0
-- AJUSTES ESTRUCTURALES PRACTICA 2         10  (5 tablas nuevas + 5 columnas normalizadas)
