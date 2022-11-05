CREATE DEFINER=`root`@`%` TRIGGER `db_bases2_usac`.`docentes_AFTER_INSERT` AFTER INSERT ON `docentes` FOR EACH ROW
BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "DOCENTES"', 'INSERT');
END

CREATE DEFINER=`root`@`%` TRIGGER `db_bases2_usac`.`docentes_AFTER_UPDATE` AFTER UPDATE ON `docentes` FOR EACH ROW
BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "DOCENTES"', 'UPDATE');
END

CREATE DEFINER=`root`@`%` TRIGGER `db_bases2_usac`.`docentes_AFTER_DELETE` AFTER DELETE ON `docentes` FOR EACH ROW
BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "DOCENTES"', 'DELETE');
END
