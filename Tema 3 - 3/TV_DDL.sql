-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Cadena_TV
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Cadena_TV` ;

-- -----------------------------------------------------
-- Schema Cadena_TV
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Cadena_TV` DEFAULT CHARACTER SET utf8 ; -- Outdated utf8 character set 
ALTER DATABASE `Cadena_TV` CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci; -- We modify if to we get the proper CHARSET and no warning
USE `Cadena_TV` ;

-- -----------------------------------------------------
-- Table `Cadena_TV`.`Empleados`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cadena_TV`.`Empleados` ;

CREATE TABLE IF NOT EXISTS `Cadena_TV`.`Empleados` (
  `DNI` VARCHAR(20) NOT NULL,
  `Nombre_Pila` VARCHAR(20) NOT NULL,
  `Apellido_1` VARCHAR(20) NULL,
  `Apellido_2` VARCHAR(20) NOT NULL,
  `Nº_SS` VARCHAR(45) NOT NULL,
  `Sueldo` DECIMAL(5,2) NOT NULL, -- Los sueldos vendrán dados en un número decimal para evitar errores luego
  `Fecha_Nacimiento` DATE NOT NULL,
  `Fecha_Ingreso` DATE NOT NULL,
  PRIMARY KEY (`DNI`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cadena_TV`.`Teléfonos_Empleados`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cadena_TV`.`Teléfonos_Empleados` ;

CREATE TABLE IF NOT EXISTS `Cadena_TV`.`Teléfonos_Empleados` (
  `DNI_Empleado` VARCHAR(20) NOT NULL,
  `Teléfono` VARCHAR(45) NOT NULL,
  INDEX `DNI_Empleados_idx` (`DNI_Empleado` ASC) VISIBLE,
  PRIMARY KEY (`Teléfono`),
  CONSTRAINT `DNI_Empleados`
    FOREIGN KEY (`DNI_Empleado`)
    REFERENCES `Cadena_TV`.`Empleados` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cadena_TV`.`Email_Empleados`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cadena_TV`.`Email_Empleados` ;

CREATE TABLE IF NOT EXISTS `Cadena_TV`.`Email_Empleados` (
  `DNI_Empleado` VARCHAR(20) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Email`),
  INDEX `DNI_Empleado_idx` (`DNI_Empleado` ASC) VISIBLE,
  CONSTRAINT `DNI_Empleado`
    FOREIGN KEY (`DNI_Empleado`)
    REFERENCES `Cadena_TV`.`Empleados` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cadena_TV`.`Canales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cadena_TV`.`Canales` ;

CREATE TABLE IF NOT EXISTS `Cadena_TV`.`Canales` (
  `ID_Canal` INT NOT NULL,
  `Nombre` VARCHAR(20) NOT NULL,
  `Fecha` DATE NULL,
  PRIMARY KEY (`ID_Canal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cadena_TV`.`Directivos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cadena_TV`.`Directivos` ;

CREATE TABLE IF NOT EXISTS `Cadena_TV`.`Directivos` (
  `DNI_Directivo` VARCHAR(20) NOT NULL,
  `Año_Inicio` DATE NOT NULL,
  PRIMARY KEY (`DNI_Directivo`),
  CONSTRAINT `DNI_Directivos`
    FOREIGN KEY (`DNI_Directivo`)
    REFERENCES `Cadena_TV`.`Empleados` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cadena_TV`.`Presentadores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cadena_TV`.`Presentadores` ;

CREATE TABLE IF NOT EXISTS `Cadena_TV`.`Presentadores` (
  `DNI_Presentador` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`DNI_Presentador`),
  CONSTRAINT `DNI_Presentadores`
    FOREIGN KEY (`DNI_Presentador`)
    REFERENCES `Cadena_TV`.`Empleados` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cadena_TV`.`Técnicos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cadena_TV`.`Técnicos` ;

CREATE TABLE IF NOT EXISTS `Cadena_TV`.`Técnicos` (
  `DNI_Técnico` VARCHAR(20) NOT NULL,
  `Título` VARCHAR(20) NOT NULL,
  `Especialidad` ENUM('Electricista', 'Informático', 'Técnico de sonido', 'Técnico de imagen') NOT NULL, -- Modificamos el tipo de dato para ser un ENUM. De esta forma sólo podra obtener los valores descritos aquí
  PRIMARY KEY (`DNI_Técnico`),
  CONSTRAINT `DNI_Técnicos`
    FOREIGN KEY (`DNI_Técnico`)
    REFERENCES `Cadena_TV`.`Empleados` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cadena_TV`.`Periodistas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cadena_TV`.`Periodistas` ;

