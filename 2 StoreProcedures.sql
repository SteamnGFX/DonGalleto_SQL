-- StoreProcedure para iniciar sesion

DELIMITER //

CREATE PROCEDURE obtener_usuario(
    IN p_usuario VARCHAR(255),
    IN p_contrasenia VARCHAR(255)
)
BEGIN
    DECLARE usuario_encontrado INT;
    
    -- Verificar si las credenciales coinciden
SELECT 
    COUNT(*)
INTO usuario_encontrado FROM
    usuarios
WHERE
    nombre_usuario = p_usuario
        AND contrasenia = p_contrasenia;

    -- Devolver el resultado
    IF usuario_encontrado > 0 THEN
        SELECT *
        FROM usuarios
        WHERE nombre_usuario = p_usuario AND contrasenia = p_contrasenia;
    ELSE
        SELECT '-10' AS id;
    END IF;
END //

DELIMITER ;


-- StoreProcedure de Insertar galleta 

DELIMITER //
CREATE PROCEDURE InsertarGalleta(
    IN p_cantidad INT,
    IN p_nombre VARCHAR(255),
    IN p_descripcion VARCHAR(255),
    IN p_fotografia LONGTEXT,
    iN p_precio FLOAT,
    iN p_peso FLOAT,
    OUT p_id_generado INT
)
BEGIN
    INSERT INTO inventario_galleta (cantidad, nombre, descripcion, fotografia, precio,peso)
    VALUES (p_cantidad, p_nombre, p_descripcion, p_fotografia, p_precio, p_peso);

    -- Obtener el ID generado y asignarlo al parámetro de salida
    SET p_id_generado = LAST_INSERT_ID();
END //
DELIMITER ;

-- Actualizar Galleta
DELIMITER //
CREATE PROCEDURE ActualizarGalleta(
    IN p_id_galleta INT,
    IN p_cantidad INT,
    IN p_nombre VARCHAR(255),
    IN p_descripcion VARCHAR(255),
    IN p_fotografia LONGTEXT,
    IN p_precio FLOAT,
    IN p_peso FLOAT
)
BEGIN
    UPDATE inventario_galleta
    SET
        cantidad = p_cantidad,
        nombre = p_nombre,
        descripcion = p_descripcion,
        fotografia = p_fotografia,
        precio = p_precio,
        peso = p_peso
    WHERE id = p_id_galleta;
END //
DELIMITER ;


-- StoreProcedure de Eliminar galleta 
DELIMITER //
CREATE PROCEDURE EliminarGalleta(
    IN p_id_galleta INT
)
BEGIN
    DELETE FROM inventario_galleta
    WHERE
        id = p_id_galleta;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE insertarVenta(
    IN p_idGalleta INT,
    IN p_precioGalleta INT,
    IN p_nombreGalleta VARCHAR(255) ,
    IN p_cantidad INT,
    IN p_tipo INT,
    IN p_fecha VARCHAR(255),
    
    OUT p_idVentaGenerada INT
)
BEGIN
    INSERT INTO Venta (idGalleta, precioGalleta, nombreGalleta, cantidad, tipo, fecha)
    VALUES (p_idGalleta, p_precioGalleta, p_nombreGalleta, p_cantidad, p_tipo, p_fecha);
    
    SELECT LAST_INSERT_ID() AS last_id; -- Devuelve el último ID generado
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER DescontarInventarioGalleta
AFTER INSERT ON Venta
FOR EACH ROW
BEGIN
    DECLARE galletaCantidad INT;

    -- Obtener la cantidad de la galleta en inventario_galleta
    SELECT cantidad INTO galletaCantidad
    FROM inventario_galleta
    WHERE id = NEW.idGalleta;

    -- Reducir la cantidad en inventario_galleta
    UPDATE inventario_galleta
    SET cantidad = galletaCantidad - NEW.cantidad
    WHERE id = NEW.idGalleta;
END //
DELIMITER ;

-- StoreProcedure de insertar materia 
DELIMITER //
CREATE PROCEDURE insertarMateria(
    IN p_cantidad Double,
    IN p_nombre VARCHAR(255),
    IN p_unidadMedida VARCHAR(255),
    IN p_proveedor varchar (15),
    IN p_precio_unitario double,
    IN p_fecha_compra date,
    IN p_fotografia LONGTEXT,
    OUT p_id_generado INT
)
BEGIN
	INSERT INTO materiaPrima (nombre, cantidad, unidad_medida, proveedor, fecha_compra, precio_unitario, fotografia)
    VALUES (p_nombre, p_cantidad, p_unidadMedida, p_proveedor, p_fecha_compra, p_precio_unitario,  p_fotografia);

    -- Obtener el ID generado y asignarlo al parámetro de salida
    SET p_id_generado = LAST_INSERT_ID();
END //
DELIMITER ;
-- StoreProcedure de actualizar materia 

DELIMITER //
CREATE PROCEDURE modificarMateria(
    IN p_id INT,
    IN p_cantidad Double,
    IN p_nombre VARCHAR(255),
    IN p_unidadMedida VARCHAR(255),
    IN p_proveedor varchar (15),
    IN p_precio_unitario double,
    IN p_fecha_compra date,
    IN p_fotografia LONGTEXT
)
BEGIN
    UPDATE materiaPrima
    SET
        cantidad = p_cantidad,
        nombre = p_nombre,
        unidad_medida = p_unidadMedida,
        proveedor = p_proveedor,
        precio_unitario = p_precio_unitario,
        fecha_compra = p_fecha_compra,
        fotografia = p_fotografia
    WHERE
        id = p_id;
END //
DELIMITER ;
-- StoreProcedure de eliminar materia 

DELIMITER //
CREATE PROCEDURE eliminarMateria(
    IN p_id INT
)
BEGIN
    DELETE FROM materiaPrima
    WHERE id = p_id;
END //
DELIMITER ;
