CREATE TABLE sucursal (
        idSucursal INT Identity (1,1) PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        direccion VARCHAR(200) NOT NULL,
        compania_id INT NOT NULL,
        pais_id INT NOT NULL,
        FOREIGN KEY (compania_id) REFERENCES compania(idCompania),
        FOREIGN KEY (pais_id) REFERENCES pais(idPais)
);

INSERT INTO sucursal(nombre,direccion,compania_id,pais_id)
VALUES('Sucursal 1','Washington',1,1)