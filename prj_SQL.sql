-- comandos princiapales
use master
go 
-- creacion base datos
drop database bd_DeliFood;
create database bd_DeliFood; -- creacion de tablas
use bd_DeliFood; -- Estructura de la tabla "pais"\

-- drop de tablas--
DROP TABLE clientes;
------------------------------CREACION DE TABLAS-----------------------------------
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
        idCompania INT NOT NULL,
        idPais INT NOT NULL,
        FOREIGN KEY (idCompania) REFERENCES compania(idCompania),
        FOREIGN KEY (idPais) REFERENCES pais(idPais)
);
-- Estructura de la tabla "moneda"
CREATE TABLE moneda (
        idMoneda INT Identity (1,1) PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        simbolo VARCHAR(10) NOT NULL,
        idPais INT NOT NULL,
        FOREIGN KEY (idPais) REFERENCES pais(idPais)
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
        idPais INT NOT NULL,
        idSucursal INT NOT NULL,
        FOREIGN KEY (idPais) REFERENCES pais(idPais),
        FOREIGN KEY (idSucursal) REFERENCES sucursal(idSucursal)
);
-- Estructura de la tabla "cliente"--
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
        idPais INT NOT NULL,
        FOREIGN KEY (idPais) REFERENCES pais(idPais)
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
        idMoneda INT NOT NULL,
        idCategoria INT NOT NULL,
        idProveedor INT NOT NULL,
        FOREIGN KEY (idProveedor) REFERENCES proveedor(idProveedor),
        FOREIGN KEY (idMoneda) REFERENCES moneda(idMoneda),
        FOREIGN KEY (idCategoria) REFERENCES categoria_producto(idCategoria)
        
);
-------VENTAS----------------
CREATE TABLE venta(
        idVenta INT Identity (1,1) PRIMARY KEY,
        fechaEmision DATE NOT NULL,
        fechaRechazo DATE,
        statusVenta INT NOT NULL,
        idColaborador INT NOT NULL,
        idCliente INT NOT NULL,
        idProducto INT NOT NULL,
        idMoneda INT NOT NULL,
        FOREIGN KEY (idMoneda) REFERENCES moneda(idMoneda),
        FOREIGN KEY (idProducto) REFERENCES producto(idProducto),
        FOREIGN KEY (idCliente) REFERENCES clientes(idCliente),
        FOREIGN KEY (idColaborador) REFERENCES colaborador(idColaborador),
        constraint stVenta CHECK (
                statusVenta between 1 and 5
        )
);

-------INCIDENTES----------------
CREATE TABLE incidente(
        idIncidente INT Identity (1,1) PRIMARY KEY,
        fecha DATE NOT NULL,
        descripcion VARCHAR(255) NOT NULL,
        idCliente INT NOT NULL,
        FOREIGN KEY (idCliente) REFERENCES clientes(idCliente),
);

alter table incidente add estado varchar(50) null  default 'Pendiente';

-------------------------------COMANDOS METER DATOS--------------------------------------

-- Insertar paises
INSERT INTO pais (nombre) VALUES ('Estados Unidos'), ('Panama'), ('Nicaragua'), ('Costa Rica'), ('Canada'), ('Japon'), ('China'), ('Alemania');

-- Insertar companias
INSERT INTO compania ( nombre ,idPais) VALUES ('Madrigal Electromotors' , 8), ('Ebay', 1), ('Super 99', 2), ('NicaSuper', 3), ('Dos Pinos' , 4) , ('PolarBear', 5), ('Mitshubishi', 6), ('GuanzhouMart', 7);

--insertar un proveedor
INSERT INTO proveedor ( nombreEmpresa,cedulaJuridica) VALUES ('DeliFood', '3-101-123456');

--insertar una categoria
INSERT INTO categoria_producto (nombre,descripcion) VALUES ('Alcholicas','Bebidas Alcoholicas'),('No alcholicas','Bebidas No alcohólicas'),('Gaseosas','Bebidas Gaseosas');

-- Insertar monedas
INSERT INTO moneda ( nombre,simbolo, idPais) VALUES ('Colón', '₡', 4), ('Dólar', '$', 1), ('Yen', '¥', 7);

-- Insertar sucursales
INSERT INTO sucursal (nombre,direccion,idCompania,idPais) VALUES('Sucursal 1','Munich',1,8), ('Sucursal 2','Cartago',1,8),('Sucursal 3','San Jose',2,1),('Sucursal 3','Washington',2,1),('Sucursal 4','Barcelona',4,3),('Sucursal 5','Madrid',4,3);

-------- Insertar Clientes -------
INSERT INTO clientes(nombre,primApellido,segApellido,direccion,telefono,email,cliente_frecuente,lista_negra,idPais)
values('Juan','Perez','Solis','Curridabat, Condominio la Estancia','12345678','j@gmail.com','TRUE','FALSE',4),
('Roberto','Perez','Marquez','Cartago, Condominio la Estancia','00000000','rob@gmail.com','FALSE','FALSE',1),
('Adolf','Hitler','Salchicha','Munich','87654321','fuhrer@gmail.com','FALSE','TRUE',8);

