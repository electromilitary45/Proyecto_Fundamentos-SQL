--------------------------------COMANDOS PRINCIPALES--------------------------------------
use master
go 





--------------------------------CREACION DE BASE DE DATOS--------------------------------------
drop database bd_DeliFood;
create database bd_DeliFood; -- creacion de tablas
use bd_DeliFood; 





--------------------------------CREACION DE TABLAS--------------------------------------
-- Estructura de la tabla "pais"
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


-- Estructura de la tabla "colaborador"
CREATE TABLE colaborador (
        idColaborador INT Identity (1,1) PRIMARY KEY,
        status BIT NOT NULL DEFAULT 1,
        nombre VARCHAR(20) NOT NULL,
        primApellido VARCHAR(20) NOT NULL,
        segApellido VARCHAR(20) NOT NULL,
        puesto VARCHAR(50) NOT NULL,
        salario BIGINT NOT NULL,
        idPais INT NOT NULL,
        FOREIGN KEY (idPais) REFERENCES pais(idPais)
);


-- Estructura de la tabla Sucursal-Colaborador --
CREATE TABLE sucursal_colaborador(
	idSucursalColaborador int identity (1,1) primary key,
	idColaborador int not null,
	idSucursal int not null,
	FOREIGN KEY (idColaborador) REFERENCES colaborador(idColaborador),
	FOREIGN KEY (idSucursal) REFERENCES sucursal(idSucursal)
);




-- Estructura de la tabla "cliente"
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


-- Estructura de la tabla "proveedor"
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


-- Estructura de la tabla "venta"
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
        constraint stVenta CHECK ( statusVenta between 1 and 5 )
);


-- Estructura de la tabla "incidente"
CREATE TABLE incidente(
        idIncidente INT Identity (1,1) PRIMARY KEY,
        fecha DATE NOT NULL,
        descripcion VARCHAR(255) NOT NULL,
        idCliente INT NOT NULL,
		idColaborador INT NULL,
		FOREIGN KEY (idColaborador) REFERENCES colaborador (idColaborador),
        FOREIGN KEY (idCliente) REFERENCES clientes(idCliente),
);





--------------------------------INSERTS--------------------------------------
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


-- Insertar clientes
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





--------------------------------SELECTS--------------------------------------
---------SELECTS PARA PAIS---------
SELECT * FROM pais;


---------SELECTS PARA COMPANIAS---------
SELECT * FROM compania;

SELECT COUNT(idCompania) AS "Total de CompaÑIAS" from compania;

---------SELECTS PARA MONEDAS---------
SELECT * FROM moneda;


---------SELECTS PARA COLABORADORES---------
SELECT * FROM colaborador;


---------SELECT PARA CLIENTES---------

SELECT * FROM clientes;
         --- VER CLIENTES CON DATOS ESPECIFICOS ---
SELECT clientes.nombre,clientes.primApellido,clientes.telefono,clientes.email,pais.nombre 
FROM clientes 
INNER JOIN pais on pais.idPais = clientes.idPais;
          --- VER CLIENTES FRECUENTES ---
SELECT clientes.nombre,clientes.primApellido,clientes.email,pais.nombre,clientes.cliente_frecuente
FROM clientes
INNER JOIN pais on pais.idPais = clientes.idPais
WHERE clientes.cliente_frecuente = 'TRUE';

------SELECT PARA COLABORADORES---------
SELECT colaborador.nombre,colaborador.primApellido,sucursal.nombre,colaborador.puesto,colaborador.salario 
FROM colaborador 
INNER JOIN sucursal on sucursal.idSucursal = colaborador.idSucursal;


---------SELECT PARA PROVEEDORES---------
SELECT * FROM proveedor;

---------SELECTS PARA PRODUCTOS---------
SELECT * FROM producto;

SELECT * FROM producto ORDER BY precio desc;

SELECT * FROM producto where precio BETWEEN 600 and 999;


---------SELECT PARA VENTAS---------
SELECT * FROM venta;


---------SELECT PARA INCIDENTES---------
SELECT * FROM incidente;


