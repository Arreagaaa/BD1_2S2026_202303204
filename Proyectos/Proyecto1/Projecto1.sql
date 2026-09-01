-- Generado por Oracle SQL Developer Data Modeler 24.3.1.347.1153
--   en:        2026-09-01 15:49:29 CST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE cargo (
    id_cargo     NUMBER(3) NOT NULL,
    codigo_cargo VARCHAR2(10) NOT NULL,
    nombre_cargo VARCHAR2(50) NOT NULL
);

ALTER TABLE cargo ADD CONSTRAINT cargo_pk PRIMARY KEY ( id_cargo );

CREATE TABLE categoria (
    id_categoria     NUMBER(4) NOT NULL,
    codigo_categoria VARCHAR2(10) NOT NULL,
    nombre_categoria VARCHAR2(100) NOT NULL
);

ALTER TABLE categoria ADD CONSTRAINT categoria_pk PRIMARY KEY ( id_categoria );

CREATE TABLE cliente (
    id_cliente                                 NUMBER(8) NOT NULL,
    nombres_cliente                            VARCHAR2(100) NOT NULL,
    apellidos_cliente                          VARCHAR2(100) NOT NULL,
    numero_identificacion                      VARCHAR2(30) NOT NULL,
    telefono_cliente                           VARCHAR2(20),
    correo_cliente                             VARCHAR2(150),
    direccion_cliente                          VARCHAR2(200) NOT NULL,
    municipio_id_municipio                     NUMBER(6) NOT NULL, 
--  ERROR (Data Modeler): Column name length exceeds maximum allowed length(30)
--  CORREGIDO manualmente: se renombro a id_tipo_identificacion (23 caracteres)
    id_tipo_identificacion                     NUMBER(3) NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( id_cliente );

CREATE TABLE departamento (
    id_departamento     NUMBER(5) NOT NULL,
    nombre_departamento VARCHAR2(100) NOT NULL,
    pais_id_pais        NUMBER(3) NOT NULL
);

ALTER TABLE departamento ADD CONSTRAINT departamento_pk PRIMARY KEY ( id_departamento );

CREATE TABLE detalle_venta (
    cantidad             NUMBER(6) NOT NULL,
    precio_unitario      NUMBER(10, 2) NOT NULL,
    subtotal             NUMBER(12, 2) NOT NULL,
    venta_id_venta       NUMBER(10) NOT NULL,
    producto_id_producto NUMBER(8) NOT NULL
);

ALTER TABLE detalle_venta ADD CONSTRAINT detalle_venta_pk PRIMARY KEY ( producto_id_producto,
                                                                        venta_id_venta );


--  ERROR (Data Modeler): UK name length exceeds maximum allowed length(30)
--  CORREGIDO manualmente: se renombro a detalle_venta_un (16 caracteres)
ALTER TABLE detalle_venta ADD CONSTRAINT detalle_venta_un UNIQUE ( venta_id_venta,
                                                                    producto_id_producto );

CREATE TABLE empleado (
    id_empleado        NUMBER(8) NOT NULL,
    nombres_empleado   VARCHAR2(100) NOT NULL,
    apellidos_empleado VARCHAR2(100) NOT NULL,
    correo_empleado    VARCHAR2(150) NOT NULL,
    telefono_empleado  VARCHAR2(20),
    fecha_contratacion DATE NOT NULL,
    tienda_id_tienda   NUMBER(6) NOT NULL,
    cargo_id_cargo     NUMBER(3) NOT NULL
);

ALTER TABLE empleado ADD CONSTRAINT empleado_pk PRIMARY KEY ( id_empleado );

CREATE TABLE estado_venta (
    id_estado     NUMBER(3) NOT NULL,
    nombre_estado VARCHAR2(30) NOT NULL
);

ALTER TABLE estado_venta ADD CONSTRAINT estado_venta_pk PRIMARY KEY ( id_estado );

CREATE TABLE marca (
    id_marca     NUMBER(4) NOT NULL,
    codigo_marca VARCHAR2(10) NOT NULL,
    nombre_marca VARCHAR2(100) NOT NULL
);

ALTER TABLE marca ADD CONSTRAINT marca_pk PRIMARY KEY ( id_marca );

CREATE TABLE metodo_pago (
    id_metodo_pago     NUMBER(3) NOT NULL,
    codigo_metodo_pago VARCHAR2(10) NOT NULL,
    nombre_metodo_pago VARCHAR2(50) NOT NULL
);

ALTER TABLE metodo_pago ADD CONSTRAINT metodo_pago_pk PRIMARY KEY ( id_metodo_pago );

CREATE TABLE municipio (
    id_municipio                 NUMBER(6) NOT NULL,
    nombre_municipio             VARCHAR2(100) NOT NULL,
    departamento_id_departamento NUMBER(5) NOT NULL
);

ALTER TABLE municipio ADD CONSTRAINT municipio_pk PRIMARY KEY ( id_municipio );

CREATE TABLE pago (
    id_pago                    NUMBER(10) NOT NULL,
    monto_pago                 NUMBER(10, 2) NOT NULL,
    venta_id_venta             NUMBER(10) NOT NULL,
    metodo_pago_id_metodo_pago NUMBER(3) NOT NULL
);

ALTER TABLE pago ADD CONSTRAINT pago_pk PRIMARY KEY ( id_pago );

CREATE TABLE pais (
    id_pais     NUMBER(3) NOT NULL,
    codigo_pais VARCHAR2(10) NOT NULL,
    nombre_pais VARCHAR2(100) NOT NULL
);

ALTER TABLE pais ADD CONSTRAINT pais_pk PRIMARY KEY ( id_pais );

CREATE TABLE producto (
    id_producto            NUMBER(8) NOT NULL,
    nombre_producto        VARCHAR2(150) NOT NULL,
    descripcion_producto   VARCHAR2(500),
    precio_vigente         NUMBER(10, 2) NOT NULL,
    existencia_actual      NUMBER(8) NOT NULL,
    categoria_id_categoria NUMBER(4) NOT NULL,
    marca_id_marca         NUMBER(4) NOT NULL
);

ALTER TABLE producto ADD CONSTRAINT producto_pk PRIMARY KEY ( id_producto );

CREATE TABLE tienda (
    id_tienda                  NUMBER(6) NOT NULL,
    nombre_tienda              VARCHAR2(100) NOT NULL,
    direccion_tienda           VARCHAR2(200) NOT NULL,
    telefono_tienda            VARCHAR2(20),
    municipio_id_municipio     NUMBER(6) NOT NULL,
    tipo_tienda_id_tipo_tienda NUMBER(3) NOT NULL
);

ALTER TABLE tienda ADD CONSTRAINT tienda_pk PRIMARY KEY ( id_tienda );

CREATE TABLE tipo_identificacion (
    id_tipo_identificacion     NUMBER(3) NOT NULL,
    codigo_tipo_identificacion VARCHAR2(10) NOT NULL,
    nombre_tipo_identificacion VARCHAR2(50) NOT NULL
);

ALTER TABLE tipo_identificacion ADD CONSTRAINT tipo_identificacion_pk PRIMARY KEY ( id_tipo_identificacion );

CREATE TABLE tipo_tienda (
    id_tipo_tienda     NUMBER(3) NOT NULL,
    codigo_tipo_tienda VARCHAR2(10) NOT NULL,
    nombre_tipo_tienda VARCHAR2(50) NOT NULL
);

ALTER TABLE tipo_tienda ADD CONSTRAINT tipo_tienda_pk PRIMARY KEY ( id_tipo_tienda );

CREATE TABLE venta (
    id_venta               NUMBER(10) NOT NULL,
    fecha_venta            DATE NOT NULL,
    cliente_id_cliente     NUMBER(8) NOT NULL,
    tienda_id_tienda       NUMBER(6) NOT NULL,
    empleado_id_empleado   NUMBER(8) NOT NULL,
    estado_venta_id_estado NUMBER(3) NOT NULL
);

ALTER TABLE venta ADD CONSTRAINT venta_pk PRIMARY KEY ( id_venta );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_municipio_fk FOREIGN KEY ( municipio_id_municipio )
        REFERENCES municipio ( id_municipio );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_tipo_identificacion_fk FOREIGN KEY ( id_tipo_identificacion )
        REFERENCES tipo_identificacion ( id_tipo_identificacion );

ALTER TABLE departamento
    ADD CONSTRAINT departamento_pais_fk FOREIGN KEY ( pais_id_pais )
        REFERENCES pais ( id_pais );

ALTER TABLE detalle_venta
    ADD CONSTRAINT detalle_venta_producto_fk FOREIGN KEY ( producto_id_producto )
        REFERENCES producto ( id_producto );

ALTER TABLE detalle_venta
    ADD CONSTRAINT detalle_venta_venta_fk FOREIGN KEY ( venta_id_venta )
        REFERENCES venta ( id_venta );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_cargo_fk FOREIGN KEY ( cargo_id_cargo )
        REFERENCES cargo ( id_cargo );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_tienda_fk FOREIGN KEY ( tienda_id_tienda )
        REFERENCES tienda ( id_tienda );

ALTER TABLE municipio
    ADD CONSTRAINT municipio_departamento_fk FOREIGN KEY ( departamento_id_departamento )
        REFERENCES departamento ( id_departamento );

ALTER TABLE pago
    ADD CONSTRAINT pago_metodo_pago_fk FOREIGN KEY ( metodo_pago_id_metodo_pago )
        REFERENCES metodo_pago ( id_metodo_pago );

ALTER TABLE pago
    ADD CONSTRAINT pago_venta_fk FOREIGN KEY ( venta_id_venta )
        REFERENCES venta ( id_venta );

ALTER TABLE producto
    ADD CONSTRAINT producto_categoria_fk FOREIGN KEY ( categoria_id_categoria )
        REFERENCES categoria ( id_categoria );

ALTER TABLE producto
    ADD CONSTRAINT producto_marca_fk FOREIGN KEY ( marca_id_marca )
        REFERENCES marca ( id_marca );

ALTER TABLE tienda
    ADD CONSTRAINT tienda_municipio_fk FOREIGN KEY ( municipio_id_municipio )
        REFERENCES municipio ( id_municipio );

ALTER TABLE tienda
    ADD CONSTRAINT tienda_tipo_tienda_fk FOREIGN KEY ( tipo_tienda_id_tipo_tienda )
        REFERENCES tipo_tienda ( id_tipo_tienda );

ALTER TABLE venta
    ADD CONSTRAINT venta_cliente_fk FOREIGN KEY ( cliente_id_cliente )
        REFERENCES cliente ( id_cliente );

ALTER TABLE venta
    ADD CONSTRAINT venta_empleado_fk FOREIGN KEY ( empleado_id_empleado )
        REFERENCES empleado ( id_empleado );

ALTER TABLE venta
    ADD CONSTRAINT venta_estado_venta_fk FOREIGN KEY ( estado_venta_id_estado )
        REFERENCES estado_venta ( id_estado );

ALTER TABLE venta
    ADD CONSTRAINT venta_tienda_fk FOREIGN KEY ( tienda_id_tienda )
        REFERENCES tienda ( id_tienda );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            17
-- CREATE INDEX                             0
-- ALTER TABLE                             36
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
-- ERRORS                                   2
-- WARNINGS                                 0

-- ============================================================
-- NOTA DE CORRECCION MANUAL (post-generacion, Javier - 2026-09-01)
-- Los 2 ERRORS reportados arriba por Data Modeler ya fueron
-- corregidos manualmente en este script (ver comentarios inline):
--   1) Columna cliente.tipo_identificacion_id_tipo_identificacion
--      -> renombrada a id_tipo_identificacion
--   2) Constraint detalle_venta_venta_id_venta_producto_id_producto_un
--      -> renombrada a detalle_venta_un
-- El encabezado y el informe de resumen originales de Data Modeler
-- se conservan sin alterar como evidencia de la generacion.
-- ============================================================
