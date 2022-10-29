CREATE DEFINER=`root`@`%` PROCEDURE `CrearCurso`(	IN pIdCurso INT, IN pNombre VARCHAR(50), 
								IN pCreditosNecesarios INT, IN pCreditosOtorgados INT, 
                                IN pObligatorio BOOL, IN pIdCarrera INT )
CrearCurso:BEGIN
	-- Primero validamos los datos
	IF pCreditosNecesarios < 0 THEN 
		SELECT 'Los creditos necesarios no pueden ser negativos' as Error; 
        LEAVE CrearCurso;
	END IF;
	IF pCreditosOtorgados < 0 THEN 
		SELECT 'Los creditos que otorga el curso no pueden ser negativos' as Error; 
        LEAVE CrearCurso;
	END IF;
    
	INSERT INTO cursos (idcurso, nombre, creditosnecesarios, creditosotorgados, obligatorio, idcarrera)
	VALUES (pIdCurso, pNombre, pCreditosNecesarios, pCreditosOtorgados, pObligatorio, pIdCarrera);
    
    SELECT 'Curso Creado Correctamente!' as Success;
END