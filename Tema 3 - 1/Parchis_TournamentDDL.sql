-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Parchis_Tournament
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Parchis_Tournament` ;

-- -----------------------------------------------------
-- Schema Parchis_Tournament
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Parchis_Tournament` DEFAULT CHARACTER SET utf8 ; -- Está en desuso esta query (o mejor dicho el CHARSET). La modificaremos
ALTER DATABASE `Cadena_TV` CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci ; -- De esta forma no nos dará el warning

USE `Parchis_Tournament` ;

-- -----------------------------------------------------
-- Table `Parchis_Tournament`.`Federaciones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parchis_Tournament`.`Federaciones` ;
CREATE TABLE IF NOT EXISTS `Parchis_Tournament`.`Federaciones` (
  `ID_Federación` INT NOT NULL AUTO_INCREMENT,
  `Nombre_Región` VARCHAR(45) NOT NULL,
  `Fecha_Fundación` DATE NOT NULL,
  `Núm_Total_Jugadores` INT NULL,
  `Núm_Total_Árbitros` INT NULL,
  PRIMARY KEY (`ID_Federación`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Parchis_Tournament`.`Personas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parchis_Tournament`.`Personas` ;
CREATE TABLE IF NOT EXISTS `Parchis_Tournament`.`Personas` (
  `DNI_Personas` VARCHAR(45) NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellido_1` VARCHAR(45) NULL,
  `Apellido_2` VARCHAR(45) NOT NULL,
  `Fecha_Nacimiento` DATE NULL,
  `ID_Federación` INT NOT NULL,
  `Federaciones_ID_Federación` INT NOT NULL,
  PRIMARY KEY (`DNI_Personas`, `ID_Federación`),
  INDEX `fk_Personas_Federaciones1_idx` (`Federaciones_ID_Federación` ASC) VISIBLE,
  CONSTRAINT `fk_Personas_Federaciones1`
    FOREIGN KEY (`Federaciones_ID_Federación`)
    REFERENCES `Parchis_Tournament`.`Federaciones` (`ID_Federación`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Parchis_Tournament`.`Teléfonos_Personas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parchis_Tournament`.`Teléfonos_Personas` ;
CREATE TABLE IF NOT EXISTS `Parchis_Tournament`.`Teléfonos_Personas` (
  `Personas_DNI_Personas` VARCHAR(45) NOT NULL,
  `Teléfonos` VARCHAR(45) NULL,
  INDEX `fk_Teléfonos_Personas_Personas1_idx` (`Personas_DNI_Personas` ASC) VISIBLE,
  CONSTRAINT `fk_Teléfonos_Personas_Personas1`
    FOREIGN KEY (`Personas_DNI_Personas`)
    REFERENCES `Parchis_Tournament`.`Personas` (`DNI_Personas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Parchis_Tournament`.`Jugadores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parchis_Tournament`.`Jugadores` ;
CREATE TABLE IF NOT EXISTS `Parchis_Tournament`.`Jugadores` (
  `ID_Federado` INT NOT NULL AUTO_INCREMENT,
  `DNI_Jugadores` VARCHAR(45) NOT NULL,
  `Año_Federado` DATE NOT NULL,
  `Posición_Ranking_Nacional` INT NULL,
  PRIMARY KEY (`ID_Federado`, `DNI_Jugadores`),
  INDEX `DNI_Jugadores_idx` (`DNI_Jugadores` ASC) VISIBLE,
  CONSTRAINT `DNI_Jugadores`
    FOREIGN KEY (`DNI_Jugadores`)
    REFERENCES `Parchis_Tournament`.`Personas` (`DNI_Personas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Parchis_Tournament`.`Árbitros`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parchis_Tournament`.`Árbitros` ;
CREATE TABLE IF NOT EXISTS `Parchis_Tournament`.`Árbitros` (
  `ID_Colegiado` INT NOT NULL AUTO_INCREMENT,
  `DNI_Árbitro` VARCHAR(45) NOT NULL,
  `Núm_Años_Árbitro` INT NOT NULL,
  PRIMARY KEY (`ID_Colegiado`, `DNI_Árbitro`),
  INDEX `DNI_Árbitro_idx` (`DNI_Árbitro` ASC) VISIBLE,
  CONSTRAINT `DNI_Árbitro`
    FOREIGN KEY (`DNI_Árbitro`)
    REFERENCES `Parchis_Tournament`.`Personas` (`DNI_Personas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Parchis_Tournament`.`Hoteles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parchis_Tournament`.`Hoteles` ;
CREATE TABLE IF NOT EXISTS `Parchis_Tournament`.`Hoteles` (
  `ID_Hotel` INT NOT NULL AUTO_INCREMENT,
  `Nombre_Hotel` VARCHAR(45) NOT NULL,
  `Categoría` ENUM('1', '2', '3', '4', '5'), -- Modificamos la DDL para que tenga sólo 5 posibles valores.
  -- Algo muy importante a destacar aquí es que ENUM sólo toma como entrada datos tipo String. Por tanto, si queremos dar una categoría no podrá ser introducido como un INT (1), sino como char o String ('1). Esto
  -- será muy relevante luego a la hora de programar la base de datos
  `Dirección` VARCHAR(45) NULL,
  `Núm_Total_Habitaciones` INT NOT NULL,
  PRIMARY KEY (`ID_Hotel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Parchis_Tournament`.`Teléfonos_Hotel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parchis_Tournament`.`Teléfonos_Hotel` ;
CREATE TABLE IF NOT EXISTS `Parchis_Tournament`.`Teléfonos_Hotel` (
  `Hoteles_ID_Hotel` INT NOT NULL,
  `Teléfonos` VARCHAR(45) NULL,
  INDEX `fk_Teléfonos_Hotel_Hoteles1_idx` (`Hoteles_ID_Hotel` ASC) VISIBLE,
  CONSTRAINT `fk_Teléfonos_Hotel_Hoteles1`
    FOREIGN KEY (`Hoteles_ID_Hotel`)
    REFERENCES `Parchis_Tournament`.`Hoteles` (`ID_Hotel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Parchis_Tournament`.`Partidas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parchis_Tournament`.`Partidas` ;
CREATE TABLE IF NOT EXISTS `Parchis_Tournament`.`Partidas` (
  `ID_Partida` INT NOT NULL AUTO_INCREMENT,
  `Fecha_Hora_Partida` DATETIME NULL,
  `Duración_Partidas` TIME NULL,
  `ID_Colegiado` INT NOT NULL,
  `Árbitros_ID_Colegiado` INT NOT NULL,
  PRIMARY KEY (`ID_Partida`, `ID_Colegiado`),
  INDEX `fk_Partidas_Árbitros1_idx` (`Árbitros_ID_Colegiado` ASC) VISIBLE,
  CONSTRAINT `fk_Partidas_Árbitros1`
    FOREIGN KEY (`Árbitros_ID_Colegiado`)
    REFERENCES `Parchis_Tournament`.`Árbitros` (`ID_Colegiado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Parchis_Tournament`.`Movimientos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parchis_Tournament`.`Movimientos` ;
CREATE TABLE IF NOT EXISTS `Parchis_Tournament`.`Movimientos` (
  `Núm_Orden_Jugada` INT NOT NULL AUTO_INCREMENT,
  `Núm_Casilla_Inicial` INT NULL,
  `Núm_Casilla_Final` INT NULL,
  `Comentario_Movimiento` VARCHAR(45) NULL,
  `ID_Partida` INT NOT NULL,
  `ID_Federado` INT NOT NULL,
  PRIMARY KEY (`Núm_Orden_Jugada`, `ID_Partida`, `ID_Federado`),
  INDEX `fk_Movimientos_Partidas1_idx` (`ID_Partida` ASC) VISIBLE,
  INDEX `fk_Movimientos_Jugadores1_idx` (`ID_Federado` ASC) VISIBLE,
  CONSTRAINT `fk_Movimientos_Partidas1`
    FOREIGN KEY (`ID_Partida`)
    REFERENCES `Parchis_Tournament`.`Partidas` (`ID_Partida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Movimientos_Jugadores1`
    FOREIGN KEY (`ID_Federado`)
    REFERENCES `Parchis_Tournament`.`Jugadores` (`ID_Federado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Parchis_Tournament`.`Salas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parchis_Tournament`.`Salas` ;
CREATE TABLE IF NOT EXISTS `Parchis_Tournament`.`Salas` (
  `Núm_Sala` INT NOT NULL AUTO_INCREMENT,
  `Capacidad_Sala` INT NOT NULL,
  `Descripción` VARCHAR(45) NULL,
  PRIMARY KEY (`Núm_Sala`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Parchis_Tournament`.`Hospedan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parchis_Tournament`.`Hospedan` ;
CREATE TABLE IF NOT EXISTS `Parchis_Tournament`.`Hospedan` (
  `Personas_DNI_Personas` VARCHAR(45) NOT NULL,
  `Hoteles_ID_Hotel` INT NOT NULL,
  `Número_Habitación` INT NOT NULL,
  `Fecha_Entrada_Habitación` DATETIME NOT NULL, -- Cambiamos a DATETIME para evitar confusiones de múltiples Check_In/Out el mismo día
  `Fecha_Salida_Habitación` DATETIME NULL,
  PRIMARY KEY (`Personas_DNI_Personas`, `Hoteles_ID_Hotel`),
  INDEX `fk_Personas_has_Hoteles_Hoteles1_idx` (`Hoteles_ID_Hotel` ASC) VISIBLE,
  INDEX `fk_Personas_has_Hoteles_Personas1_idx` (`Personas_DNI_Personas` ASC) VISIBLE,
  CONSTRAINT `fk_Personas_has_Hoteles_Personas1`
    FOREIGN KEY (`Personas_DNI_Personas`)
    REFERENCES `Parchis_Tournament`.`Personas` (`DNI_Personas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Personas_has_Hoteles_Hoteles1`
    FOREIGN KEY (`Hoteles_ID_Hotel`)
    REFERENCES `Parchis_Tournament`.`Hoteles` (`ID_Hotel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Parchis_Tournament`.`Jugar_Partidas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parchis_Tournament`.`Jugar_Partidas` ;
CREATE TABLE IF NOT EXISTS `Parchis_Tournament`.`Jugar_Partidas` (
  `Jugadores_ID_Federado` INT NOT NULL,
  `Partidas_ID_Partida` INT NOT NULL,
  `Color_Fichas` ENUM('Azul', 'Amarillo', 'Verde', 'Rojo') NULL, -- Denotamos los valores específicos que las fichas pueden tener
  `Puesto_Jugador` INT NULL,
  PRIMARY KEY (`Jugadores_ID_Federado`, `Partidas_ID_Partida`),
  INDEX `fk_Jugadores_has_Partidas_Partidas1_idx` (`Partidas_ID_Partida` ASC) VISIBLE,
  INDEX `fk_Jugadores_has_Partidas_Jugadores1_idx` (`Jugadores_ID_Federado` ASC) VISIBLE,
  CONSTRAINT `fk_Jugadores_has_Partidas_Jugadores1`
    FOREIGN KEY (`Jugadores_ID_Federado`)
    REFERENCES `Parchis_Tournament`.`Jugadores` (`ID_Federado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Jugadores_has_Partidas_Partidas1`
    FOREIGN KEY (`Partidas_ID_Partida`)
    REFERENCES `Parchis_Tournament`.`Partidas` (`ID_Partida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Parchis_Tournament`.`Hoteles_Salas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parchis_Tournament`.`Hoteles_Salas` ;
CREATE TABLE IF NOT EXISTS `Parchis_Tournament`.`Hoteles_Salas` (
  `Hoteles_ID_Hotel` INT NOT NULL,
  `Salas_Núm_Sala` INT NOT NULL,
  PRIMARY KEY (`Hoteles_ID_Hotel`, `Salas_Núm_Sala`),
  INDEX `fk_Hoteles_has_Salas_Salas1_idx` (`Salas_Núm_Sala` ASC) VISIBLE,
  INDEX `fk_Hoteles_has_Salas_Hoteles1_idx` (`Hoteles_ID_Hotel` ASC) VISIBLE,
  CONSTRAINT `fk_Hoteles_has_Salas_Hoteles1`
    FOREIGN KEY (`Hoteles_ID_Hotel`)
    REFERENCES `Parchis_Tournament`.`Hoteles` (`ID_Hotel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Hoteles_has_Salas_Salas1`
    FOREIGN KEY (`Salas_Núm_Sala`)
    REFERENCES `Parchis_Tournament`.`Salas` (`Núm_Sala`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Parchis_Tournament`.`Partidas_en_Salas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parchis_Tournament`.`Partidas_en_Salas` ;
CREATE TABLE IF NOT EXISTS `Parchis_Tournament`.`Partidas_en_Salas` (
  `Salas_Núm_Sala` INT NOT NULL,
  `Partidas_ID_Partida` INT NOT NULL,
  PRIMARY KEY (`Salas_Núm_Sala`, `Partidas_ID_Partida`),
  INDEX `fk_Salas_has_Partidas_Partidas1_idx` (`Partidas_ID_Partida` ASC) VISIBLE,
  INDEX `fk_Salas_has_Partidas_Salas1_idx` (`Salas_Núm_Sala` ASC) VISIBLE,
  CONSTRAINT `fk_Salas_has_Partidas_Salas1`
    FOREIGN KEY (`Salas_Núm_Sala`)
    REFERENCES `Parchis_Tournament`.`Salas` (`Núm_Sala`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Salas_has_Partidas_Partidas1`
    FOREIGN KEY (`Partidas_ID_Partida`)
    REFERENCES `Parchis_Tournament`.`Partidas` (`ID_Partida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
