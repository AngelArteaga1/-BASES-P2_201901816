CREATE DEFINER=`root`@`%` PROCEDURE `ConsultarDocente`(IN pRegistroSIIF BIGINT(11))
ConsultarDocente:BEGIN
	DECLARE encontrado INT DEFAULT 0;
	-- Primero validamos los datos
    -- Si el estudiante existe
    SELECT COUNT(*) INTO encontrado FROM docentes WHERE registrosiif = pRegistroSIIF;
	IF encontrado = 0 THEN 
		SELECT 'El Registro SIIF del docente no existe' as Error; 
        LEAVE ConsultarDocente;
	END IF;
    
    -- Ahora realizamos el select
	SELECT 
		docentes.registrosiif as 'Registro SIIF',
        CONCAT(docentes.nombres, " ", docentes.apellidos) as 'Nombre completo',
        docentes.fechanacimiento as 'Fecha de nacimiento',
        docentes.correo as 'Correo',
        docentes.telefono as 'Telefóno',
        docentes.direccion as 'Direccion',
        docentes.dpi as 'Numero de DPI'
	FROM
		docentes
	WHERE
		docentes.registrosiif = pRegistroSIIF;
END