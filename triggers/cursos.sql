CREATE DEFINER=`root`@`%` TRIGGER `db_bases2_usac`.`cursos_AFTER_INSERT` AFTER INSERT ON `cursos` FOR EACH ROW
BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "CURSOS"', 'INSERT');
END

CREATE DEFINER=`root`@`%` TRIGGER `db_bases2_usac`.`cursos_AFTER_UPDATE` AFTER UPDATE ON `cursos` FOR EACH ROW
BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "CURSOS"', 'UPDATE');
END

CREATE DEFINER=`root`@`%` TRIGGER `db_bases2_usac`.`cursos_AFTER_DELETE` AFTER DELETE ON `cursos` FOR EACH ROW
BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "CURSOS"', 'DELETE');
END