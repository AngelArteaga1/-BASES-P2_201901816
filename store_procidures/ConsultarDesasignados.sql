CREATE DEFINER=`root`@`%` PROCEDURE `ConsultarDesasignacion`(IN pIdCurso INT, IN pCiclo VARCHAR(2), IN pAnio INT, IN pSeccion VARCHAR(1))
ConsultarDesasignacion:BEGIN
	DECLARE encontrado INT DEFAULT 0;
	-- Si el ciclo es el correcto
    IF NOT (pCiclo = '1S' OR pCiclo = '2S' OR pCiclo = 'VJ' OR pCiclo = 'VD') THEN
		SELECT 'El ciclo no es correcto' as Error; 
        LEAVE ConsultarDesasignacion;
    END IF;
    -- Si la seccion es mayuscula
	IF pSeccion NOT REGEXP BINARY '^[A-Z]$' THEN 
		SELECT 'La cadena de la seccion no es correcta' as Error; 
        LEAVE ConsultarDesasignacion;
	END IF;
	-- Primero debemos verificar si existe el curso
    SET encontrado = 0;
    SELECT COUNT(*) INTO encontrado FROM cursos_habilitados WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion);
	IF encontrado = 0 THEN 
		SELECT 'No existe ese curso habilitado' as Error;
        LEAVE ConsultarDesasignacion;
	END IF;
    
	-- Ahora realizamos el select
	SELECT 
		asignaciones.idcurso as 'Codigo de curso',
        asignaciones.seccion as 'Seccion',
		CASE
			WHEN asignaciones.ciclo = '1S' THEN 'PRIMER SEMESTRE'
			WHEN asignaciones.ciclo = '2S' THEN 'SEGUNDO SEMESTRE'
            WHEN asignaciones.ciclo = 'VJ' THEN 'VACACIONES DE JUNIO'
			ELSE 'VACACIONES DE DICIEMBRE'
		END as 'Ciclo',
        cursos_habilitados.anio as 'Año',
        count(CASE WHEN asignaciones.status = true THEN 1 END) as 'Cantidad de asignaciones totales',
        count(CASE WHEN asignaciones.status = false THEN 1 END) as 'Cantidad de desasignaciones',
        (count(CASE WHEN asignaciones.status = false THEN 1 END) * 100) / count(*) as 'Porcentaje de desasignacion'
	FROM
		asignaciones,
        cursos_habilitados
	WHERE
		asignaciones.idcurso = pIdcurso AND
        asignaciones.ciclo = pCiclo AND
        asignaciones.seccion = pSeccion AND
        asignaciones.idcurso = cursos_habilitados.idcurso AND
        asignaciones.seccion = cursos_habilitados.seccion AND
        asignaciones.ciclo = cursos_habilitados.ciclo AND
        cursos_habilitados.anio = PAnio;
END