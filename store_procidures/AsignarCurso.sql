CREATE DEFINER=`root`@`%` PROCEDURE `AsignarCurso`( IN pIdCurso INT, IN pCiclo VARCHAR(2), 
								  IN pSeccion CHAR(1), IN pCarnet BIGINT(10))
AsignarCurso:BEGIN

	DECLARE encontrado INT DEFAULT 0;
	-- Primero validamos los datos
    -- Si el estudiante existe
    SELECT COUNT(*) INTO encontrado FROM estudiantes WHERE carnet = pCarnet;
	IF encontrado = 0 THEN 
		SELECT 'El carnet de estudiante no existe' as Error; 
        LEAVE AsignarCurso;
	END IF;
	-- Si el ciclo es el correcto
    IF NOT (pCiclo = '1S' OR pCiclo = '2S' OR pCiclo = 'VJ' OR pCiclo = 'VD') THEN
		SELECT 'El ciclo no es correcto' as Error; 
        LEAVE AsignarCurso;
    END IF;
    -- Si el curso habilitado existe
    SET encontrado = 0;
    SELECT COUNT(*) INTO encontrado FROM cursos_habilitados WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion);
	IF encontrado = 0 THEN 
		SELECT 'No existe ese curso habilitado' as Error;
        LEAVE AsignarCurso;
	END IF;
    -- Si el estudiante ya se encuentra asignado
	SET encontrado = 0;
    SELECT COUNT(*) INTO encontrado FROM asignaciones WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion) AND carnet = pCarnet AND status = true;
	IF encontrado > 0 THEN 
		SELECT 'El estudiante ya se encuentra asignado' as Error;
        LEAVE AsignarCurso;
	END IF;
    -- Si el estudiante se habia desasignado y se volvio a asignar
	SET encontrado = 0;
    SELECT COUNT(*) INTO encontrado FROM asignaciones WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion) AND carnet = pCarnet AND status = false;
	IF encontrado > 0 THEN 
		UPDATE asignaciones
		SET status = true
		WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion) AND carnet = pCarnet;
		SELECT 'Estudiante Asignado Correctamente!' as Success;
        LEAVE AsignarCurso;
	END IF;
    
	INSERT INTO asignaciones (idcurso, ciclo, seccion, carnet, status)
	VALUES (pIdCurso, pCiclo, pSeccion, pCarnet, true);
    
    SELECT 'Estudiante Asignado Correctamente!' as Success;
END