CREATE DEFINER=`root`@`%` PROCEDURE `ConsultarPensum`(IN pIdcarrera INT)
BEGIN
	SELECT 
		idcurso as 'Codigo de curso',
        nombre as 'Nombre del curso',
        CASE
			WHEN obligatorio = true THEN 'Si'
			ELSE 'No'
		END as 'Es obligatorio',
        creditosnecesarios as 'Creditos necesarios'
	FROM
		cursos
	WHERE
		idcarrera = pIdcarrera OR idcarrera = 0;
END