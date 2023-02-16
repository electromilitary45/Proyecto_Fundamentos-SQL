-- comandos princiapales
use master
go 
-- creacion base datos
drop database bd_DeliFood
create database bd_DeliFood -- creacion de tablas
 use bd_DeliFood -- Estructura de la tabla "pais"

CREATE TABLE pais (
                idPais INT Identity (1,1) PRIMARY KEY,
                nombre VARCHAR(20) NOT NULL
        );
-- Estructura de la tabla "compania"
CREATE TABLE compania (
        idCompania INT Identity (1,1) PRIMARY KEY,
        nombre VARCHAR(50) NOT NULL,
        idPais INT NOT NULL,
        FOREIGN KEY (idPais) REFERENCES pais(idPais)
);
-- Estructura de la tabla "sucursal"
CREATE TABLE sucursal (
        idSucursal INT Identity (1,1) PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        direccion VARCHAR(200) NOT NULL,
        compania_id INT NOT NULL,
        pais_id INT NOT NULL,
        FOREIGN KEY (compania_id) REFERENCES compania(idCompania),
        FOREIGN KEY (pais_id) REFERENCES pais(idPais)
);
-- Estructura de la tabla "moneda"
CREATE TABLE moneda (
        idMoneda INT Identity (1,1) PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        simbolo VARCHAR(10) NOT NULL,
        pais_id INT NOT NULL,
        FOREIGN KEY (pais_id) REFERENCES pais(idPais)
);
-- Estructura de la tabla "empleado"
CREATE TABLE colaborador (
        idColaborador INT Identity (1,1) PRIMARY KEY,
        status BIT NOT NULL DEFAULT 1,
        nombre VARCHAR(20) NOT NULL,
        primApellido VARCHAR(20) NOT NULL,
        segApellido VARCHAR(20) NOT NULL,
        puesto VARCHAR(50) NOT NULL,
        salario BIGINT NOT NULL,
        id_pais INT NOT NULL,
        sucursal_id INT NOT NULL,
        FOREIGN KEY (id_pais) REFERENCES pais(idPais),
        FOREIGN KEY (sucursal_id) REFERENCES sucursal(idSucursal)
);
CREATE TABLE clientes (
        idCliente INT Identity (1,1) PRIMARY KEY,
        nombre VARCHAR(20) NOT NULL,
        primApellido VARCHAR(20) NOT NULL,
        segApellido VARCHAR(20) NOT NULL,
        direccion VARCHAR(255) NOT NULL,
        telefono VARCHAR(15) NOT NULL,
        email VARCHAR(50) NOT NULL,
        cliente_frecuente BIT NOT NULL DEFAULT 'FALSE',
        lista_negra BIT NOT NULL DEFAULT 'FALSE',
        id_pais INT NOT NULL,
        FOREIGN KEY (id_pais) REFERENCES pais(idPais)
);
-- Estructura de la tabla "categoria_producto"
CREATE TABLE categoria_producto (
        idCategoria INT Identity (1,1) PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        descripcion VARCHAR(200) NOT NULL
);

CREATE TABLE proveedor(
        idProveedor INT Identity (1,1) PRIMARY KEY,
        nombreEmpresa VARCHAR(50) NOT NULL,
        cedulaJuridica VARCHAR(12) NOT NULL
);
-- Estructura de la tabla "producto"
CREATE TABLE producto (
        idProducto INT Identity (1,1) PRIMARY KEY,
        nombre VARCHAR(20) NOT NULL,
        descripcion VARCHAR(200) NOT NULL,
        precio BIGINT NOT NULL,
        moneda_id INT NOT NULL,
        categoria_id INT NOT NULL,
        id_proveedor INT NOT NULL,
        FOREIGN KEY (id_proveedor) REFERENCES proveedor(idProveedor),
        FOREIGN KEY (moneda_id) REFERENCES moneda(idMoneda),
        FOREIGN KEY (categoria_id) REFERENCES categoria_producto(idCategoria)
);

