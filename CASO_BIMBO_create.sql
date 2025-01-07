-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-12-07 23:54:29.015

-- tables
-- Table: cli_cliente
CREATE TABLE cli_cliente (
    cli_rut int  NOT NULL,
    cli_dv varchar(1)  NOT NULL,
    cli_nombres varchar(100)  NOT NULL,
    cli_apellidos varchar(100)  NOT NULL,
    cli_telefono int  NOT NULL,
    cli_correo varchar(100)  NOT NULL,
    cli_direccion varchar(100)  NOT NULL,
    cli_region varchar(100)  NOT NULL,
    cli_ciudad varchar(100)  NOT NULL,
    rut_ruta_rut_id int  NOT NULL,
    fecha_registro datetime  NOT NULL,
    usuario_registro varchar(100)  NOT NULL,
    CONSTRAINT cli_cliente_pk PRIMARY KEY  (cli_rut)
);

-- Table: dev_devolucion
CREATE TABLE dev_devolucion (
    dev_id int  NOT NULL,
    dev_motivo varchar(100)  NOT NULL,
    dev_cantidad_producto_devuelto int  NOT NULL,
    dev_estado varchar(100)  NOT NULL,
    dev_observacion varchar(500)  NOT NULL,
    pro_producto_pro_id int  NOT NULL,
    cli_cliente_cli_rut int  NOT NULL,
    ven_vendedor_ven_rut int  NOT NULL,
    usuario_registro varchar(100)  NOT NULL,
    fecha_registro datetime  NOT NULL,
    dev_fecha datetime  NOT NULL,
    CONSTRAINT dev_devolucion_pk PRIMARY KEY  (dev_id)
);

-- Table: dis_distribuidor
CREATE TABLE dis_distribuidor (
    dis_id int  NOT NULL,
    dis_nombre varchar(100)  NOT NULL,
    dis_telefono int  NOT NULL,
    dis_correo varchar(100)  NOT NULL,
    dis_direccion varchar(100)  NOT NULL,
    dis_ciudad varchar(100)  NOT NULL,
    dis_region varchar(100)  NOT NULL,
    sup_supervisor_sup_rut int  NOT NULL,
    usuario_registro varchar(100)  NOT NULL,
    fecha_registro datetime  NOT NULL,
    CONSTRAINT dis_distribuidor_pk PRIMARY KEY  (dis_id)
);

-- Table: ger_gerencia
CREATE TABLE ger_gerencia (
    ger_id int  NOT NULL,
    ger_gerente varchar(100)  NOT NULL,
    ger_direccion varchar(100)  NOT NULL,
    ger_telefono int  NOT NULL,
    ger_ciudad varchar(100)  NOT NULL,
    ger_region varchar(100)  NOT NULL,
    usuario_registro varchar(100)  NOT NULL,
    fecha_registro datetime  NOT NULL,
    CONSTRAINT ger_gerencia_pk PRIMARY KEY  (ger_id)
);

-- Table: pro_producto
CREATE TABLE pro_producto (
    pro_id int  NOT NULL,
    pro_lote varchar(100)  NOT NULL,
    pro_nombre varchar(100)  NOT NULL,
    pro_fecha_vencimiento datetime  NOT NULL,
    pro_marca varchar(100)  NOT NULL,
    pro_precio int  NOT NULL,
    usuario_registro varchar(100)  NOT NULL,
    fecha_registro datetime  NOT NULL,
    CONSTRAINT pro_producto_pk PRIMARY KEY  (pro_id)
);

-- Table: rev_revision
CREATE TABLE rev_revision (
    rev_id int  NOT NULL,
    rev_fecha datetime  NOT NULL,
    rev_estado varchar(100)  NOT NULL,
    rev_observaciones varchar(500)  NOT NULL,
    sup_supervisor_sup_rut int  NOT NULL,
    ger_gerencia_ger_id int  NOT NULL,
    dev_devolucion_dev_id int  NOT NULL,
    usuario_registro varchar(100)  NOT NULL,
    fecha_registro datetime  NOT NULL,
    CONSTRAINT rev_revision_pk PRIMARY KEY  (rev_id)
);

-- Table: rut_ruta
CREATE TABLE rut_ruta (
    rut_id int  NOT NULL,
    vendedor_rut_vendedor int  NOT NULL,
    dis_distribuidor_dis_id int  NOT NULL,
    usuario_registro varchar(100)  NOT NULL,
    fecha_registro datetime  NOT NULL,
    CONSTRAINT rut_ruta_pk PRIMARY KEY  (rut_id)
);

