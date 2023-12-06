DROP DATABASE IF EXISTS DonGalleto;
CREATE DATABASE DonGalleto;

use DonGalleto;

-- Crear la tabla de usuarios
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(255) NOT NULL,
    contrasenia VARCHAR(255) NOT NULL
);

-- Insertar algunos datos de ejemplo
INSERT INTO usuarios (nombre_usuario, contrasenia) VALUES
('Angel', 'Angelblanco123$'),
('admin', 'admin');
    
CREATE TABLE inventario_galleta(
id INT AUTO_INCREMENT PRIMARY KEY,
cantidad INT,
nombre VARCHAR(255),
descripcion VARCHAR(255),
fotografia longtext,
precio float,
peso float
);

create table Venta(
idVenta INT PRIMARY KEY AUTO_INCREMENT,
idGalleta INT NOT NULL,
precioGalleta INT NOT NULL,
nombreGalleta VARCHAR(255) NOT NULL,
cantidad INT NOT NULL,
tipo INT NOT NULL,
fecha VARCHAR(255) NOT NULL,

FOREIGN KEY (idGalleta) REFERENCES inventario_galleta(id)
);


CREATE TABLE materiaPrima (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    cantidad DOUBLE NOT NULL,
    unidad_medida VARCHAR(20) NOT NULL,
    proveedor VARCHAR(100),
    fecha_compra DATE,
    precio_unitario DECIMAL(10, 2),
    fotografia lONGTEXT,
    CONSTRAINT ck_cantidad CHECK (cantidad >= 0),
    CONSTRAINT ck_precio_unitario CHECK (precio_unitario >= 0)
);

INSERT INTO inventario_galleta (cantidad, nombre, descripcion,fotografia,precio,peso) VALUES
(10, 'Galleta de chocolate', 'Galleta de chocolate con textura suave, relleno delicioso',"", "100","5"),
(5, 'Galleta de fresa', 'Galleta de vainilla con textura suave, relleno delicioso',"","100","5"),
(15, 'Galleta de hallowen', 'Galleta conmemorativa de hallowen',"","100","10");
    
