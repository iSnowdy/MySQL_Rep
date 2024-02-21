-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Agencia_Viajes
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Agencia_Viajes` ;

-- -----------------------------------------------------
-- Schema Agencia_Viajes
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Agencia_Viajes` DEFAULT CHARACTER SET utf8 ; -- Este tipo de CHARSET ya está en desuso; desactualizado
ALTER DATABASE `Cadena_TV` CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci ; -- Modificamos la DB para que tenga CHARSET y COLLATE actualizados
USE `Agencia_Viajes` ;

-- -----------------------------------------------------
-- Table `Agencia_Viajes`.`Sucursales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Agencia_Viajes`.`Sucursales` ;
CREATE TABLE IF NOT EXISTS `Agencia_Viajes`.`Sucursales` (
  `ID_Sucursal` INT NOT NULL,
  `Dirección` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_Sucursal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Agencia_Viajes`.`Teléfonos_Sucursal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Agencia_Viajes`.`Teléfonos_Sucursal` ;
CREATE TABLE IF NOT EXISTS `Agencia_Viajes`.`Teléfonos_Sucursal` (
  `Teléfono_Sucursal` VARCHAR(20) NOT NULL,
  `Sucursal_ID` INT NULL,
  PRIMARY KEY (`Teléfono_Sucursal`),
  INDEX `TLFSucursal_ID_idx` (`Sucursal_ID` ASC) VISIBLE,
  CONSTRAINT `TLFSucursal_ID`
    FOREIGN KEY (`Sucursal_ID`)
    REFERENCES `Agencia_Viajes`.`Sucursales` (`ID_Sucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Agencia_Viajes`.`Turistas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Agencia_Viajes`.`Turistas` ;
CREATE TABLE IF NOT EXISTS `Agencia_Viajes`.`Turistas` (
  `ID_Turista` INT NOT NULL,
  `Nombre_Pila` VARCHAR(20) NOT NULL,
  `Apellido_1` VARCHAR(20) NOT NULL,
  `Apellido_2` VARCHAR(20) NULL,
  `Dirección` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_Turista`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Agencia_Viajes`.`Teléfonos_Turista`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Agencia_Viajes`.`Teléfonos_Turista` ;
CREATE TABLE IF NOT EXISTS `Agencia_Viajes`.`Teléfonos_Turista` (
  `Teléfono_Turista` VARCHAR(20) NOT NULL,
  `Turista_ID` INT NULL,
  PRIMARY KEY (`Teléfono_Turista`),
  INDEX `TLFTurista_ID_idx` (`Turista_ID` ASC) VISIBLE,
  CONSTRAINT `TLFTurista_ID`
    FOREIGN KEY (`Turista_ID`)
    REFERENCES `Agencia_Viajes`.`Turistas` (`ID_Turista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Agencia_Viajes`.`Vuelos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Agencia_Viajes`.`Vuelos` ;
CREATE TABLE IF NOT EXISTS `Agencia_Viajes`.`Vuelos` (
  `ID_Vuelo` INT NOT NULL,
  `Origen` VARCHAR(20) NOT NULL,
  `Destino` VARCHAR(20) NOT NULL,
  `Fecha_y_Hora` DATETIME NOT NULL, -- Modificamos para que sea fecha y hora (se me pasó en el Diagrama)
  `Plazas_Totales` INT NOT NULL,
  `Plazas_Turista` INT NULL,
  PRIMARY KEY (`ID_Vuelo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Agencia_Viajes`.`Hoteles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Agencia_Viajes`.`Hoteles` ;
CREATE TABLE IF NOT EXISTS `Agencia_Viajes`.`Hoteles` (
  `ID_Hotel` INT NOT NULL,
  `Nombre` VARCHAR(20) NOT NULL,
  `Categoría` INT NULL,
  `Dirección` VARCHAR(45) NOT NULL,
  `Ciudad` VARCHAR(20) NULL,
  `Nº_Plazas_Disponibles` INT NOT NULL,
  PRIMARY KEY (`ID_Hotel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Agencia_Viajes`.`Teléfonos_Hotel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Agencia_Viajes`.`Teléfonos_Hotel` ;
CREATE TABLE IF NOT EXISTS `Agencia_Viajes`.`Teléfonos_Hotel` (
  `Teléfono_Hotel` VARCHAR(20) NOT NULL,
  `Hotel_ID` INT NULL,
  PRIMARY KEY (`Teléfono_Hotel`),
  INDEX `TLFHotel_ID_idx` (`Hotel_ID` ASC) VISIBLE,
  CONSTRAINT `TLFHotel_ID`
    FOREIGN KEY (`Hotel_ID`)
    REFERENCES `Agencia_Viajes`.`Hoteles` (`ID_Hotel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Agencia_Viajes`.`Turistas_has_Sucursales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Agencia_Viajes`.`Turistas_has_Sucursales` ;
CREATE TABLE IF NOT EXISTS `Agencia_Viajes`.`Turistas_has_Sucursales` (
  `Turistas_ID_Turista` INT NOT NULL,
  `Sucursales_ID_Sucursal` INT NOT NULL,
  PRIMARY KEY (`Turistas_ID_Turista`, `Sucursales_ID_Sucursal`),
  INDEX `fk_Turistas_has_Sucursales_Sucursales1_idx` (`Sucursales_ID_Sucursal` ASC) VISIBLE,
  INDEX `fk_Turistas_has_Sucursales_Turistas1_idx` (`Turistas_ID_Turista` ASC) VISIBLE,
  CONSTRAINT `fk_Turistas_has_Sucursales_Turistas1`
    FOREIGN KEY (`Turistas_ID_Turista`)
    REFERENCES `Agencia_Viajes`.`Turistas` (`ID_Turista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Turistas_has_Sucursales_Sucursales1`
    FOREIGN KEY (`Sucursales_ID_Sucursal`)
    REFERENCES `Agencia_Viajes`.`Sucursales` (`ID_Sucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Agencia_Viajes`.`Turistas_has_Vuelos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Agencia_Viajes`.`Turistas_has_Vuelos` ;
CREATE TABLE IF NOT EXISTS `Agencia_Viajes`.`Turistas_has_Vuelos` (
  `Turistas_ID_Turista` INT NOT NULL,
  `Vuelos_ID_Vuelo` INT NOT NULL,
  `Clase` ENUM ('Turista', 'Primera') NOT NULL, -- Modificamos para que sólo tenga dos posibles valores,
  PRIMARY KEY (`Turistas_ID_Turista`, `Vuelos_ID_Vuelo`, `Clase`),
  INDEX `fk_Turistas_has_Vuelos_Vuelos1_idx` (`Vuelos_ID_Vuelo` ASC) VISIBLE,
  INDEX `fk_Turistas_has_Vuelos_Turistas1_idx` (`Turistas_ID_Turista` ASC) VISIBLE,
  CONSTRAINT `fk_Turistas_has_Vuelos_Turistas1`
    FOREIGN KEY (`Turistas_ID_Turista`)
    REFERENCES `Agencia_Viajes`.`Turistas` (`ID_Turista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Turistas_has_Vuelos_Vuelos1`
    FOREIGN KEY (`Vuelos_ID_Vuelo`)
    REFERENCES `Agencia_Viajes`.`Vuelos` (`ID_Vuelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Agencia_Viajes`.`Turistas_has_Hoteles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Agencia_Viajes`.`Turistas_has_Hoteles` ;
CREATE TABLE IF NOT EXISTS `Agencia_Viajes`.`Turistas_has_Hoteles` (
  `Turistas_ID_Turista` INT NOT NULL,
  `Hoteles_ID_Hotel` INT NOT NULL,
  `Fecha_Llegada` DATETIME NOT NULL,
  `Régimen_H` ENUM('Desayuno', 'Media Pensión', 'Pensión Completa'),
  `Fecha_Salida` DATETIME NULL, -- Modificamos la fecha para que tenga más sentido según lo comentado en la explicación
  `Nº_Hab_Reservadas` INT NOT NULL,
  PRIMARY KEY (`Turistas_ID_Turista`, `Hoteles_ID_Hotel`, `Fecha_Llegada`),
  INDEX `fk_Turistas_has_Hoteles_Hoteles1_idx` (`Hoteles_ID_Hotel` ASC) VISIBLE,
  INDEX `fk_Turistas_has_Hoteles_Turistas1_idx` (`Turistas_ID_Turista` ASC) VISIBLE,
  CONSTRAINT `fk_Turistas_has_Hoteles_Turistas1`
    FOREIGN KEY (`Turistas_ID_Turista`)
    REFERENCES `Agencia_Viajes`.`Turistas` (`ID_Turista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Turistas_has_Hoteles_Hoteles1`
    FOREIGN KEY (`Hoteles_ID_Hotel`)
    REFERENCES `Agencia_Viajes`.`Hoteles` (`ID_Hotel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
