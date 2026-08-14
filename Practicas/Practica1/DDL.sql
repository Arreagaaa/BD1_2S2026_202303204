-- Generado por Oracle SQL Developer Data Modeler 24.3.1.347.1153
--   en:        2026-08-13 15:33:11 CST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



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
    contacto_empresarial_id_contacto NUMBER(6) NOT NULL
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
    estado                     VARCHAR2(15),
    estudiante_id_estudiante   NUMBER(6) NOT NULL,
    plaza_id_plaza             NUMBER(6) NOT NULL,
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

CREATE TABLE empresa (
    id_empresa       NUMBER(6) NOT NULL,
    nombre           VARCHAR2(150),
    direccion        VARCHAR2(200),
    sector_economico VARCHAR2(20)
);

ALTER TABLE empresa ADD CONSTRAINT empresa_pk PRIMARY KEY ( id_empresa );

CREATE TABLE estudiante (
    id_estudiante           NUMBER(6) NOT NULL,
    nombre_completo         VARCHAR2(150),
    carne                   VARCHAR2(20),
    carrera_tecnica         VARCHAR2(100),
    direccion               VARCHAR2(200),
    telefono                VARCHAR2(20),
    fecha_nacimiento        DATE,
    genero                  VARCHAR2(20),
    departamento_residencia VARCHAR2(60),
    municipio_residencia    VARCHAR2(60),
    es_repitencia           CHAR(1),
    instituto_id_instituto  NUMBER(6) NOT NULL
);

ALTER TABLE estudiante ADD CONSTRAINT estudiante_pk PRIMARY KEY ( id_estudiante );

CREATE TABLE evaluacion (
    id_evaluacion              NUMBER(8) NOT NULL,
    tipo_evaluacion            VARCHAR2(10),
    fecha_evaluacion           DATE,
    colocacion_id_colocacion   NUMBER(6) NOT NULL,
    catedratico_id_catedratico NUMBER(6) NOT NULL
);

ALTER TABLE evaluacion ADD CONSTRAINT evaluacion_pk PRIMARY KEY ( id_evaluacion );

CREATE TABLE evaluacion_criterio (
    punteo                          NUMBER(1),
    evaluacion_id_evaluacion        NUMBER(8) NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
    criterio_evaluacion_id_criterio NUMBER(4) NOT NULL
);

ALTER TABLE evaluacion_criterio ADD CONSTRAINT evaluacion_criterio_pk PRIMARY KEY ( evaluacion_id_evaluacion,
                                                                                    criterio_evaluacion_id_criterio );

CREATE TABLE instituto (
    id_instituto        NUMBER(6) NOT NULL,
    nombre              VARCHAR2(150),
    direccion           VARCHAR2(200),
    codigo_autorizacion VARCHAR2(30)
);

ALTER TABLE instituto ADD CONSTRAINT instituto_pk PRIMARY KEY ( id_instituto );

CREATE TABLE plaza (
    id_plaza                         NUMBER(6) NOT NULL,
    especialidad_tecnica             VARCHAR2(100),
    descripcion                      VARCHAR2(300),
    empresa_id_empresa               NUMBER(6) NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
    contacto_empresarial_id_contacto NUMBER(6) NOT NULL
);

ALTER TABLE plaza ADD CONSTRAINT plaza_pk PRIMARY KEY ( id_plaza );

ALTER TABLE bitacora
    ADD CONSTRAINT bitacora_colocacion_fk FOREIGN KEY ( colocacion_id_colocacion )
        REFERENCES colocacion ( id_colocacion );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE bitacora
    ADD CONSTRAINT bitacora_contacto_empresarial_fk FOREIGN KEY ( contacto_empresarial_id_contacto )
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

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE contacto_empresarial
    ADD CONSTRAINT contacto_empresarial_empresa_fk FOREIGN KEY ( empresa_id_empresa )
        REFERENCES empresa ( id_empresa );

ALTER TABLE estudiante
    ADD CONSTRAINT estudiante_instituto_fk FOREIGN KEY ( instituto_id_instituto )
        REFERENCES instituto ( id_instituto );

ALTER TABLE evaluacion
    ADD CONSTRAINT evaluacion_catedratico_fk FOREIGN KEY ( catedratico_id_catedratico )
        REFERENCES catedratico ( id_catedratico );

ALTER TABLE evaluacion
    ADD CONSTRAINT evaluacion_colocacion_fk FOREIGN KEY ( colocacion_id_colocacion )
        REFERENCES colocacion ( id_colocacion );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE evaluacion_criterio
    ADD CONSTRAINT evaluacion_criterio_criterio_evaluacion_fk FOREIGN KEY ( criterio_evaluacion_id_criterio )
        REFERENCES criterio_evaluacion ( id_criterio );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE evaluacion_criterio
    ADD CONSTRAINT evaluacion_criterio_evaluacion_fk FOREIGN KEY ( evaluacion_id_evaluacion )
        REFERENCES evaluacion ( id_evaluacion );

ALTER TABLE plaza
    ADD CONSTRAINT plaza_contacto_empresarial_fk FOREIGN KEY ( contacto_empresarial_id_contacto )
        REFERENCES contacto_empresarial ( id_contacto );

ALTER TABLE plaza
    ADD CONSTRAINT plaza_empresa_fk FOREIGN KEY ( empresa_id_empresa )
        REFERENCES empresa ( id_empresa );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            11
-- CREATE INDEX                             0
-- ALTER TABLE                             25
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
-- ERRORS                                   7
-- WARNINGS                                 0
