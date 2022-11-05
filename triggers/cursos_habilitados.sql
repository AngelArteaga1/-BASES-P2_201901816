CREATE DEFINER=`root`@`%` TRIGGER `db_bases2_usac`.`cursos_habilitados_AFTER_INSERT` AFTER INSERT ON `cursos_habilitados` FOR EACH ROW
BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "CURSOS_HABILITADOS"', 'INSERT');
END

CREATE DEFINER=`root`@`%` TRIGGER `db_bases2_usac`.`cursos_habilitados_AFTER_UPDATE` AFTER UPDATE ON `cursos_habilitados` FOR EACH ROW
BEGIN
	DECLARE xcreditos INT DEFAULT 0;
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "CURSOS_HABILITADOS"', 'UPDATE');
    -- Agregamos los creditos a la gente
    IF OLD.actagenerada = false AND NEW.actagenerada = true THEN
		-- Obtenemos los creditos del curso
		SELECT creditosotorgados INTO xcreditos FROM cursos WHERE idcurso = NEW.idcurso;
        
        -- Ingresamos el los creditos a los estudiantes
		UPDATE estudiantes
        INNER JOIN asignaciones ON asignaciones.carnet = estudiantes.carnet
        SET estudiantes.creditos = estudiantes.creditos + xcreditos 
        WHERE 
			asignaciones.idcurso = NEW.idcurso AND
			asignaciones.seccion = NEW.seccion AND
            asignaciones.ciclo = NEW.ciclo AND
            asignaciones.status = true;
	END IF;
END

CREATE DEFINER=`root`@`%` TRIGGER `db_bases2_usac`.`cursos_habilitados_AFTER_DELETE` AFTER DELETE ON `cursos_habilitados` FOR EACH ROW
BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "CURSOS_HABILITADOS"', 'DELETE');
END