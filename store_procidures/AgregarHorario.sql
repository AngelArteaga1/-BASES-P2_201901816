CREATE DEFINER=`root`@`%` PROCEDURE `AgregarHorario`(IN pIdCursoHabilitado INT, IN pDia INT, IN pHorario varchar(11))
AgregarHorario:BEGIN
	-- Primero validamos los datos
	IF pDia <= 0 or pDia > 7 THEN 
		SELECT 'Ese dia no esta dentro del rango adecuado' AS Error; 
		LEAVE AgregarHorario;
	END IF;
	
	-- Primero validamos los datos
	IF pHorario NOT REGEXP '^[0-9]+:[0-9]+\-[0-9]+:[0-9]+$' THEN 
		SELECT 'La cadena del horario no es correcta' AS Error; 
        LEAVE AgregarHorario;
	END IF;
	
	INSERT INTO horarios (idcurso_habilitado, dia, horario)
	VALUES (pIdCursoHabilitado, pDia, pHorario);
    
    SELECT 'Horario Asignado Correctamente!' AS Success;
END