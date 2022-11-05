CREATE DEFINER=`root`@`%` TRIGGER `db_bases2_usac`.`asignaciones_AFTER_INSERT` AFTER INSERT ON `asignaciones` FOR EACH ROW
BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "ASIGNACIONES"', 'INSERT');
END

CREATE DEFINER=`root`@`%` TRIGGER `db_bases2_usac`.`asignaciones_AFTER_UPDATE` AFTER UPDATE ON `asignaciones` FOR EACH ROW
BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "ASIGNACIONES"', 'UPDATE');
END

CREATE DEFINER=`root`@`%` TRIGGER `db_bases2_usac`.`asignaciones_AFTER_DELETE` AFTER DELETE ON `asignaciones` FOR EACH ROW
BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "ASIGNACIONES"', 'DELETE');
END