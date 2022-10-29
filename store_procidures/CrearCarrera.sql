CREATE DEFINER=`root`@`%` PROCEDURE `CrearCarrera`(IN pNombre VARCHAR(100))
CrearCarrera:BEGIN
	-- Primero validamos si la cadena es correcta
	IF pNombre NOT REGEXP '^[a-zA-Z ]*$' THEN 
		SELECT 'La cadena del nombre no es correcta' as Error; 
        LEAVE CrearCarrera;
	END IF;

	INSERT INTO carreras (nombre)
	VALUES (pNombre);
    
    SELECT 'Carrera Agregada Correctamente!' as Success;
END