CREATE TABLE IF NOT EXISTS `Cadena_TV`.`Periodistas` (
  `DNI_Periodista` VARCHAR(20) NOT NULL,
  `Universidad` VARCHAR(20) NULL,
  PRIMARY KEY (`DNI_Periodista`),
  CONSTRAINT `DNI_Periodistas`
    FOREIGN KEY (`DNI_Periodista`)
    REFERENCES `Cadena_TV`.`Empleados` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cadena_TV`.`Programas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cadena_TV`.`Programas` ;

CREATE TABLE IF NOT EXISTS `Cadena_TV`.`Programas` (
  `ID_Programa` INT NOT NULL,
  `Canal_ID` INT NOT NULL,
  `Nombre` VARCHAR(20) NOT NULL,
  `Periodicidad` ENUM('Diario', 'Semanal', 'Mensual', 'Eventual') NULL,
  `Tipo` VARCHAR(45) NULL,
  `Fecha_Primero` DATE NOT NULL,
  `Fecha_Último` DATE NULL,
  PRIMARY KEY (`ID_Programa`),
  INDEX `Canal_ID_idx` (`Canal_ID` ASC) VISIBLE,
  CONSTRAINT `Canal_ID`
    FOREIGN KEY (`Canal_ID`)
    REFERENCES `Cadena_TV`.`Canales` (`ID_Canal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cadena_TV`.`Emisiones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cadena_TV`.`Emisiones` ;

CREATE TABLE IF NOT EXISTS `Cadena_TV`.`Emisiones` (
  `Nº_Emisión` INT NOT NULL,
  `Programa_ID` INT NOT NULL,
  `DNI_Presentador` VARCHAR(20) NOT NULL,
  `Fecha_Hora` DATETIME NOT NULL,
  `Duración` INT NULL,
  PRIMARY KEY (`Nº_Emisión`),
  INDEX `Programa_ID_idx` (`Programa_ID` ASC) VISIBLE,
  INDEX `DNI_Presentador_idx` (`DNI_Presentador` ASC) VISIBLE,
  CONSTRAINT `Programa_ID`
    FOREIGN KEY (`Programa_ID`)
    REFERENCES `Cadena_TV`.`Programas` (`ID_Programa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `DNI_Presentador`
    FOREIGN KEY (`DNI_Presentador`)
    REFERENCES `Cadena_TV`.`Presentadores` (`DNI_Presentador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cadena_TV`.`Anuncios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cadena_TV`.`Anuncios` ;

CREATE TABLE IF NOT EXISTS `Cadena_TV`.`Anuncios` (
  `ID_Anuncios` INT NOT NULL,
  `Producto` VARCHAR(20) NULL,
  `Coste` DECIMAL(10,2) NULL, -- Definimos como tipo de dato decimal desde la DDL
  `Duración` VARCHAR(45) NULL,
  `Empresa` VARCHAR(20) NULL,
  PRIMARY KEY (`ID_Anuncios`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cadena_TV`.`EmpleadosCanales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cadena_TV`.`EmpleadosCanales` ;

CREATE TABLE IF NOT EXISTS `Cadena_TV`.`EmpleadosCanales` (
  `DNI_Empleados` VARCHAR(20) NOT NULL,
  `Canal_ID` INT NOT NULL,
  `Fecha_Inicio` DATE NOT NULL,
  `Fecha_Fin` DATE NULL,
  `Tipo_Contrato` ENUM('Laboral', 'Mercantil') NOT NULL,
  PRIMARY KEY (`DNI_Empleados`, `Canal_ID`, `Fecha_Inicio`),
  INDEX `fk_Empleados_has_Canales_Canales1_idx` (`Canal_ID` ASC) VISIBLE,
  INDEX `fk_Empleados_has_Canales_Empleados1_idx` (`DNI_Empleados` ASC) VISIBLE,
  CONSTRAINT `fk_Empleados_has_Canales_Empleados1`
    FOREIGN KEY (`DNI_Empleados`)
    REFERENCES `Cadena_TV`.`Empleados` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empleados_has_Canales_Canales1`
    FOREIGN KEY (`Canal_ID`)
    REFERENCES `Cadena_TV`.`Canales` (`ID_Canal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cadena_TV`.`DirectivoDirigeCanales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cadena_TV`.`DirectivoDirigeCanales` ;

CREATE TABLE IF NOT EXISTS `Cadena_TV`.`DirectivoDirigeCanales` (
  `DNI_Directivo` VARCHAR(20) NOT NULL,
  `Canal_ID` INT NOT NULL,
  `Fecha_Inicio` DATE NOT NULL,
  `Fecha_Fin` DATE NULL,
  PRIMARY KEY (`DNI_Directivo`, `Canal_ID`, `Fecha_Inicio`),
  INDEX `fk_Directivos_has_Canales_Canales1_idx` (`Canal_ID` ASC) VISIBLE,
  INDEX `fk_Directivos_has_Canales_Directivos1_idx` (`DNI_Directivo` ASC) VISIBLE,
  CONSTRAINT `fk_Directivos_has_Canales_Directivos1`
    FOREIGN KEY (`DNI_Directivo`)
    REFERENCES `Cadena_TV`.`Directivos` (`DNI_Directivo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Directivos_has_Canales_Canales1`
    FOREIGN KEY (`Canal_ID`)
    REFERENCES `Cadena_TV`.`Canales` (`ID_Canal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cadena_TV`.`PeriodistasProgramas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cadena_TV`.`PeriodistasProgramas` ;

CREATE TABLE IF NOT EXISTS `Cadena_TV`.`PeriodistasProgramas` (
  `DNI_Periodistas` VARCHAR(20) NOT NULL,
  `Programa_ID` INT NOT NULL,
  PRIMARY KEY (`DNI_Periodistas`, `Programa_ID`),
  INDEX `fk_Periodistas_has_Programas_Programas1_idx` (`Programa_ID` ASC) VISIBLE,
  INDEX `fk_Periodistas_has_Programas_Periodistas1_idx` (`DNI_Periodistas` ASC) VISIBLE,
  CONSTRAINT `fk_Periodistas_has_Programas_Periodistas1`
    FOREIGN KEY (`DNI_Periodistas`)
    REFERENCES `Cadena_TV`.`Periodistas` (`DNI_Periodista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Periodistas_has_Programas_Programas1`
    FOREIGN KEY (`Programa_ID`)
    REFERENCES `Cadena_TV`.`Programas` (`ID_Programa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cadena_TV`.`EmisiónAnuncios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cadena_TV`.`EmisiónAnuncios` ;

CREATE TABLE IF NOT EXISTS `Cadena_TV`.`EmisiónAnuncios` (
  `Nº_Emisión` INT NOT NULL,
  `Anuncios_ID` INT NOT NULL,
  `Fecha_Hora` DATE NOT NULL,
  `Precio` DECIMAL(8,2) NULL, -- Es probable que el precio que se introduzca no sea un entero (INT). Por lo que ya durante la DDL modificamos el tipo de dato. Aunque se podría hacer luego también con DML (ALTER TABLE)
  PRIMARY KEY (`Nº_Emisión`, `Anuncios_ID`, `Fecha_Hora`),
  INDEX `fk_Emisiones_has_Anuncios_Anuncios1_idx` (`Anuncios_ID` ASC) VISIBLE,
  INDEX `fk_Emisiones_has_Anuncios_Emisiones1_idx` (`Nº_Emisión` ASC) VISIBLE,
  CONSTRAINT `fk_Emisiones_has_Anuncios_Emisiones1`
    FOREIGN KEY (`Nº_Emisión`)
    REFERENCES `Cadena_TV`.`Emisiones` (`Nº_Emisión`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Emisiones_has_Anuncios_Anuncios1`
    FOREIGN KEY (`Anuncios_ID`)
    REFERENCES `Cadena_TV`.`Anuncios` (`ID_Anuncios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
