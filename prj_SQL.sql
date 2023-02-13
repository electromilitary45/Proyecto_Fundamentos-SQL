-- comandos princiapales
use master
go -- creacion base datos
        create database bd_DeliFood -- creacion de tablas
        use bd_DeliFood


        -- Estructura de la tabla "pais"
        CREATE TABLE pais (
                id INT AUTO_INCREMENT PRIMARY KEY,
                nombre VARCHAR(100) NOT NULL
        );
-- Estructura de la tabla "compania"
CREATE TABLE compania (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        pais_id INT NOT NULL,
        FOREIGN KEY (pais_id) REFERENCES pais(id)
);
-- Estructura de la tabla "sucursal"
CREATE TABLE sucursal (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        direccion VARCHAR(200) NOT NULL,
        compania_id INT NOT NULL,
        pais_id INT NOT NULL,
        FOREIGN KEY (compania_id) REFERENCES compania(id),
        FOREIGN KEY (pais_id) REFERENCES pais(id)
);
-- Estructura de la tabla "moneda"
CREATE TABLE moneda (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        simbolo VARCHAR(10) NOT NULL,
        pais_id INT NOT NULL,
        FOREIGN KEY (pais_id) REFERENCES pais(id)
);
-- Estructura de la tabla "empleado"
CREATE TABLE empleado (
        id INT AUTO_INCREMENT PRIMARY KEY,
        status INT NOT NULL DEFAULT 1,
        nombre VARCHAR(100) NOT NULL,
        apellido VARCHAR(100) NOT NULL,
        puesto VARCHAR(100) NOT NULL,
        salario DECIMAL(10, 2) NOT NULL,
        moneda_id INT NOT NULL,
        sucursal_id INT NOT NULL,
        FOREIGN KEY (moneda_id) REFERENCES moneda(id),
        FOREIGN KEY (sucursal_id) REFERENCES sucursal(id)
);

CREATE TABLE clientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  direccion VARCHAR(255) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  email VARCHAR(255) NOT NULL,
  cliente_frecuente BOOLEAN NOT NULL DEFAULT FALSE,
  lista_negra BOOLEAN NOT NULL DEFAULT FALSE,
  status int NOT NULL DEFAULT 1,
  id_pais INT NOT NULL,
  id_compania INT NOT NULL,
  id_sucursal INT NOT NULL,
  id_moneda INT NOT NULL,
  FOREIGN KEY (id_pais) REFERENCES paises(id),
  FOREIGN KEY (id_compania) REFERENCES compañias(id),
  FOREIGN KEY (id_sucursal) REFERENCES sucursales(id),
  FOREIGN KEY (id_moneda) REFERENCES monedas(id)
);

-- Estructura de la tabla "categoria_producto"
CREATE TABLE categoria_producto (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        descripcion VARCHAR(200) NOT NULL
);
-- Estructura de la tabla "producto"
CREATE TABLE producto (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        descripcion VARCHAR(200) NOT NULL,
        precio DECIMAL(10, 2) NOT NULL,
        moneda_id INT NOT NULL,
        categoria_id INT NOT NULL,
        FOREIGN KEY (moneda_id) REFERENCES moneda(id),
        FOREIGN KEY (categoria_id) REFERENCES categoria_producto(id)