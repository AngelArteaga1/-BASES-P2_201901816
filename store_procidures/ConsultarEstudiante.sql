CREATE DEFINER=`root`@`%` PROCEDURE `ConsultarEstudiante`(IN pCarnet BIGINT(10))
ConsultarEstudiantes:BEGIN
	DECLARE encontrado INT DEFAULT 0;
	-- Primero validamos los datos
    -- Si el estudiante existe
    SELECT COUNT(*) INTO encontrado FROM estudiantes WHERE carnet = pCarnet;
	IF encontrado = 0 THEN 
		SELECT 'El carnet de estudiante no existe' as Error; 
        LEAVE ConsultarEstudiantes;
	END IF;
    
    -- Ahora realizamos el select
	SELECT 
		estudiantes.carnet as 'Carnet',
        CONCAT(estudiantes.nombres, " ", estudiantes.apellidos) as 'Nombre completo',
        estudiantes.fechanacimiento as 'Fecha de nacimiento',
        estudiantes.correo as 'Correo',
        estudiantes.telefono as 'Telefóno',
        estudiantes.direccion as 'Direccion',
        estudiantes.dpi as 'Numero de DPI',
        carreras.nombre as 'Carrera',
        estudiantes.creditos as 'Creditos que Posee'
	FROM
		estudiantes,
        carreras
	WHERE
		estudiantes.idcarrera = carreras.idcarrera AND
		estudiantes.carnet = pCarnet;
END