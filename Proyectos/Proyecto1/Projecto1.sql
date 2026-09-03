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
-- ERRORS                                   0
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

-- ============================================================
-- CORRECCIONES Y RESTRICCIONES ADICIONALES (agregadas manualmente)
-- Estas restricciones no se generan automaticamente al hacer
-- "Engineer to Relational Model" en Data Modeler; se agregan aqui
-- para cumplir las reglas de negocio del enunciado.
-- ============================================================

-- Correccion: direccion_cliente debe admitir nulos (no es un dato
-- obligatorio segun las reglas de negocio del cliente)
ALTER TABLE cliente MODIFY ( direccion_cliente NULL );

-- --------------------------------------------------------------
-- Restricciones UNIQUE de codigos y nombres de catalogos
-- --------------------------------------------------------------
ALTER TABLE pais ADD CONSTRAINT pais_codigo_un UNIQUE ( codigo_pais );
ALTER TABLE pais ADD CONSTRAINT pais_nombre_un UNIQUE ( nombre_pais );

ALTER TABLE tipo_tienda ADD CONSTRAINT tipo_tienda_codigo_un UNIQUE ( codigo_tipo_tienda );
ALTER TABLE tipo_tienda ADD CONSTRAINT tipo_tienda_nombre_un UNIQUE ( nombre_tipo_tienda );

ALTER TABLE cargo ADD CONSTRAINT cargo_codigo_un UNIQUE ( codigo_cargo );
ALTER TABLE cargo ADD CONSTRAINT cargo_nombre_un UNIQUE ( nombre_cargo );

ALTER TABLE tipo_identificacion ADD CONSTRAINT tipo_identificacion_codigo_un UNIQUE ( codigo_tipo_identificacion );
ALTER TABLE tipo_identificacion ADD CONSTRAINT tipo_identificacion_nombre_un UNIQUE ( nombre_tipo_identificacion );

ALTER TABLE categoria ADD CONSTRAINT categoria_codigo_un UNIQUE ( codigo_categoria );
ALTER TABLE categoria ADD CONSTRAINT categoria_nombre_un UNIQUE ( nombre_categoria );

ALTER TABLE marca ADD CONSTRAINT marca_codigo_un UNIQUE ( codigo_marca );
ALTER TABLE marca ADD CONSTRAINT marca_nombre_un UNIQUE ( nombre_marca );

ALTER TABLE estado_venta ADD CONSTRAINT estado_venta_nombre_un UNIQUE ( nombre_estado );

ALTER TABLE metodo_pago ADD CONSTRAINT metodo_pago_codigo_un UNIQUE ( codigo_metodo_pago );
ALTER TABLE metodo_pago ADD CONSTRAINT metodo_pago_nombre_un UNIQUE ( nombre_metodo_pago );

-- --------------------------------------------------------------
-- Restricciones UNIQUE compuestas (reglas de negocio de ubicacion
-- e identificacion de clientes)
-- --------------------------------------------------------------

-- El nombre de un departamento no se repite dentro del mismo pais
ALTER TABLE departamento
    ADD CONSTRAINT departamento_pais_nombre_un UNIQUE ( pais_id_pais, nombre_departamento );

-- El nombre de un municipio no se repite dentro del mismo departamento
ALTER TABLE municipio
    ADD CONSTRAINT municipio_depto_nombre_un UNIQUE ( departamento_id_departamento, nombre_municipio );

-- La combinacion de tipo y numero de identificacion debe ser unica
ALTER TABLE cliente
    ADD CONSTRAINT cliente_tipo_numero_un UNIQUE ( id_tipo_identificacion, numero_identificacion );

-- --------------------------------------------------------------
-- Restricciones UNIQUE de correo electronico
-- --------------------------------------------------------------

-- Correo de empleado unico (obligatorio segun regla de negocio)
ALTER TABLE empleado ADD CONSTRAINT empleado_correo_un UNIQUE ( correo_empleado );

