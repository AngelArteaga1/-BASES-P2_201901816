CREATE DEFINER=`root`@`%` TRIGGER `db_bases2_usac`.`carreras_AFTER_INSERT` AFTER INSERT ON `carreras` FOR EACH ROW
BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "CARRERAS"', 'INSERT');
END

CREATE DEFINER=`root`@`%` TRIGGER `db_bases2_usac`.`carreras_AFTER_UPDATE` AFTER UPDATE ON `carreras` FOR EACH ROW
BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "CARRERAS"', 'UPDATE');
END

CREATE DEFINER=`root`@`%` TRIGGER `db_bases2_usac`.`carreras_AFTER_DELETE` AFTER DELETE ON `carreras` FOR EACH ROW
BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "CARRERAS"', 'DELETE');
END