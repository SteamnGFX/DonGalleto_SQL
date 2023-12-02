create database DonGalleto;

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
precio float
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

INSERT INTO inventario_galleta (cantidad, nombre, descripcion,fotografia,precio) VALUES
(10, 'Galleta de chocolate', 'Galleta de chocolate con textura suave, relleno delicioso',"", "100"),
(5, 'Galleta de fresa', 'Galleta de vainilla con textura suave, relleno delicioso',"","100"),
(15, 'Galleta de hallowen', 'Galleta conmemorativa de hallowen',"","100");
    