---------SELECT PARA SUCURSALES---------
SELECT * FROM sucursal;


---------SELECT PARA CATEGORIAS PRODUCTO---------
SELECT * FROM categoria_producto;





----------------------------UPDATES--------------------------------

-----UPDATES PRODUCTOS-------
UPDATE producto set precio=1550 where idProducto=1;
UPDATE colaborador set [status]=0 where idColaborador=2;
UPDATE producto set precio=600 where idProducto=3;


-----UPDATE VENTAS---------
update venta
set fechaRechazo = '2023-02-25',statusVenta = 5
where idVenta = 2;



-------------------------------DELETE-----------------------------------------

-----DELETE PRODUCTOS--------
DELETE producto where idProducto = 7;
DELETE clientes where lista_negra = 0 AND cliente_frecuente = 0;





-------------------------------TRUNCATE-----------------------------------------

-----TRUNCATE PAIS--------
TRUNCATE TABLE pais;

-----TRUNCATE COMPANIA--------
TRUNCATE TABLE compania;

-----TRUNCATE SUCURSAL--------
TRUNCATE TABLE sucursal;

-----TRUNCATE MONEDA--------
TRUNCATE TABLE moneda;

-----TRUNCATE COLABORADOR--------
TRUNCATE TABLE colaborador;

-----TRUNCATE CLIENTES--------
TRUNCATE TABLE clientes;

-----TRUNCATE CATEGORIA PRODUCTO--------
TRUNCATE TABLE categoria_producto;

-----TRUNCATE PROVEEDOR--------
TRUNCATE TABLE proveedor;

-----TRUNCATE PRODUCTO--------
TRUNCATE TABLE producto;

-----TRUNCATE VENTA--------
TRUNCATE TABLE venta;

-----TRUNCATE INCIDENTE--------
TRUNCATE TABLE incidente;





--------------------------------REPORTES GENERALES--------------------------------------
---------Reporte General de Colaboradores---------
SELECT * FROM colaborador;


---------Reporte General de Clientes---------
SELECT * FROM clientes;


---------Reporte General de Clientes Frecuentes---------
SELECT * FROM clientes
WHERE cliente_frecuente = 1;


---------Reporte General de Ventas Emitidas---------
CREATE VIEW ConsultaVentasEmitidas AS
SELECT venta.idVenta AS VENTA, venta.fechaEmision AS EMISION, venta.statusVenta AS ESTATUS, venta.idColaborador AS COLABORADOR, venta.idCliente AS CLIENTE, venta.idProducto AS PRODUCTO, venta.idMoneda AS MOENDA
FROM venta 
WHERE fechaRechazo is NULL

SELECT * FROM ConsultaVentasEmitidas


---------Reporte General de Ventas Anuladas---------
CREATE VIEW VENTASANULADAS as
SELECT venta.idVenta as #Venta, venta.fechaEmision as FechaDeEmision, venta.fechaRechazo as FechaRechazo, venta.statusVenta as Estado, colaborador.nombre as Colaborador,clientes.nombre as NombreCliente, producto.nombre as Producto, moneda.simbolo as Moneda
FROM venta, clientes,moneda,producto,colaborador
WHERE venta.idColaborador= colaborador.idColaborador and venta.idCliente = clientes.idCliente and venta.idMoneda = moneda.idMoneda and producto.idProducto = venta.idProducto and venta.statusVenta=5;

SELECT * FROM  VENTASANULADAS;


---------Reporte General de Ventas por Rango de Fecha---------
SELECT venta.idVenta, venta.fechaEmision, clientes.nombre
FROM venta 
INNER JOIN clientes ON venta.idCliente = clientes.idCliente
WHERE venta.fechaEmision BETWEEN '2022-01-01' AND '2023-01-31'


---------Histórico de Ventas---------
SELECT * FROM venta;


---------Histórico de Incidentes---------
SELECT * FROM incidente;





--------------------------------CREACION DE VIEWS - REPORTES ADICIONALES--------------------------------------

