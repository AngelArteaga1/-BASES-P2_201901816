CREATE SCHEMA `db_bases2_usac` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE `db_bases2_usac`.`estudiantes` (
  `idestudiante` INT NOT NULL AUTO_INCREMENT,
  `carnet` BIGINT(10) NULL,
  `nombres` VARCHAR(50) NULL,
  `apellidos` VARCHAR(50) NULL,
  `fechanacimiento` DATE NULL,
  `correo` VARCHAR(255) NULL,
  `telefeno` BIGINT(8) NULL,
  `direccion` VARCHAR(120) NULL,
  `dpi` BIGINT(16) NULL,
  `carrera` INT NULL,
  `idcarrera` INT NULL,
  PRIMARY KEY (`idestudiante`))
COMMENT = 'Esta tabla es donde se registran todos los estudiantes';

CREATE TABLE `db_bases2_usac`.`carreras` (
  `idcarrera` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NULL,
  PRIMARY KEY (`idcarrera`))
COMMENT = 'Esta es la tabla para almacenar las carreras';

CREATE TABLE `db_bases2_usac`.`docentes` (
  `iddocente` INT NOT NULL AUTO_INCREMENT,
  `nombres` VARCHAR(50) NULL,
  `apellidos` VARCHAR(50) NULL,
  `fechanacimiento` DATE NULL,
  `correo` VARCHAR(255) NULL,
  `telefono` BIGINT(8) NULL,
  `direccion` VARCHAR(120) NULL,
  `dpi` BIGINT(16) NULL,
  `registrosiif` INT NULL,
  PRIMARY KEY (`iddocente`))
COMMENT = 'Tabla de docentes';

CREATE TABLE `db_bases2_usac`.`cursos` (
  `idcurso` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NULL,
  `creditosnecesarios` INT NULL,
  `creditosotorgados` INT NULL,
  `idcarrera` INT NULL,
  `obligatorio` TINYINT NULL,
  PRIMARY KEY (`idcurso`))
COMMENT = 'Tabla de cursos';


CREATE TABLE `db_bases2_usac`.`cursos_habilitados` (
  `idcurso_habilitado` INT NOT NULL AUTO_INCREMENT,
  `idcurso` INT NULL,
  `ciclo` VARCHAR(2) NULL,
  `iddocente` INT NULL,
  `cupo` INT NULL,
  `seccion` CHAR(1) NULL,
  PRIMARY KEY (`idcursos_habilitados`))
COMMENT = 'Cursos habilitados';

CREATE TABLE `db_bases2_usac`.`horarios` (
  `idhorario` INT NOT NULL AUTO_INCREMENT,
  `idcurso_habilitado` INT NULL,
  `dia` INT NULL,
  `horario` CHAR(15) NULL,
  PRIMARY KEY (`idhorario`))
COMMENT = 'Tabla de horarios';

CREATE TABLE `db_bases2_usac`.`asignaciones` (
  `idasignacion` INT NOT NULL AUTO_INCREMENT,
  `ciclo` VARCHAR(2) NULL,
  `seccion` CHAR(1) NULL,
  `carnet` BIGINT(10) NULL,
  `idcurso` INT NULL,
  PRIMARY KEY (`idasignacion`))
COMMENT = 'Tabla de asignaciones	';

CREATE TABLE `db_bases2_usac`.`transacciones` (
  `fecha` DATE NULL,
  `descripcion` VARCHAR(255) NULL,
  `tipo` VARCHAR(6) NULL)
COMMENT = 'Esta es la tabla del historial de transacciones	';

ALTER TABLE `db_bases2_usac`.`cursos` 
CHANGE COLUMN `obligatorio` `obligatorio` TINYINT(4) NULL DEFAULT NULL AFTER `creditosotorgados`,
CHANGE COLUMN `idcarrera` `idcarrera` INT(11) NOT NULL ,
ADD INDEX `refCarrera_idx` (`idcarrera` ASC);
;
ALTER TABLE `db_bases2_usac`.`cursos` 
ADD CONSTRAINT `refCarrera`
  FOREIGN KEY (`idcarrera`)
  REFERENCES `db_bases2_usac`.`carreras` (`idcarrera`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `db_bases2_usac`.`estudiantes` 
ADD INDEX `refCarrera1_idx` (`idcarrera` ASC);
;
ALTER TABLE `db_bases2_usac`.`estudiantes` 
ADD CONSTRAINT `refCarrera1`
  FOREIGN KEY (`idcarrera`)
  REFERENCES `db_bases2_usac`.`carreras` (`idcarrera`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
