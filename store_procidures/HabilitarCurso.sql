CREATE DEFINER=`root`@`%` PROCEDURE `HabilitarCurso`( IN pIdCurso INT, IN pCiclo VARCHAR(2), 
									IN pIdDocente INT, IN pCupo INT, 
									IN pSeccion CHAR(1) )
HabilitarCurso:BEGIN
	DECLARE encontrado INT DEFAULT 0;
	-- Primero validamos los datos
    SELECT COUNT(*) INTO encontrado FROM cursos WHERE idcurso = pIdCurso;
    
	IF encontrado = 0 THEN 
		SELECT 'El codigo de curso no existe' as Error; 
        LEAVE HabilitarCurso;
	END IF;
    IF NOT (pCiclo = '1S' OR pCiclo = '2S' OR pCiclo = 'VJ' OR pCiclo = 'VD') THEN
		SELECT 'El ciclo no es correcto' as Error; 
        LEAVE HabilitarCurso;
    END IF;
	IF pCupo <= 0 THEN 
		SELECT 'El cupo del curso no puede ser un numero negativo o 0' as Error; 
        LEAVE HabilitarCurso;
	END IF;
	-- Si el curso habilitado existe
    SET encontrado = 0;
    SELECT COUNT(*) INTO encontrado FROM cursos_habilitados WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion);
	IF encontrado > 0 THEN 
		SELECT 'Ya existe ese curso habilitado' as Error;
        LEAVE HabilitarCurso;
	END IF;
    
	INSERT INTO cursos_habilitados (idcurso, ciclo, iddocente, cupo, seccion)
	VALUES (pIdCurso, pCiclo, pIdDocente, pCupo, UPPER(pSeccion));
    
    SELECT 'Curso Habilitado Correctamente!' as Success;
    
END