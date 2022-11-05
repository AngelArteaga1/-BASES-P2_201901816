/*
SQLyog Ultimate v9.63 
MySQL - 5.6.27-log : Database - db_bases2_usac
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_bases2_usac` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `db_bases2_usac`;

/*Table structure for table `asignaciones` */

CREATE TABLE `asignaciones` (
  `idasignacion` int(11) NOT NULL AUTO_INCREMENT,
  `idcurso` int(11) NOT NULL,
  `ciclo` varchar(2) DEFAULT NULL,
  `seccion` char(1) DEFAULT NULL,
  `carnet` bigint(10) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `nota` int(11) DEFAULT NULL,
  `fechadesasignacion` date DEFAULT NULL,
  PRIMARY KEY (`idasignacion`),
  KEY `refCurso2_idx` (`idcurso`),
  CONSTRAINT `refCurso2` FOREIGN KEY (`idcurso`) REFERENCES `cursos` (`idcurso`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='Tabla de asignaciones	';

/*Table structure for table `carreras` */

CREATE TABLE `carreras` (
  `idcarrera` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idcarrera`),
  UNIQUE KEY `nombreCarrera` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='Esta es la tabla para almacenar las carreras';

/*Table structure for table `cursos` */

CREATE TABLE `cursos` (
  `idcurso` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `creditosnecesarios` int(11) DEFAULT NULL,
  `creditosotorgados` int(11) DEFAULT NULL,
  `obligatorio` tinyint(4) DEFAULT NULL,
  `idcarrera` int(11) NOT NULL,
  PRIMARY KEY (`idcurso`),
  KEY `refCarrera_idx` (`idcarrera`),
  CONSTRAINT `refCarrera` FOREIGN KEY (`idcarrera`) REFERENCES `carreras` (`idcarrera`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla de cursos';

/*Table structure for table `cursos_habilitados` */

CREATE TABLE `cursos_habilitados` (
  `idcurso_habilitado` int(11) NOT NULL AUTO_INCREMENT,
  `idcurso` int(11) NOT NULL,
  `ciclo` varchar(2) DEFAULT NULL,
  `seccion` char(1) DEFAULT NULL,
  `anio` int(11) DEFAULT NULL,
  `cupo` int(11) DEFAULT NULL,
  `actagenerada` tinyint(4) DEFAULT NULL,
  `fechaacta` datetime DEFAULT NULL,
  `iddocente` int(11) NOT NULL,
  PRIMARY KEY (`idcurso_habilitado`),
  KEY `RefDocente_idx` (`iddocente`),
  KEY `RefCurso_idx` (`idcurso`),
  CONSTRAINT `RefCurso` FOREIGN KEY (`idcurso`) REFERENCES `cursos` (`idcurso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `RefDocente` FOREIGN KEY (`iddocente`) REFERENCES `docentes` (`iddocente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='Cursos habilitados';

/*Table structure for table `docentes` */

CREATE TABLE `docentes` (
  `iddocente` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(50) DEFAULT NULL,
  `apellidos` varchar(50) DEFAULT NULL,
  `fechanacimiento` date DEFAULT NULL,
  `correo` varchar(255) DEFAULT NULL,
  `telefono` bigint(8) DEFAULT NULL,
  `direccion` varchar(120) DEFAULT NULL,
  `dpi` bigint(16) DEFAULT NULL,
  `fechacreacion` date DEFAULT NULL,
  `registrosiif` int(11) DEFAULT NULL,
  PRIMARY KEY (`iddocente`),
  UNIQUE KEY `siff` (`registrosiif`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Tabla de docentes';

/*Table structure for table `estudiantes` */

CREATE TABLE `estudiantes` (
  `idestudiante` int(11) NOT NULL AUTO_INCREMENT,
  `carnet` bigint(10) DEFAULT NULL,
  `nombres` varchar(50) DEFAULT NULL,
  `apellidos` varchar(50) DEFAULT NULL,
  `fechanacimiento` date DEFAULT NULL,
  `correo` varchar(255) DEFAULT NULL,
  `telefono` bigint(8) DEFAULT NULL,
  `direccion` varchar(120) DEFAULT NULL,
  `dpi` bigint(16) DEFAULT NULL,
  `creditos` int(11) DEFAULT NULL,
  `fechacreacion` datetime DEFAULT NULL,
  `idcarrera` int(11) DEFAULT NULL,
  PRIMARY KEY (`idestudiante`),
  UNIQUE KEY `carnet` (`carnet`),
  KEY `refCarrera1_idx` (`idcarrera`),
  CONSTRAINT `refCarrera1` FOREIGN KEY (`idcarrera`) REFERENCES `carreras` (`idcarrera`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='Esta tabla es donde se registran todos los estudiantes';

/*Table structure for table `horarios` */

CREATE TABLE `horarios` (
  `idhorario` int(11) NOT NULL AUTO_INCREMENT,
  `idcurso_habilitado` int(11) NOT NULL,
  `dia` int(11) DEFAULT NULL,
  `horario` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`idhorario`),
  KEY `refCursoHabilitado` (`idcurso_habilitado`),
  CONSTRAINT `refCursoHabilitado` FOREIGN KEY (`idcurso_habilitado`) REFERENCES `cursos_habilitados` (`idcurso_habilitado`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='Horarios de los cursos habilitados';

/*Table structure for table `transacciones` */

CREATE TABLE `transacciones` (
  `fecha` datetime DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `tipo` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Esta es la tabla del historial de transacciones	';

/* Trigger structure for table `asignaciones` */

DELIMITER $$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `asignaciones_AFTER_INSERT` AFTER INSERT ON `asignaciones` FOR EACH ROW BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "ASIGNACIONES"', 'INSERT');
END */$$


DELIMITER ;

/* Trigger structure for table `asignaciones` */

DELIMITER $$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `asignaciones_AFTER_UPDATE` AFTER UPDATE ON `asignaciones` FOR EACH ROW BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "ASIGNACIONES"', 'UPDATE');
END */$$


DELIMITER ;

/* Trigger structure for table `asignaciones` */

DELIMITER $$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `asignaciones_AFTER_DELETE` AFTER DELETE ON `asignaciones` FOR EACH ROW BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "ASIGNACIONES"', 'DELETE');
END */$$


DELIMITER ;

/* Trigger structure for table `carreras` */

DELIMITER $$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `carreras_AFTER_INSERT` AFTER INSERT ON `carreras` FOR EACH ROW BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "CARRERAS"', 'INSERT');
END */$$


DELIMITER ;

/* Trigger structure for table `carreras` */

DELIMITER $$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `carreras_AFTER_UPDATE` AFTER UPDATE ON `carreras` FOR EACH ROW BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "CARRERAS"', 'UPDATE');
END */$$


DELIMITER ;

/* Trigger structure for table `carreras` */

DELIMITER $$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `carreras_AFTER_DELETE` AFTER DELETE ON `carreras` FOR EACH ROW BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "CARRERAS"', 'DELETE');
END */$$


DELIMITER ;

/* Trigger structure for table `cursos` */

DELIMITER $$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `cursos_AFTER_INSERT` AFTER INSERT ON `cursos` FOR EACH ROW BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "CURSOS"', 'INSERT');
END */$$


DELIMITER ;

/* Trigger structure for table `cursos` */

DELIMITER $$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `cursos_AFTER_UPDATE` AFTER UPDATE ON `cursos` FOR EACH ROW BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "CURSOS"', 'UPDATE');
END */$$


DELIMITER ;

/* Trigger structure for table `cursos` */

DELIMITER $$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `cursos_AFTER_DELETE` AFTER DELETE ON `cursos` FOR EACH ROW BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "CURSOS"', 'DELETE');
END */$$


DELIMITER ;

/* Trigger structure for table `cursos_habilitados` */

DELIMITER $$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `cursos_habilitados_AFTER_INSERT` AFTER INSERT ON `cursos_habilitados` FOR EACH ROW BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "CURSOS_HABILITADOS"', 'INSERT');
END */$$


DELIMITER ;

/* Trigger structure for table `cursos_habilitados` */

DELIMITER $$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `cursos_habilitados_AFTER_UPDATE` AFTER UPDATE ON `cursos_habilitados` FOR EACH ROW BEGIN
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
END */$$


DELIMITER ;

/* Trigger structure for table `cursos_habilitados` */

DELIMITER $$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `cursos_habilitados_AFTER_DELETE` AFTER DELETE ON `cursos_habilitados` FOR EACH ROW BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "CURSOS_HABILITADOS"', 'DELETE');
END */$$


DELIMITER ;

/* Trigger structure for table `docentes` */

DELIMITER $$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `docentes_AFTER_INSERT` AFTER INSERT ON `docentes` FOR EACH ROW BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "DOCENTES"', 'INSERT');
END */$$


DELIMITER ;

/* Trigger structure for table `docentes` */

DELIMITER $$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `docentes_AFTER_UPDATE` AFTER UPDATE ON `docentes` FOR EACH ROW BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "DOCENTES"', 'UPDATE');
END */$$


DELIMITER ;

/* Trigger structure for table `docentes` */

DELIMITER $$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `docentes_AFTER_DELETE` AFTER DELETE ON `docentes` FOR EACH ROW BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "DOCENTES"', 'DELETE');
END */$$


DELIMITER ;

/* Trigger structure for table `estudiantes` */

DELIMITER $$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `estudiantes_AFTER_INSERT` AFTER INSERT ON `estudiantes` FOR EACH ROW BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "ESTUDIANTES"', 'INSERT');
END */$$


DELIMITER ;

/* Trigger structure for table `estudiantes` */

DELIMITER $$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `estudiantes_AFTER_UPDATE` AFTER UPDATE ON `estudiantes` FOR EACH ROW BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "ESTUDIANTES"', 'UPDATE');
END */$$


DELIMITER ;

/* Trigger structure for table `estudiantes` */

DELIMITER $$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `estudiantes_AFTER_DELETE` AFTER DELETE ON `estudiantes` FOR EACH ROW BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "ESTUDIANTES"', 'DELETE');
END */$$


DELIMITER ;

/* Trigger structure for table `horarios` */

DELIMITER $$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `horarios_AFTER_INSERT` AFTER INSERT ON `horarios` FOR EACH ROW BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "HORARIOS"', 'INSERT');
END */$$


DELIMITER ;

/* Trigger structure for table `horarios` */

DELIMITER $$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `horarios_AFTER_UPDATE` AFTER UPDATE ON `horarios` FOR EACH ROW BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "HORARIOS"', 'UPDATE');
END */$$


DELIMITER ;

/* Trigger structure for table `horarios` */

DELIMITER $$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `horarios_AFTER_DELETE` AFTER DELETE ON `horarios` FOR EACH ROW BEGIN
	CALL AgregarTransaccion(NOW(), 'Se ha realizado una accion en la tabla "HORARIOS"', 'DELETE');
END */$$


DELIMITER ;

/* Procedure structure for procedure `AgregarHorario` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `AgregarHorario`(IN pIdCursoHabilitado INT, IN pDia INT, IN pHorario varchar(11))
AgregarHorario:BEGIN
	-- Primero validamos los datos
	IF pDia <= 0 or pDia > 7 THEN 
		SELECT 'Ese dia no esta dentro del rango adecuado' AS Error; 
		LEAVE AgregarHorario;
	END IF;
	
	-- Primero validamos los datos
	IF pHorario NOT REGEXP '^[0-9]+:[0-9]+\-[0-9]+:[0-9]+$' THEN 
		SELECT 'La cadena del horario no es correcta' AS Error; 
        LEAVE AgregarHorario;
	END IF;
	
	INSERT INTO horarios (idcurso_habilitado, dia, horario)
	VALUES (pIdCursoHabilitado, pDia, pHorario);
    
    SELECT 'Horario Asignado Correctamente!' AS Success;
END */$$
DELIMITER ;

/* Procedure structure for procedure `AgregarTransaccion` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `AgregarTransaccion`(IN pFecha DATETIME, IN pDescripcion VARCHAR(255), IN pTipo VARCHAR(6))
BEGIN
	INSERT INTO transacciones (fecha, descripcion, tipo)
	VALUES (pFecha, pDescripcion, pTipo);
END */$$
DELIMITER ;

/* Procedure structure for procedure `AsignarCurso` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `AsignarCurso`( IN pIdCurso INT, IN pCiclo VARCHAR(2), 
								  IN pSeccion CHAR(1), IN pCarnet BIGINT(10))
AsignarCurso:BEGIN
	DECLARE encontrado INT DEFAULT 0;
    DECLARE xcupo INT DEFAULT 0;
    DECLARE xasignaciones INT DEFAULT 0;
    DECLARE xcreditosestudiante INT DEFAULT 0;
    DECLARE xcreditosnecesarios INT DEFAULT 0;
    DECLARE xidcarreracurso INT DEFAULT 0;
    DECLARE xidcarreraestudiante INT DEFAULT 0;
    
	-- Primero validamos los datos
    -- Si el estudiante existe
    SELECT COUNT(*) INTO encontrado FROM estudiantes WHERE carnet = pCarnet;
	IF encontrado = 0 THEN 
		SELECT 'El carnet de estudiante no existe' as Error; 
        LEAVE AsignarCurso;
	END IF;
	-- Si el ciclo es el correcto
    IF NOT (pCiclo = '1S' OR pCiclo = '2S' OR pCiclo = 'VJ' OR pCiclo = 'VD') THEN
		SELECT 'El ciclo no es correcto' as Error; 
        LEAVE AsignarCurso;
    END IF;
    -- Si el curso habilitado existe
    SET encontrado = 0;
    SELECT COUNT(*) INTO encontrado FROM cursos_habilitados WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion);
	IF encontrado = 0 THEN 
		SELECT 'No existe ese curso habilitado' as Error;
        LEAVE AsignarCurso;
	END IF;
    -- Si el estudiante ya se encuentra asignado
	SET encontrado = 0;
    SELECT COUNT(*) INTO encontrado FROM asignaciones WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion) AND carnet = pCarnet AND status = true;
	IF encontrado > 0 THEN 
		SELECT 'El estudiante ya se encuentra asignado' as Error;
        LEAVE AsignarCurso;
	END IF;
    
    -- Si todavia no hay cupo
	SELECT cupo INTO xcupo FROM cursos_habilitados WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion);
    SELECT count(*) INTO xasignaciones FROM asignaciones WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion) AND status = true;
    IF xasignaciones >= xcupo THEN
		SELECT 'Ya no hay cupo en esta seccion' as Error;
        LEAVE AsignarCurso;
    END IF;
    
    -- Si el estudiante no tiene creditos necesarios
    SELECT creditosnecesarios, idcarrera INTO xcreditosnecesarios, xidcarreracurso FROM cursos WHERE idcurso = pIdCurso;
    SELECT creditos, idcarrera INTO xcreditosestudiante, xidcarreraestudiante FROM estudiantes WHERE carnet = pCarnet;
    IF xcreditosestudiante < xcreditosnecesarios THEN
		SELECT 'El estudiante no posee los creditos necesarios para asignarse' as Error;
        LEAVE AsignarCurso;
    END IF;
    
    -- Si el curso no es de la misma carrera que el estudiante
    IF (xidcarreraestudiante <> xidcarreracurso) AND xidcarreracurso <> 0 THEN
		SELECT 'El estudiante no puede asignarse a un curso de otra carrera' as Error;
        LEAVE AsignarCurso;
    END IF;
    
    -- Si el estudiante se habia desasignado y se volvio a asignar
	SET encontrado = 0;
    SELECT COUNT(*) INTO encontrado FROM asignaciones WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion) AND carnet = pCarnet AND status = false;
	IF encontrado > 0 THEN 
		UPDATE asignaciones
		SET status = true
		WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion) AND carnet = pCarnet;
		SELECT 'Estudiante Asignado Correctamente!' as Success;
        LEAVE AsignarCurso;
	END IF;
    
	INSERT INTO asignaciones (idcurso, ciclo, seccion, carnet, status)
	VALUES (pIdCurso, pCiclo, UPPER(pSeccion), pCarnet, true);
    
    SELECT 'Estudiante Asignado Correctamente!' as Success;
END */$$
DELIMITER ;

/* Procedure structure for procedure `ConsultarActas` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `ConsultarActas`(IN pIdcurso INT)
ConsultarActas:BEGIN
	DECLARE encontrado INT DEFAULT 0;
	-- Primero debemos verificar si existe el curso
    SELECT COUNT(*) INTO encontrado FROM cursos WHERE idcurso = pIdCurso;
	IF encontrado = 0 THEN 
		SELECT 'No existe ese curso' as Error;
        LEAVE ConsultarActas;
	END IF;
    
    -- Ahora realizamos el select
    SELECT
	cursos_habilitados.idcurso as 'Codigo de curso',
        cursos_habilitados.seccion as 'Seccion',
        CASE
			WHEN cursos_habilitados.ciclo = '1S' THEN 'PRIMER SEMESTRE'
			WHEN cursos_habilitados.ciclo = '2S' THEN 'SEGUNDO SEMESTRE'
            WHEN cursos_habilitados.ciclo = 'VJ' THEN 'VACACIONES DE JUNIO'
			ELSE 'VACACIONES DE DICIEMBRE'
		END as 'Ciclo',
        cursos_habilitados.anio as 'Año',
        count(asignaciones.carnet) as 'Cantidad de Estudiantes',
        cursos_habilitados.fechaacta as 'Fecha de generada'
	FROM 
		cursos_habilitados,
        asignaciones
	WHERE
		cursos_habilitados.actagenerada = true AND
        cursos_habilitados.idcurso = asignaciones.idcurso AND
        cursos_habilitados.seccion = asignaciones.seccion AND
        cursos_habilitados.ciclo = asignaciones.ciclo 
	GROUP BY cursos_habilitados.idcurso_habilitado
    ORDER BY cursos_habilitados.fechaacta DESC;
END */$$
DELIMITER ;

/* Procedure structure for procedure `ConsultarAprobaciones` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `ConsultarAprobaciones`(IN pIdCurso INT, IN pCiclo VARCHAR(2), IN pAnio INT, IN pSeccion VARCHAR(1))
ConsultarAprobaciones:BEGIN
	DECLARE encontrado INT DEFAULT 0;
	-- Si el ciclo es el correcto
    IF NOT (pCiclo = '1S' OR pCiclo = '2S' OR pCiclo = 'VJ' OR pCiclo = 'VD') THEN
		SELECT 'El ciclo no es correcto' as Error; 
        LEAVE ConsultarAprobaciones;
    END IF;
    -- Si la seccion es mayuscula
	IF pSeccion NOT REGEXP BINARY '^[A-Z]$' THEN 
		SELECT 'La cadena de la seccion no es correcta' as Error; 
        LEAVE ConsultarAprobaciones;
	END IF;
	-- Primero debemos verificar si existe el curso
    SET encontrado = 0;
    SELECT COUNT(*) INTO encontrado FROM cursos_habilitados WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion);
	IF encontrado = 0 THEN 
		SELECT 'No existe ese curso habilitado' as Error;
        LEAVE ConsultarAprobaciones;
	END IF;
    
    -- Ahora realizamos el select
	SELECT 
		asignaciones.idcurso as 'Codigo de curso',
        asignaciones.carnet as 'Carnet',
        CONCAT(estudiantes.nombres, " ", estudiantes.apellidos) as 'Nombre completo',
        estudiantes.creditos as 'Creditos que posee',
        CASE
			WHEN asignaciones.nota > 60 THEN 'APROBADO'
			ELSE 'DESAPROBADO'
		END as 'Aprobado / Desaprobado'
	FROM
		asignaciones,
        estudiantes,
        cursos_habilitados
	WHERE
		asignaciones.idcurso = pIdcurso AND
        asignaciones.ciclo = pCiclo AND
        asignaciones.seccion = pSeccion AND
        asignaciones.carnet = estudiantes.carnet AND
        asignaciones.status = true AND
		asignaciones.idcurso = cursos_habilitados.idcurso AND
        asignaciones.seccion = cursos_habilitados.seccion AND
        asignaciones.ciclo = cursos_habilitados.ciclo AND
        cursos_habilitados.anio = PAnio;
END */$$
DELIMITER ;

/* Procedure structure for procedure `ConsultarAsignados` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `ConsultarAsignados`(IN pIdCurso INT, IN pCiclo VARCHAR(2), IN pAnio INT, IN pSeccion VARCHAR(1))
ConsultarAsignados:BEGIN
	DECLARE encontrado INT DEFAULT 0;
	-- Si el ciclo es el correcto
    IF NOT (pCiclo = '1S' OR pCiclo = '2S' OR pCiclo = 'VJ' OR pCiclo = 'VD') THEN
		SELECT 'El ciclo no es correcto' as Error; 
        LEAVE ConsultarAsignados;
    END IF;
    -- Si la seccion es mayuscula
	IF pSeccion NOT REGEXP BINARY '^[A-Z]$' THEN 
		SELECT 'La cadena de la seccion no es correcta' as Error; 
        LEAVE ConsultarAsignados;
	END IF;
	-- Primero debemos verificar si existe el curso
    SET encontrado = 0;
    SELECT COUNT(*) INTO encontrado FROM cursos_habilitados WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion);
	IF encontrado = 0 THEN 
		SELECT 'No existe ese curso habilitado' as Error;
        LEAVE ConsultarAsignados;
	END IF;
    
    -- Ahora realizamos el select
	SELECT 
        asignaciones.carnet as 'Carnet',
        CONCAT(estudiantes.nombres, " ", estudiantes.apellidos) as 'Nombre completo',
        estudiantes.creditos as 'Creditos que posee'
	FROM
		asignaciones,
        estudiantes,
        cursos_habilitados
	WHERE
		asignaciones.idcurso = pIdcurso AND
        asignaciones.ciclo = pCiclo AND
        asignaciones.seccion = pSeccion AND
        asignaciones.carnet = estudiantes.carnet AND
        asignaciones.status = true AND
        asignaciones.idcurso = cursos_habilitados.idcurso AND
        asignaciones.seccion = cursos_habilitados.seccion AND
        asignaciones.ciclo = cursos_habilitados.ciclo AND
        cursos_habilitados.anio = PAnio;
END */$$
DELIMITER ;

/* Procedure structure for procedure `ConsultarDesasignacion` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `ConsultarDesasignacion`(IN pIdCurso INT, IN pCiclo VARCHAR(2), IN pAnio INT, IN pSeccion VARCHAR(1))
ConsultarDesasignacion:BEGIN
	DECLARE encontrado INT DEFAULT 0;
	-- Si el ciclo es el correcto
    IF NOT (pCiclo = '1S' OR pCiclo = '2S' OR pCiclo = 'VJ' OR pCiclo = 'VD') THEN
		SELECT 'El ciclo no es correcto' as Error; 
        LEAVE ConsultarDesasignacion;
    END IF;
    -- Si la seccion es mayuscula
	IF pSeccion NOT REGEXP BINARY '^[A-Z]$' THEN 
		SELECT 'La cadena de la seccion no es correcta' as Error; 
        LEAVE ConsultarDesasignacion;
	END IF;
	-- Primero debemos verificar si existe el curso
    SET encontrado = 0;
    SELECT COUNT(*) INTO encontrado FROM cursos_habilitados WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion);
	IF encontrado = 0 THEN 
		SELECT 'No existe ese curso habilitado' as Error;
        LEAVE ConsultarDesasignacion;
	END IF;
    
	-- Ahora realizamos el select
	SELECT 
		asignaciones.idcurso as 'Codigo de curso',
        asignaciones.seccion as 'Seccion',
		CASE
			WHEN asignaciones.ciclo = '1S' THEN 'PRIMER SEMESTRE'
			WHEN asignaciones.ciclo = '2S' THEN 'SEGUNDO SEMESTRE'
            WHEN asignaciones.ciclo = 'VJ' THEN 'VACACIONES DE JUNIO'
			ELSE 'VACACIONES DE DICIEMBRE'
		END as 'Ciclo',
        cursos_habilitados.anio as 'Año',
        count(CASE WHEN asignaciones.status = true THEN 1 END) as 'Cantidad de asignaciones totales',
        count(CASE WHEN asignaciones.status = false THEN 1 END) as 'Cantidad de desasignaciones',
        (count(CASE WHEN asignaciones.status = false THEN 1 END) * 100) / count(*) as 'Porcentaje de desasignacion'
	FROM
		asignaciones,
        cursos_habilitados
	WHERE
		asignaciones.idcurso = pIdcurso AND
        asignaciones.ciclo = pCiclo AND
        asignaciones.seccion = pSeccion AND
        asignaciones.idcurso = cursos_habilitados.idcurso AND
        asignaciones.seccion = cursos_habilitados.seccion AND
        asignaciones.ciclo = cursos_habilitados.ciclo AND
        cursos_habilitados.anio = PAnio;
END */$$
DELIMITER ;

/* Procedure structure for procedure `ConsultarDocente` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `ConsultarDocente`(IN pRegistroSIIF BIGINT(11))
ConsultarDocente:BEGIN
	DECLARE encontrado INT DEFAULT 0;
	-- Primero validamos los datos
    -- Si el estudiante existe
    SELECT COUNT(*) INTO encontrado FROM docentes WHERE registrosiif = pRegistroSIIF;
	IF encontrado = 0 THEN 
		SELECT 'El Registro SIIF del docente no existe' as Error; 
        LEAVE ConsultarDocente;
	END IF;
    
    -- Ahora realizamos el select
	SELECT 
		docentes.registrosiif as 'Registro SIIF',
        CONCAT(docentes.nombres, " ", docentes.apellidos) as 'Nombre completo',
        docentes.fechanacimiento as 'Fecha de nacimiento',
        docentes.correo as 'Correo',
        docentes.telefono as 'Telefóno',
        docentes.direccion as 'Direccion',
        docentes.dpi as 'Numero de DPI'
	FROM
		docentes
	WHERE
		docentes.registrosiif = pRegistroSIIF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `ConsultarEstudiante` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `ConsultarEstudiante`(IN pCarnet BIGINT(10))
ConsultarEstudiantes:BEGIN
	DECLARE encontrado INT DEFAULT 0;
	-- Primero validamos los datos
    -- Si el estudiante existe
    SELECT COUNT(*) INTO encontrado FROM estudiantes WHERE carnet = pCarnet;
	IF encontrado = 0 THEN 
		SELECT 'El carnet de estudiante no existe' as Error; 
        LEAVE ConsultarEstudiantes;
	END IF;
    
    -- Ahora realizamos el select
	SELECT 
		estudiantes.carnet as 'Carnet',
        CONCAT(estudiantes.nombres, " ", estudiantes.apellidos) as 'Nombre completo',
        estudiantes.fechanacimiento as 'Fecha de nacimiento',
        estudiantes.correo as 'Correo',
        estudiantes.telefono as 'Telefóno',
        estudiantes.direccion as 'Direccion',
        estudiantes.dpi as 'Numero de DPI',
        carreras.nombre as 'Carrera',
        estudiantes.creditos as 'Creditos que Posee'
	FROM
		estudiantes,
        carreras
	WHERE
		estudiantes.idcarrera = carreras.idcarrera AND
		estudiantes.carnet = pCarnet;
END */$$
DELIMITER ;

/* Procedure structure for procedure `ConsultarPensum` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `ConsultarPensum`(IN pIdcarrera INT)
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
END */$$
DELIMITER ;

/* Procedure structure for procedure `CrearCarrera` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `CrearCarrera`(IN pNombre VARCHAR(100))
CrearCarrera:BEGIN
	-- Primero validamos si la cadena es correcta
	IF pNombre NOT REGEXP '^[a-zA-Z ]*$' THEN 
		SELECT 'La cadena del nombre no es correcta' as Error; 
        LEAVE CrearCarrera;
	END IF;

	INSERT INTO carreras (nombre)
	VALUES (pNombre);
    
    SELECT 'Carrera Agregada Correctamente!' as Success;
END */$$
DELIMITER ;

/* Procedure structure for procedure `CrearCurso` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `CrearCurso`(	IN pIdCurso INT, IN pNombre VARCHAR(50), 
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
END */$$
DELIMITER ;

/* Procedure structure for procedure `DesasignarCurso` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `DesasignarCurso`(IN pIdCurso INT, IN pCiclo VARCHAR(2), 
									IN pSeccion CHAR(1), IN pCarnet BIGINT(10))
DesasignarCurso:BEGIN
	DECLARE encontrado INT DEFAULT 0;
    SELECT COUNT(*) 
    INTO encontrado 
    FROM asignaciones 
    WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion) AND carnet = pCarnet AND status = true;
	IF encontrado = 0 THEN 
		SELECT 'El estudiante no se encuentra asignado' as Error;
        LEAVE DesasignarCurso;
	END IF;
    UPDATE asignaciones
	SET status = false, fechadesasignacion = NOW()
	WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion) AND carnet = pCarnet;
    SELECT 'Estudiante Desasignado Correctamente!' as Success;
END */$$
DELIMITER ;

/* Procedure structure for procedure `GenerarActa` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `GenerarActa`(IN pIdCurso INT, IN pCiclo VARCHAR(2), IN pSeccion CHAR(1))
GenerarActa:BEGIN
	DECLARE encontrado INT DEFAULT 0;
    DECLARE notasingresadas INT DEFAULT 0;
    DECLARE numeroasignaciones INT DEFAULT 0;
	-- Si el ciclo es el correcto
    IF NOT (pCiclo = '1S' OR pCiclo = '2S' OR pCiclo = 'VJ' OR pCiclo = 'VD') THEN
		SELECT 'El ciclo no es correcto' as Error; 
        LEAVE GenerarActa;
    END IF;
	-- Primero debemos verificar si existe el curso
    SET encontrado = 0;
    SELECT COUNT(*) INTO encontrado FROM cursos_habilitados WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion);
	IF encontrado = 0 THEN 
		SELECT 'No existe ese curso habilitado' as Error;
        LEAVE GenerarActa;
	END IF;
    -- Ahora verificamos si todos los estudiantes tienen nota
    SELECT COUNT(*) INTO notasingresadas 
    FROM asignaciones 
    WHERE 
		idcurso = pIdCurso AND 
        ciclo = pCiclo AND 
        seccion = UPPER(pSeccion) AND 
        status = true AND 
        nota IS NOT NULL;
    SELECT COUNT(*) INTO numeroasignaciones 
    FROM asignaciones 
    WHERE 
		idcurso = pIdCurso AND 
        ciclo = pCiclo AND 
        seccion = UPPER(pSeccion) AND
        status = true;
	IF notasingresadas < numeroasignaciones THEN 
		SELECT 'No ha ingresado todas las notas de curso' as Error, notasingresadas as notasingresadas, numeroasignaciones as asignaciones;
        LEAVE GenerarActa;
	END IF;
    
    -- AHORA YA ACTUALIZAMOS
	UPDATE cursos_habilitados
	SET actagenerada = true, fechaacta = NOW()
	WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion);
    
    SELECT 'Acta Generada Correctamente!' as Success;
END */$$
DELIMITER ;

/* Procedure structure for procedure `HabilitarCurso` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `HabilitarCurso`( IN pIdCurso INT, IN pCiclo VARCHAR(2), 
									IN pIdDocente INT, IN pCupo INT, 
									IN pSeccion CHAR(1) )
HabilitarCurso:BEGIN
	DECLARE encontrado INT DEFAULT 0;
	-- Primero validamos los datos
    SELECT COUNT(*) INTO encontrado FROM cursos WHERE idcurso = pIdCurso;
    
	IF encontrado = 0 THEN 
		SELECT 'El codigo de curso no existe' as Error; 
        LEAVE HabilitarCurso;
	END IF;
    IF NOT (pCiclo = '1S' OR pCiclo = '2S' OR pCiclo = 'VJ' OR pCiclo = 'VD') THEN
		SELECT 'El ciclo no es correcto' as Error; 
        LEAVE HabilitarCurso;
    END IF;
	IF pCupo <= 0 THEN 
		SELECT 'El cupo del curso no puede ser un numero negativo o 0' as Error; 
        LEAVE HabilitarCurso;
	END IF;
	-- Si el curso habilitado existe
    SET encontrado = 0;
    SELECT COUNT(*) INTO encontrado FROM cursos_habilitados WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion);
	IF encontrado > 0 THEN 
		SELECT 'Ya existe ese curso habilitado' as Error;
        LEAVE HabilitarCurso;
	END IF;
    
	INSERT INTO cursos_habilitados (idcurso, ciclo, iddocente, cupo, seccion, anio, actagenerada)
	VALUES (pIdCurso, pCiclo, pIdDocente, pCupo, UPPER(pSeccion), YEAR(NOW()), false);
    
    SELECT 'Curso Habilitado Correctamente!' as Success;
    
END */$$
DELIMITER ;

/* Procedure structure for procedure `IngresarNota` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `IngresarNota`(IN pIdCurso INT, IN pCiclo VARCHAR(2), 
								 IN pSeccion CHAR(1), IN pCarnet BIGINT(10), IN pNota INT)
IngresarNota:BEGIN
	DECLARE encontrado INT DEFAULT 0;
	-- Primero validamos los datos
    -- Si el estudiante existe
    SELECT COUNT(*) INTO encontrado FROM estudiantes WHERE carnet = pCarnet;
	IF encontrado = 0 THEN 
		SELECT 'El carnet de estudiante no existe' as Error; 
        LEAVE IngresarNota;
	END IF;
	-- Si el ciclo es el correcto
    IF NOT (pCiclo = '1S' OR pCiclo = '2S' OR pCiclo = 'VJ' OR pCiclo = 'VD') THEN
		SELECT 'El ciclo no es correcto' as Error; 
        LEAVE IngresarNota;
    END IF;
	-- Si el curso habilitado existe
    SET encontrado = 0;
    SELECT COUNT(*) INTO encontrado FROM cursos_habilitados WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion);
	IF encontrado = 0 THEN 
		SELECT 'No existe ese curso habilitado' as Error;
        LEAVE IngresarNota;
	END IF;
	-- Si el estudiante no se encuentra asignado
	SET encontrado = 0;
    SELECT COUNT(*) INTO encontrado FROM asignaciones WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion) AND carnet = pCarnet AND status = true;
	IF encontrado = 0 THEN 
		SELECT 'El estudiante no se encuentra asignado' as Error;
        LEAVE IngresarNota;
	END IF;
    -- Si la nota no es un numero positivo
	IF pNota < 0 OR pNota > 100 THEN 
		SELECT 'La nota no esta dentro del rango de notas' as Error; 
        LEAVE IngresarNota;
	END IF;
    
    -- AHORA YA INGRESAMOS LA NOTA!
	UPDATE asignaciones
	SET nota = pNota
	WHERE idcurso = pIdCurso AND ciclo = pCiclo AND seccion = UPPER(pSeccion) AND carnet = pCarnet AND status = true;
    
    SELECT 'Nota ingresada Correctamente!' as Success;
END */$$
DELIMITER ;

/* Procedure structure for procedure `RegistrarDocente` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `RegistrarDocente`(IN pNombres VARCHAR(50), IN pApellidos VARCHAR(50), 
										IN pFechaNacimiento DATE, IN pCorreo VARCHAR(255), IN pTelefono BIGINT(8), 
                                        IN pDireccion VARCHAR(120), IN pDpi BIGINT(16), IN pRegistroSIIF INT)
RegistrarDocente:BEGIN
	-- Primero validamos los datos
	IF pNombres NOT REGEXP '^[a-zA-Z ]*$' THEN 
		SELECT 'La cadena del nombre no es correcta' as Error; 
        LEAVE RegistrarDocente;
	END IF;
	IF pApellidos NOT REGEXP '^[a-zA-Z ]*$' THEN 
		SELECT 'La cadena del nombre no es correcta' as Error; 
        LEAVE RegistrarDocente;
	END IF;
	IF pCorreo NOT REGEXP '^[^@]+@[^@]+\.[^@]{2,}$' THEN 
		SELECT 'La cadena del correo no es correcta' as Error; 
        LEAVE RegistrarDocente;
	END IF;
    
	INSERT INTO docentes (nombres, apellidos, fechanacimiento, correo, telefono, direccion, dpi, fechacreacion, registrosiif)
	VALUES (pNombres, pApellidos, pFechaNacimiento, pCorreo, pTelefono, pDireccion, pDpi, NOW(), pRegistroSIIF);
    
    SELECT 'Docente Registrado Correctamente!' as Success;
END */$$
DELIMITER ;

/* Procedure structure for procedure `RegistrarEstudiante` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `RegistrarEstudiante`(IN pCarnet BIGINT(10), IN pNombres VARCHAR(50), IN pApellidos VARCHAR(50), 
										IN pFechaNacimiento DATE, IN pCorreo VARCHAR(255), IN pTelefono BIGINT(8), 
                                        IN pDireccion VARCHAR(120), IN pDpi BIGINT(16), IN pidCarrera INT)
RegistrarEstudiante:BEGIN
	-- Primero validamos los datos
	IF pNombres NOT REGEXP '^[a-zA-Z ]*$' THEN 
		SELECT 'La cadena del nombre no es correcta' as Error; 
        LEAVE RegistrarEstudiante;
	END IF;
	IF pApellidos NOT REGEXP '^[a-zA-Z ]*$' THEN 
		SELECT 'La cadena del nombre no es correcta' as Error; 
        LEAVE RegistrarEstudiante;
	END IF;
	IF pCorreo NOT REGEXP '^[^@]+@[^@]+\.[^@]{2,}$' THEN 
		SELECT 'La cadena del correo no es correcta' as Error; 
        LEAVE RegistrarEstudiante;
	END IF;
    
	INSERT INTO estudiantes (carnet, nombres, apellidos, fechanacimiento, correo, telefono, direccion, dpi, creditos, fechacreacion, idcarrera)
	VALUES (pCarnet, pNombres, pApellidos, pFechaNacimiento, pCorreo, pTelefono, pDireccion, pDpi, 0, NOW(), pidCarrera);
    
    SELECT 'Estudiante Registrado Correctamente!' as Success;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
