CREATE DEFINER=`root`@`%` TRIGGER `db_bases2_usac`.`estudiantes_AFTER_INSERT` AFTER INSERT ON `estudiantes` FOR EACH ROW
BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "ESTUDIANTES"', 'INSERT');
END

CREATE DEFINER=`root`@`%` TRIGGER `db_bases2_usac`.`estudiantes_AFTER_UPDATE` AFTER UPDATE ON `estudiantes` FOR EACH ROW
BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "ESTUDIANTES"', 'UPDATE');
END

CREATE DEFINER=`root`@`%` TRIGGER `db_bases2_usac`.`estudiantes_AFTER_DELETE` AFTER DELETE ON `estudiantes` FOR EACH ROW
BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "ESTUDIANTES"', 'DELETE');
END