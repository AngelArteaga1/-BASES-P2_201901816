CREATE DEFINER=`root`@`%` TRIGGER `db_bases2_usac`.`horarios_AFTER_INSERT` AFTER INSERT ON `horarios` FOR EACH ROW
BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "HORARIOS"', 'INSERT');
END

CREATE DEFINER=`root`@`%` TRIGGER `db_bases2_usac`.`horarios_AFTER_UPDATE` AFTER UPDATE ON `horarios` FOR EACH ROW
BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "HORARIOS"', 'UPDATE');
END

CREATE DEFINER=`root`@`%` TRIGGER `db_bases2_usac`.`horarios_AFTER_DELETE` AFTER DELETE ON `horarios` FOR EACH ROW
BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "HORARIOS"', 'DELETE');
END