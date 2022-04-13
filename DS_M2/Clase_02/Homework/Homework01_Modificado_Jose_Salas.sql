-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema db_henry
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_henry
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_henry` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `db_henry` ;

-- -----------------------------------------------------
-- Table `db_henry`.`carrera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_henry`.`carrera` (
  `idCarrera` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`idCarrera`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_henry`.`instructor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_henry`.`instructor` (
  `idInstructor` INT NOT NULL AUTO_INCREMENT,
  `cedulaIdentidad` INT NOT NULL,
  `nombre` VARCHAR(20) NULL DEFAULT NULL,
  `apellido` VARCHAR(20) NULL DEFAULT NULL,
  `fechaNacimiento` DATE NULL DEFAULT NULL,
  `fechaIncorporacion` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idInstructor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_henry`.`cohorte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_henry`.`cohorte` (
  `idCohorte` INT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(8) NOT NULL,
  `idCarrera` INT NOT NULL,
  `idInstructor` INT NOT NULL,
  `idAlumno` INT NOT NULL,
  `fechaInicio` DATE NULL DEFAULT NULL,
  `fechaFinalizacion` DATE NULL DEFAULT NULL,
  `instructor_idInstructor` INT NOT NULL,
  PRIMARY KEY (`idCohorte`),
  UNIQUE INDEX `UC_idInstructor` (`idInstructor` ASC) VISIBLE,
  INDEX `FK_CarreraCohorte` (`idCarrera` ASC) VISIBLE,
  INDEX `fk_cohorte_instructor1_idx` (`instructor_idInstructor` ASC) VISIBLE,
  CONSTRAINT `FK_CarreraCohorte`
    FOREIGN KEY (`idCarrera`)
    REFERENCES `db_henry`.`carrera` (`idCarrera`),
  CONSTRAINT `fk_cohorte_instructor1`
    FOREIGN KEY (`instructor_idInstructor`)
    REFERENCES `db_henry`.`instructor` (`idInstructor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_henry`.`alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_henry`.`alumno` (
  `idAlumno` INT NOT NULL AUTO_INCREMENT,
  `cedulaIdentidad` INT NOT NULL,
  `nombre` VARCHAR(20) NULL DEFAULT NULL,
  `apellido` VARCHAR(20) NULL DEFAULT NULL,
  `fechaNacimiento` DATE NULL DEFAULT NULL,
  `fechaIngreso` DATE NULL DEFAULT NULL,
  `idCohorte` INT NOT NULL,
  PRIMARY KEY (`idAlumno`),
  INDEX `FK_CohorteAlumno` (`idCohorte` ASC) VISIBLE,
  CONSTRAINT `FK_CohorteAlumno`
    FOREIGN KEY (`idCohorte`)
    REFERENCES `db_henry`.`cohorte` (`idCohorte`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
