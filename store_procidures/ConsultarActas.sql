CREATE DEFINER=`root`@`%` PROCEDURE `ConsultarActas`(IN pIdcurso INT)
ConsultarActas:BEGIN
	DECLARE encontrado INT DEFAULT 0;
	-- Primero debemos verificar si existe el curso
    SELECT COUNT(*) INTO encontrado FROM cursos WHERE idcurso = pIdCurso;
	IF encontrado = 0 THEN 
		SELECT 'No existe ese curso' as Error;
        LEAVE ConsultarActas;
	END IF;
    
    -- Ahora realizamos el select
    SELECT
	cursos_habilitados.idcurso as 'Codigo de curso',
        cursos_habilitados.seccion as 'Seccion',
        CASE
			WHEN cursos_habilitados.ciclo = '1S' THEN 'PRIMER SEMESTRE'
			WHEN cursos_habilitados.ciclo = '2S' THEN 'SEGUNDO SEMESTRE'
            WHEN cursos_habilitados.ciclo = 'VJ' THEN 'VACACIONES DE JUNIO'
			ELSE 'VACACIONES DE DICIEMBRE'
		END as 'Ciclo',
        cursos_habilitados.anio as 'Año',
        count(asignaciones.carnet) as 'Cantidad de Estudiantes',
        cursos_habilitados.fechaacta as 'Fecha de generada'
	FROM 
		cursos_habilitados,
        asignaciones
	WHERE
		cursos_habilitados.actagenerada = true AND
        cursos_habilitados.idcurso = asignaciones.idcurso AND
        cursos_habilitados.seccion = asignaciones.seccion AND
        cursos_habilitados.ciclo = asignaciones.ciclo 
	GROUP BY cursos_habilitados.idcurso_habilitado
    ORDER BY cursos_habilitados.fechaacta DESC;
END