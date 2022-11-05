CREATE DEFINER=`root`@`%` PROCEDURE `IngresarNota`(IN pIdCurso INT, IN pCiclo VARCHAR(2), 
								 IN pSeccion CHAR(1), IN pCarnet BIGINT(10), IN pNota INT)
IngresarNota:BEGIN
	DECLARE encontrado INT DEFAULT 0;
	-- Primero validamos los datos
    -- Si el estudiante existe
    SELECT COUNT(*) INTO encontrado FROM estudiantes WHERE carnet = pCarnet;
	IF encontrado = 0 THEN 
		SELECT 'El carnet de estudiante no existe' as Error; 
        LEAVE IngresarNota;
	END IF;
	-- Si el ciclo es el correcto
    IF NOT (pCiclo = '1S' OR pCiclo = '2S' OR pCiclo = 'VJ' OR pCiclo = 'VD') THEN
		SELECT 'El ciclo no es correcto' as Error; 
        LEAVE IngresarNota;
    END IF;
	-- Si el curso habilitado existe
    SET encontrado = 0;
    SELECT COUNT(*) INTO encontrado FROM cursos_habilitados WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion);
	IF encontrado = 0 THEN 
		SELECT 'No existe ese curso habilitado' as Error;
        LEAVE IngresarNota;
	END IF;
	-- Si el estudiante no se encuentra asignado
	SET encontrado = 0;
    SELECT COUNT(*) INTO encontrado FROM asignaciones WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion) AND carnet = pCarnet AND status = true;
	IF encontrado = 0 THEN 
		SELECT 'El estudiante no se encuentra asignado' as Error;
        LEAVE IngresarNota;
	END IF;
    -- Si la nota no es un numero positivo
	IF pNota < 0 OR pNota > 100 THEN 
		SELECT 'La nota no esta dentro del rango de notas' as Error; 
        LEAVE IngresarNota;
	END IF;
    
    -- AHORA YA INGRESAMOS LA NOTA!
	UPDATE asignaciones
	SET nota = pNota
	WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion) AND carnet = pCarnet AND status = true;
    
    SELECT 'Nota ingresada Correctamente!' as Success;
END