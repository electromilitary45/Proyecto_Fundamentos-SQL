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
        pais_id INT NOT NULL,
        FOREIGN KEY (pais_id) REFERENCES pais(idPais)
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
        status INT NOT NULL DEFAULT 1,
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
        precio DECIMAL(10, 2) NOT NULL,
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