CREATE TABLE venta(
        idVenta INT Identity (1,1) PRIMARY KEY,
        fechaEmision DATE NOT NULL,
        fechaRechazo DATE,
        statusVenta INT NOT NULL,
        id_colaborador INT NOT NULL,
        id_cliente INT NOT NULL,
        id_producto INT NOT NULL,
        id_moneda INT NOT NULL,
        FOREIGN KEY (id_moneda) REFERENCES moneda(idMoneda),
        FOREIGN KEY (id_producto) REFERENCES producto(idProducto),
        FOREIGN KEY (id_cliente) REFERENCES clientes(idCliente),
        FOREIGN KEY (id_colaborador) REFERENCES colaborador(idColaborador),
        constraint stVenta CHECK (
                statusVenta between 1 and 5
        )
);
CREATE TABLE incidente(
        idIncidente INT Identity (1,1) PRIMARY KEY,
        fecha DATE NOT NULL,
        descripcion VARCHAR(255) NOT NULL,
        id_cliente INT NOT NULL,
        FOREIGN KEY (id_cliente) REFERENCES clientes(idCliente),
);

-----COMANDOS METER DATOS-------

-- Insertar paises
INSERT INTO pais (nombre) VALUES ('Estados Unidos'), ('Panama'), ('Nicaragua'), ('Costa Rica'), ('Canada'), ('Japon'), ('China'), ('Alemania');

-- Insertar companias
INSERT INTO compania (nombre, id_pais) VALUES ('Madrigal Electromotors' , 8), ('Ebay', 1), ('Super 99', 2), ('NicaSuper', 3), ('Dos Pinos' , 4) , ('PolarBear', 5), ('Mitshubishi', 6), ('GuanzhouMart', 7);

--insertar un proveedor
INSERT INTO proveedor (nombreEmpresa, cedulaJuridica) VALUES ('DeliFood', '3-101-123456');

--insertar una categoria
INSERT INTO categoria_producto (nombre, descripcion) VALUES ('Bebidas', 'Bebidas alcohólicas y no alcohólicas');

-- Insertar monedas
INSERT INTO moneda (nombre, simbolo, pais_id) VALUES ('Colón', '₡', 4), ('Dólar', '$', 1), ('Yen', '¥', 7);

-- Insertar sucursales
INSERT INTO sucursal(nombre,direccion,compania_id,pais_id) VALUES('Sucursal 1','Munich',1,8), ('Sucursal 2','Munich',1,8),('Sucursal 1','Washington',2,1),('Sucursal 2','Washington',2,1),('Sucursal 1','Washington',4,3),('Sucursal 2','Washington',4,3);

-- Insertar Clientes
INSERT INTO cliente(nombre,primApellido,segApellido,direccion,telefono,email,cliente_frecuente,lista_negra,pais)
values('Juan','Perez','Solis','Curridabat, Condominio la Estancia','12345678','j@gmail.com','TRUE','FALSE',4),
      ('Roberto','Perez','Marquez','Cartago, Condominio la Estancia','00000000','rob@gmail.com','FALSE','FALSE',1),
      ('Adolf','Hitler','Salchicha','Munich','87654321','fuhrer@gmail.com','FALSE','TRUE',8);

-- Insertar colaboradores
INSERT INTO colaborador (status, nombre, primApellido,segApellido,puesto,salario,id_pais,sucursal_id)
values (1 , 'Juan', 'Perez', 'Solano', 'Gerente de ventas', 500000 , 4 , 1),
       (1 , 'Matilda', 'Suarez', 'Madrigal', 'Adminstradora de incidentes', 400000 , 2 , 2),
       (0 , 'Luisa', 'Humbrigde', 'Black', 'Recursos Humanos', 1000000 , 8 , 3);

-- Insertar productos
INSERT INTO producto (nombre,descripcion,precio,moneda_id,categoria_id,id_proveedor) VALUES ('CocaCola','Bebida azucara','1000',4,1,1);
INSERT INTO producto (nombre,descripcion,precio,moneda_id,categoria_id,id_proveedor) VALUES ('Pepsi','Bebida azucara','1000',4,1,1);
INSERT INTO producto (nombre,descripcion,precio,moneda_id,categoria_id,id_proveedor) VALUES ('Fanta','Bebida azucara','1000',4,1,1);
INSERT INTO producto (nombre,descripcion,precio,moneda_id,categoria_id,id_proveedor) VALUES ('Sprite','Bebida azucara','1000',4,1,1);

-- Insertar ventas
INSERTE INTO venta (fechaEmision, fechaRechazo,statusVenta,idColaborador,id_cliente) VALUES ();