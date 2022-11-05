CREATE DEFINER=`root`@`%` PROCEDURE `RegistrarEstudiante`(IN pCarnet BIGINT(10), IN pNombres VARCHAR(50), IN pApellidos VARCHAR(50), 
										IN pFechaNacimiento DATE, IN pCorreo VARCHAR(255), IN pTelefono BIGINT(8), 
                                        IN pDireccion VARCHAR(120), IN pDpi BIGINT(16), IN pidCarrera INT)
RegistrarEstudiante:BEGIN
	-- Primero validamos los datos
	IF pNombres NOT REGEXP '^[a-zA-Z ]*$' THEN 
		SELECT 'La cadena del nombre no es correcta' as Error; 
        LEAVE RegistrarEstudiante;
	END IF;
	IF pApellidos NOT REGEXP '^[a-zA-Z ]*$' THEN 
		SELECT 'La cadena del nombre no es correcta' as Error; 
        LEAVE RegistrarEstudiante;
	END IF;
	IF pCorreo NOT REGEXP '^[^@]+@[^@]+\.[^@]{2,}$' THEN 
		SELECT 'La cadena del correo no es correcta' as Error; 
        LEAVE RegistrarEstudiante;
	END IF;
    
	INSERT INTO estudiantes (carnet, nombres, apellidos, fechanacimiento, correo, telefono, direccion, dpi, creditos, fechacreacion, idcarrera)
	VALUES (pCarnet, pNombres, pApellidos, pFechaNacimiento, pCorreo, pTelefono, pDireccion, pDpi, 0, NOW(), pidCarrera);
    
    SELECT 'Estudiante Registrado Correctamente!' as Success;
END