-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema user20DB3
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema user20DB3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `user20DB3` DEFAULT CHARACTER SET latin1 ;
USE `user20DB3` ;

-- -----------------------------------------------------
-- Table `user20DB3`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user20DB3`.`users` (
  `user_id` INT(11) NOT NULL,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `password` VARCHAR(45) NULL DEFAULT NULL,
  `phone` BIGINT(10) NULL DEFAULT NULL,
  `role` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `user20DB3`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user20DB3`.`employees` (
  `emp_id` INT(11) NOT NULL,
  `user_id` INT(11) NULL DEFAULT NULL,
  `emp_fname` VARCHAR(45) NULL DEFAULT NULL,
  `emp_lname` VARCHAR(45) NULL DEFAULT NULL,
  `e_dob` DATE NULL DEFAULT NULL,
  `hire_date` DATE NULL DEFAULT NULL,
  `salary` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`emp_id`),
  INDEX `user_id_fkk_idx` (`user_id` ASC),
  CONSTRAINT `user_id_fkk`
    FOREIGN KEY (`user_id`)
    REFERENCES `user20DB3`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `user20DB3`.`wards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user20DB3`.`wards` (
  `ward_id` INT(11) NOT NULL,
  `type` VARCHAR(45) NULL DEFAULT NULL,
  `charges` DOUBLE NULL DEFAULT NULL,
  `availability` VARCHAR(45) NULL DEFAULT NULL,
  `max_capacity` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`ward_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `user20DB3`.`patients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user20DB3`.`patients` (
  `patient_id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NULL DEFAULT NULL,
  `ward_id` INT(11) NULL DEFAULT NULL,
  `date_of_admission` DATE NULL DEFAULT NULL,
  `dob` DATE NULL DEFAULT NULL,
  `blood_group` SET('A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-') NULL DEFAULT NULL,
  `age` INT(11) NULL DEFAULT NULL,
  `patient_illness` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`patient_id`),
  INDEX `ward_id_idx` (`ward_id` ASC),
  INDEX `u_id_fk_idx` (`user_id` ASC),
  CONSTRAINT `u_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `user20DB3`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ward_id`
    FOREIGN KEY (`ward_id`)
    REFERENCES `user20DB3`.`wards` (`ward_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `user20DB3`.`appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user20DB3`.`appointment` (
  `app_id` INT(11) NOT NULL,
  `patient_id` INT(11) NULL DEFAULT NULL,
  `emp_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`app_id`),
  INDEX `pat_id_fk_idx` (`patient_id` ASC),
  INDEX `emp_id fk_idx` (`emp_id` ASC),
  CONSTRAINT `emp_id fk`
    FOREIGN KEY (`emp_id`)
    REFERENCES `user20DB3`.`employees` (`emp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `pat_id_fk`
    FOREIGN KEY (`patient_id`)
    REFERENCES `user20DB3`.`patients` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `user20DB3`.`medicines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user20DB3`.`medicines` (
  `med_id` INT(11) NOT NULL,
  `med_name` VARCHAR(100) NULL DEFAULT NULL,
  `price` DECIMAL(7,2) NULL DEFAULT NULL,
  PRIMARY KEY (`med_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `user20DB3`.`medicines_assigned`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user20DB3`.`medicines_assigned` (
  `med_assignedid` INT(11) NOT NULL,
  `patient_id` INT(11) NULL DEFAULT NULL,
  `med_id` INT(11) NULL DEFAULT NULL,
  `medicine_quantity` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`med_assignedid`),
  INDEX `patient_id_idx` (`patient_id` ASC),
  INDEX `med_id_idx` (`med_id` ASC),
  CONSTRAINT `med_id`
    FOREIGN KEY (`med_id`)
    REFERENCES `user20DB3`.`medicines` (`med_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `patient_id`
    FOREIGN KEY (`patient_id`)
    REFERENCES `user20DB3`.`patients` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