-- Correo de cliente unico cuando esta registrado
-- (Oracle permite multiples valores NULL en una columna UNIQUE,
-- por lo que esta restriccion no afecta a los clientes sin correo)
ALTER TABLE cliente ADD CONSTRAINT cliente_correo_un UNIQUE ( correo_cliente );

-- --------------------------------------------------------------
-- Restricciones CHECK
-- --------------------------------------------------------------

ALTER TABLE producto ADD CONSTRAINT producto_precio_ck CHECK ( precio_vigente > 0 );
ALTER TABLE producto ADD CONSTRAINT producto_existencia_ck CHECK ( existencia_actual >= 0 );

ALTER TABLE detalle_venta ADD CONSTRAINT detalle_venta_cantidad_ck CHECK ( cantidad > 0 );
ALTER TABLE detalle_venta ADD CONSTRAINT detalle_venta_precio_ck CHECK ( precio_unitario > 0 );

-- El subtotal se obtiene de multiplicar cantidad por precio unitario;
-- se puede validar con CHECK porque solo depende de columnas de la
-- misma fila (no cruza tablas)
ALTER TABLE detalle_venta
    ADD CONSTRAINT detalle_venta_subtotal_ck CHECK ( subtotal = cantidad * precio_unitario );

ALTER TABLE pago ADD CONSTRAINT pago_monto_ck CHECK ( monto_pago > 0 );

-- Nota: la regla "la fecha de contratacion no puede ser posterior a la
-- fecha actual" (tabla empleado) NO se implementa como CHECK porque
-- Oracle no permite funciones no deterministicas (SYSDATE) dentro de
-- un CHECK constraint (error ORA-02436). Se valida mediante consulta
-- SQL (ver seccion de consultas de validacion en el manual tecnico).

-- ============================================================
-- RENOMBRADO DE LLAVES FORANEAS
-- Data Modeler genero las columnas FK con el nombre de la tabla
-- padre como prefijo (ej. municipio_id_municipio). Se renombran
-- aqui para que coincidan con el diccionario de datos y con el
-- estilo usado en el resto de la solucion (id_<entidad>).
-- RENAME COLUMN actualiza automaticamente las referencias en las
-- constraints PK, FK, UNIQUE y CHECK ya creadas; no es necesario
-- recrearlas.
-- ============================================================

ALTER TABLE departamento RENAME COLUMN pais_id_pais TO id_pais;
ALTER TABLE municipio RENAME COLUMN departamento_id_departamento TO id_departamento;

ALTER TABLE tienda RENAME COLUMN municipio_id_municipio TO id_municipio;
ALTER TABLE tienda RENAME COLUMN tipo_tienda_id_tipo_tienda TO id_tipo_tienda;

ALTER TABLE empleado RENAME COLUMN tienda_id_tienda TO id_tienda;
ALTER TABLE empleado RENAME COLUMN cargo_id_cargo TO id_cargo;

ALTER TABLE cliente RENAME COLUMN municipio_id_municipio TO id_municipio;

ALTER TABLE producto RENAME COLUMN categoria_id_categoria TO id_categoria;
ALTER TABLE producto RENAME COLUMN marca_id_marca TO id_marca;

ALTER TABLE venta RENAME COLUMN cliente_id_cliente TO id_cliente;
ALTER TABLE venta RENAME COLUMN tienda_id_tienda TO id_tienda;
ALTER TABLE venta RENAME COLUMN empleado_id_empleado TO id_empleado;
ALTER TABLE venta RENAME COLUMN estado_venta_id_estado TO id_estado;

ALTER TABLE detalle_venta RENAME COLUMN venta_id_venta TO id_venta;
ALTER TABLE detalle_venta RENAME COLUMN producto_id_producto TO id_producto;

ALTER TABLE pago RENAME COLUMN venta_id_venta TO id_venta;
ALTER TABLE pago RENAME COLUMN metodo_pago_id_metodo_pago TO id_metodo_pago;

-- ============================================================
-- Fin de correcciones
-- ============================================================