-- Insertar colaboradores
INSERT INTO colaborador (nombre, primApellido,segApellido,puesto,salario,idPais,idSucursal)
values ( 'Juan', 'Perez', 'Solano', 'Gerente de ventas', 500000 , 4 , 1),
( 'Matilda', 'Suarez', 'Madrigal', 'Adminstradora de incidentes', 400000 , 2 , 2),
( 'Luisa', 'Humbrigde', 'Black', 'Recursos Humanos', 1000000 , 8 , 3);

-- Insertar productos
INSERT INTO producto (nombre,descripcion,precio,idMoneda,idCategoria,idProveedor) VALUES ('CocaCola','Bebida azucara','1000',1,1,1);
INSERT INTO producto (nombre,descripcion,precio,idMoneda,idCategoria,idProveedor) VALUES ('Pepsi','Bebida azucara','1000',1,1,1);
INSERT INTO producto (nombre,descripcion,precio,idMoneda,idCategoria,idProveedor) VALUES ('Fanta','Bebida azucara','1000',1,1,1);
INSERT INTO producto (nombre,descripcion,precio,idMoneda,idCategoria,idProveedor) VALUES ('Sprite','Bebida azucara','1000',1,1,1);

-- Insertar ventas
INSERT into venta (fechaEmision,idColaborador,idCliente,idProducto,idMoneda,statusVenta)  VALUES ('2023-01-01', 1, 1, 1,1,1);

--Inserts de incidentes
INSERT INTO incidente (fecha,descripcion, idCliente) VALUES ('2023-01-01', 'El cliente no recibio su producto', 1);


----------------------------COMANDOS PARA LEER--------------------------------

------SELECTS PARA PAIS----
SELECT * FROM pais;
SELECT* FROM pais WHERE nombre like ' %a% ';
SELECT* FROM pais WHERE nombre like ' %b% ' or nombre like ' %e ';
SELECT * FROM pais WHERE nombre not LIKE ' c% ' and nombre not like 'C%';

-------SELECTS PARA COMPANIAS---

SELECT * FROM compania;

SELECT COUNT(idCompania) AS "Total de CompaÑIAS" from compania;

------SELECTS PARA PRODUCTOS---
SELECT * FROM producto;

SELECT producto.idProducto, categoria_producto.nombre, producto.descripcion, proveedor.nombreEmpresa, moneda.simbolo, producto.nombre, producto.precio 
from producto 
INNER JOIN proveedor on proveedor.idProveedor=producto.idProveedor 
INNER JOIN moneda on moneda.idMoneda = producto.idMoneda
INNER JOIN categoria_producto on categoria_producto.idCategoria=producto.idCategoria

SELECT * FROM producto ORDER BY precio desc;

SELECT * FROM producto where precio BETWEEN 600 and 999;

------SELECT PARA VENTAS--
SELECT * FROM venta;

------SELECT PARA SUCURSALES---
SELECT * FROM sucursal;

------SELECT PARA CATEGORIAS PRODUCTO---------
SELECT * FROM categoria_producto;

------SELECT PARA CLIENTES-------------
SELECT * FROM clientes;

----------------------------COMANDOS PARA UPDATES--------------------------------

-----UPDATES PRODUCTOS-------
UPDATE producto set precio=1550 where idProducto=1;
UPDATE producto set precio=910 where idProducto=2;
UPDATE producto set precio=600 where idProducto=3;


-------------------------------COMANDOS PARA DELETE-----------------------------------------

-----DELETE PRODUCTOS--------
DELETE producto where idProducto = 7;

---------------------------------COMANDOS PARA VIEWS------------------------------------

----------VIEW 1------------
CREATE VIEW ConsultaCompaniaPais AS
SELECT compania.nombre AS compania, pais.nombre AS pais
from compania, pais
WHERE compania.idPais=pais.idPais;

SELECT * FROM ConsultaCompaniaPais;

--------VIEW 2---------------
CREATE VIEW ConsultaProductoSinNumeros AS 
SELECT producto.idProducto AS IdProducto, producto.nombre AS NOMBRE, categoria_producto.nombre AS CATEGORIA, producto.descripcion as DESCRIPCION, proveedor.nombreEmpresa as PROVEEDOR, moneda.simbolo as MONEDA, producto.precio as PRECIO
from producto, proveedor,moneda, categoria_producto
WHERE producto.idProveedor = proveedor.idProveedor AND producto.idMoneda = moneda.idMoneda AND  producto.idCategoria = categoria_producto.idCategoria;

SELECT * FROM ConsultaProductoSinNumeros;

DROP VIEW [ConsultaProductoSinNumeros];

-------VIEW 3------------

--------------------------------COMANDOS PROCESOS ALMACENADOS--------------------------------------

/*------PROCEDURE 1-------
CREATE PROCEDURE insertCliente AS 
INSERT INTO (nombre,primApellido,segApellido,direccion,telefono,email,cliente_frecuente,lista_negra,idPais)
values('Alejandro','Chavarria','Herandez','Cartago', 'Condominio la Pelona','12345678','aleCH@gmail.com','TRUE','FALSE',1);
go*/

EXEC insertCliente;

CREATE PROCEDURE selectpersona AS
BEGIN
        SELECT * FROM clientes;
END;
go

EXEC selectpersona;

