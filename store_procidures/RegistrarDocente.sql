CREATE DEFINER=`root`@`%` PROCEDURE `RegistrarDocente`(IN pNombres VARCHAR(50), IN pApellidos VARCHAR(50), 
										IN pFechaNacimiento DATE, IN pCorreo VARCHAR(255), IN pTelefono BIGINT(8), 
                                        IN pDireccion VARCHAR(120), IN pDpi BIGINT(16), IN pRegistroSIIF INT)
RegistrarDocente:BEGIN
	-- Primero validamos los datos
	IF pCorreo NOT REGEXP '^[^@]+@[^@]+\.[^@]{2,}$' THEN 
		SELECT 'La cadena del correo no es correcta' as Error; 
        LEAVE RegistrarDocente;
	END IF;
    
	INSERT INTO docentes (nombres, apellidos, fechanacimiento, correo, telefono, direccion, dpi, fechacreacion, registrosiif)
	VALUES (pNombres, pApellidos, pFechaNacimiento, pCorreo, pTelefono, pDireccion, pDpi, NOW(), pRegistroSIIF);
    
    SELECT 'Docente Registrado Correctamente!' as Success;
END