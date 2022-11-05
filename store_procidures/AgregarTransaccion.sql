CREATE DEFINER=`root`@`%` PROCEDURE `AgregarTransaccion`(IN pFecha DATETIME, IN pDescripcion VARCHAR(255), IN pTipo VARCHAR(6))
BEGIN
	INSERT INTO transacciones (fecha, descripcion, tipo)
	VALUES (pFecha, pDescripcion, pTipo);
END