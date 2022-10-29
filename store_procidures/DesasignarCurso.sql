CREATE DEFINER=`root`@`%` PROCEDURE `DesasignarCurso`(IN pIdCurso INT, IN pCiclo VARCHAR(2), 
									IN pSeccion CHAR(1), IN pCarnet BIGINT(10))
DesasignarCurso:BEGIN
	DECLARE encontrado INT DEFAULT 0;
    SELECT COUNT(*) 
    INTO encontrado 
    FROM asignaciones 
    WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion) AND carnet = pCarnet AND status = true;
	IF encontrado = 0 THEN 
		SELECT 'El estudiante no se encuentra asignado' as Error;
        LEAVE DesasignarCurso;
	END IF;
    UPDATE asignaciones
	SET status = false, fechadesasignacion = NOW()
	WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion) AND carnet = pCarnet;
    SELECT 'Estudiante Desasignado Correctamente!' as Success;
END