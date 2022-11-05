CREATE DEFINER=`root`@`%` PROCEDURE `ConsultarAprobaciones`(IN pIdCurso INT, IN pCiclo VARCHAR(2), IN pAnio INT, IN pSeccion VARCHAR(1))
ConsultarAprobaciones:BEGIN
	DECLARE encontrado INT DEFAULT 0;
	-- Si el ciclo es el correcto
    IF NOT (pCiclo = '1S' OR pCiclo = '2S' OR pCiclo = 'VJ' OR pCiclo = 'VD') THEN
		SELECT 'El ciclo no es correcto' as Error; 
        LEAVE ConsultarAprobaciones;
    END IF;
    -- Si la seccion es mayuscula
	IF pSeccion NOT REGEXP BINARY '^[A-Z]$' THEN 
		SELECT 'La cadena de la seccion no es correcta' as Error; 
        LEAVE ConsultarAprobaciones;
	END IF;
	-- Primero debemos verificar si existe el curso
    SET encontrado = 0;
    SELECT COUNT(*) INTO encontrado FROM cursos_habilitados WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion);
	IF encontrado = 0 THEN 
		SELECT 'No existe ese curso habilitado' as Error;
        LEAVE ConsultarAprobaciones;
	END IF;
    
    -- Ahora realizamos el select
	SELECT 
		asignaciones.idcurso as 'Codigo de curso',
        asignaciones.carnet as 'Carnet',
        CONCAT(estudiantes.nombres, " ", estudiantes.apellidos) as 'Nombre completo',
        estudiantes.creditos as 'Creditos que posee',
        CASE
			WHEN asignaciones.nota > 60 THEN 'APROBADO'
			ELSE 'DESAPROBADO'
		END as 'Aprobado / Desaprobado'
	FROM
		asignaciones,
        estudiantes,
        cursos_habilitados
	WHERE
		asignaciones.idcurso = pIdcurso AND
        asignaciones.ciclo = pCiclo AND
        asignaciones.seccion = pSeccion AND
        asignaciones.carnet = estudiantes.carnet AND
        asignaciones.status = true AND
		asignaciones.idcurso = cursos_habilitados.idcurso AND
        asignaciones.seccion = cursos_habilitados.seccion AND
        asignaciones.ciclo = cursos_habilitados.ciclo AND
        cursos_habilitados.anio = PAnio;
END