CREATE DEFINER=`root`@`%` PROCEDURE `GenerarActa`(IN pIdCurso INT, IN pCiclo VARCHAR(2), IN pSeccion CHAR(1))
GenerarActa:BEGIN
	DECLARE encontrado INT DEFAULT 0;
    DECLARE notasingresadas INT DEFAULT 0;
    DECLARE numeroasignaciones INT DEFAULT 0;
	-- Si el ciclo es el correcto
    IF NOT (pCiclo = '1S' OR pCiclo = '2S' OR pCiclo = 'VJ' OR pCiclo = 'VD') THEN
		SELECT 'El ciclo no es correcto' as Error; 
        LEAVE GenerarActa;
    END IF;
	-- Primero debemos verificar si existe el curso
    SET encontrado = 0;
    SELECT COUNT(*) INTO encontrado FROM cursos_habilitados WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion);
	IF encontrado = 0 THEN 
		SELECT 'No existe ese curso habilitado' as Error;
        LEAVE GenerarActa;
	END IF;
    -- Ahora verificamos si todos los estudiantes tienen nota
    SELECT COUNT(*) INTO notasingresadas 
    FROM asignaciones 
    WHERE 
		idcurso = pIdCurso AND 
        ciclo = pCiclo AND 
        seccion = UPPER(pSeccion) AND 
        status = true AND 
        nota IS NOT NULL;
    SELECT COUNT(*) INTO numeroasignaciones 
    FROM asignaciones 
    WHERE 
		idcurso = pIdCurso AND 
        ciclo = pCiclo AND 
        seccion = UPPER(pSeccion) AND
        status = true;
	IF notasingresadas < numeroasignaciones THEN 
		SELECT 'No ha ingresado todas las notas de curso' as Error, notasingresadas as notasingresadas, numeroasignaciones as asignaciones;
        LEAVE GenerarActa;
	END IF;
    
    -- AHORA YA ACTUALIZAMOS
	UPDATE cursos_habilitados
	SET actagenerada = true, fechaacta = NOW()
	WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion);
    
    SELECT 'Acta Generada Correctamente!' as Success;
END