-- Table: sup_supervisor
CREATE TABLE sup_supervisor (
    sup_rut int  NOT NULL,
    sup_dv varchar(1)  NOT NULL,
    sup_nombres varchar(100)  NOT NULL,
    sup_apellidos varchar(100)  NOT NULL,
    sup_telefono int  NOT NULL,
    sup_correo varchar(100)  NOT NULL,
    sup_direccion varchar(100)  NOT NULL,
    sup_ciudad varchar(100)  NOT NULL,
    sup_region varchar(100)  NOT NULL,
    usuario_registro varchar(100)  NOT NULL,
    fecha_registro datetime  NOT NULL,
    CONSTRAINT sup_supervisor_pk PRIMARY KEY  (sup_rut)
);

-- Table: ven_vendedor
CREATE TABLE ven_vendedor (
    ven_rut int  NOT NULL,
    ven_dv varchar(1)  NOT NULL,
    ven_nombres varchar(100)  NOT NULL,
    ven_apellidos varchar(100)  NOT NULL,
    ven_telefono int  NOT NULL,
    ven_correo varchar(100)  NOT NULL,
    ven_direccion varchar(100)  NOT NULL,
    ven_ciudad varchar(100)  NOT NULL,
    ven_region varchar(100)  NOT NULL,
    usuario_registro varchar(100)  NOT NULL,
    fecha_registro datetime  NOT NULL,
    CONSTRAINT ven_vendedor_pk PRIMARY KEY  (ven_rut)
);

-- foreign keys
-- Reference: cli_cliente_rut_ruta (table: cli_cliente)
ALTER TABLE cli_cliente ADD CONSTRAINT cli_cliente_rut_ruta
    FOREIGN KEY (rut_ruta_rut_id)
    REFERENCES rut_ruta (rut_id);

-- Reference: dev_devolucion_cli_cliente (table: dev_devolucion)
ALTER TABLE dev_devolucion ADD CONSTRAINT dev_devolucion_cli_cliente
    FOREIGN KEY (cli_cliente_cli_rut)
    REFERENCES cli_cliente (cli_rut);

-- Reference: dev_devolucion_pro_producto (table: dev_devolucion)
ALTER TABLE dev_devolucion ADD CONSTRAINT dev_devolucion_pro_producto
    FOREIGN KEY (pro_producto_pro_id)
    REFERENCES pro_producto (pro_id);

-- Reference: dev_devolucion_ven_vendedor (table: dev_devolucion)
ALTER TABLE dev_devolucion ADD CONSTRAINT dev_devolucion_ven_vendedor
    FOREIGN KEY (ven_vendedor_ven_rut)
    REFERENCES ven_vendedor (ven_rut);

-- Reference: dis_distribuidor_regional_sup_supervisor (table: dis_distribuidor)
ALTER TABLE dis_distribuidor ADD CONSTRAINT dis_distribuidor_regional_sup_supervisor
    FOREIGN KEY (sup_supervisor_sup_rut)
    REFERENCES sup_supervisor (sup_rut);

-- Reference: rev_revision_devolucion_dev_devolucion (table: rev_revision)
ALTER TABLE rev_revision ADD CONSTRAINT rev_revision_devolucion_dev_devolucion
    FOREIGN KEY (dev_devolucion_dev_id)
    REFERENCES dev_devolucion (dev_id);

-- Reference: rev_revision_devolucion_ger_gerencia (table: rev_revision)
ALTER TABLE rev_revision ADD CONSTRAINT rev_revision_devolucion_ger_gerencia
    FOREIGN KEY (ger_gerencia_ger_id)
    REFERENCES ger_gerencia (ger_id);

-- Reference: rev_revision_devolucion_sup_supervisor (table: rev_revision)
ALTER TABLE rev_revision ADD CONSTRAINT rev_revision_devolucion_sup_supervisor
    FOREIGN KEY (sup_supervisor_sup_rut)
    REFERENCES sup_supervisor (sup_rut);

-- Reference: rut_ruta_dis_distribuidor (table: rut_ruta)
ALTER TABLE rut_ruta ADD CONSTRAINT rut_ruta_dis_distribuidor
    FOREIGN KEY (dis_distribuidor_dis_id)
    REFERENCES dis_distribuidor (dis_id);

-- Reference: ruta_vendedor (table: rut_ruta)
ALTER TABLE rut_ruta ADD CONSTRAINT ruta_vendedor
    FOREIGN KEY (vendedor_rut_vendedor)
    REFERENCES ven_vendedor (ven_rut);

-- End of file.