----------VIEW 1------------
CREATE VIEW ConsultaCompaniaPais AS
SELECT compania.nombre AS compania, pais.nombre AS pais
from compania, pais
WHERE compania.idPais=pais.idPais;

SELECT * FROM ConsultaCompaniaPais;

----------VIEW 2------------
CREATE VIEW ConsultaProductoSinNumeros AS 
SELECT producto.idProducto AS IdProducto, producto.nombre AS NOMBRE, categoria_producto.nombre AS CATEGORIA, producto.descripcion as DESCRIPCION, proveedor.nombreEmpresa as PROVEEDOR, moneda.simbolo as MONEDA, producto.precio as PRECIO
from producto, proveedor,moneda, categoria_producto
WHERE producto.idProveedor = proveedor.idProveedor AND producto.idMoneda = moneda.idMoneda AND  producto.idCategoria = categoria_producto.idCategoria;

SELECT * FROM ConsultaProductoSinNumeros;

DROP VIEW [ConsultaProductoSinNumeros];

----------VIEW 3------------
CREATE VIEW ColaboradorSucursal as
SELECT colaborador.nombre as Nombre, colaborador.primApellido as Apellido, sucursal.nombre as Sucursal
from colaborador, sucursal
where colaborador.idSucursal = sucursal.idSucursal;

SELECT * FROM ColaboradorSucursal;


----------VIEW 4------------
CREATE VIEW ProveedorProducto as
SELECT proveedor.idProveedor as IDProveedor, proveedor.nombreEmpresa as NombreEmpresa, producto.idProducto as IDProducto, producto.nombre as NombreProducto
from proveedor, producto
where proveedor.idProveedor = producto.idProveedor;

SELECT * from ProveedorProducto;

----------VIEW 5------------
CREATE VIEW ConsultaVentaProducto AS 
SELECT venta.idVenta AS #VENTA, venta.fechaEmision AS EMISION, venta.statusVenta AS ESTATUS, producto.idProducto AS #PRODUCTO, producto.nombre AS PRODUCTO, producto.descripcion AS DESCRIPCION, producto.precio AS PRECIO
FROM venta, producto
WHERE venta.idProducto = producto.idProducto;

SELECT * FROM ConsultaVentaProducto;

DROP VIEW ConsultaVentaProducto;





--------------------------------PROCEDURES--------------------------------------
------PROCEDURE 1-------
CREATE PROCEDURE insertCliente AS 
INSERT INTO clientes (nombre,primApellido,segApellido,direccion,telefono,email,cliente_frecuente,lista_negra,idPais)
values('Alejandro','Chavarria','Herandez','Cartago ,Condominio la Pelona','12345678','aleCH@gmail.com','TRUE','FALSE',1);
go

EXEC insertCliente;


-----PROCEDURE 2-------
CREATE PROCEDURE selectpersona AS
BEGIN
        SELECT * FROM clientes;
END;
go

EXEC selectpersona;





--------------------------------TRIGGERS--------------------------------------
-----TRIGGER 1-------
create trigger Consulta1
on proveedor
after insert
as
begin
 select * from proveedor;
end;
go

-----TRIGGER 2-------
create trigger Consulta2
on clientes
after insertCliente
as
begin
 select * from clientes;
end;
go

-----TRIGGER 3-------
create trigger Consulta3
on producto
after insert
as
begin
 select * from producto;
end;
go

-----TRIGGER 4-------
create trigger Consulta4
on colaborador
after insert
as
begin
 select * from colaborador;
end;
go

-----TRIGGER 5-------
create trigger Consulta5
on producto
after insert
as
begin
        SELECT producto.idProducto, categoria_producto.nombre, producto.descripcion, proveedor.nombreEmpresa, moneda.simbolo, producto.nombre, producto.precio 
        from producto 
        INNER JOIN proveedor on proveedor.idProveedor=producto.idProveedor 
        INNER JOIN moneda on moneda.idMoneda = producto.idMoneda
        INNER JOIN categoria_producto on categoria_producto.idCategoria=producto.idCategoria
end;
go


