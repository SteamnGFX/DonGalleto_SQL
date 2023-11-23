-- StoreProcedure para iniciar sesion

DELIMITER //

CREATE PROCEDURE obtener_usuario(
    IN p_usuario VARCHAR(255),
    IN p_contrasenia VARCHAR(255)
)
BEGIN
    DECLARE usuario_encontrado INT;
    
    -- Verificar si las credenciales coinciden
    SELECT COUNT(*) INTO usuario_encontrado
    FROM usuarios
    WHERE nombre_usuario = p_usuario AND contrasenia = p_contrasenia;

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
    OUT p_id_generado INT
)
BEGIN
    INSERT INTO inventario_galleta (cantidad, nombre, descripcion, fotografia)
    VALUES (p_cantidad, p_nombre, p_descripcion, p_fotografia);

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
    IN p_fotografia LONGTEXT
)
BEGIN
    UPDATE inventario_galleta
    SET
        cantidad = p_cantidad,
        nombre = p_nombre,
        descripcion = p_descripcion,
        fotografia = p_fotografia
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
