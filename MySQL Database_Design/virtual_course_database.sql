-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema virtual_course
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema virtual_course
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `virtual_course` DEFAULT CHARACTER SET utf8 ;
USE `virtual_course` ;

-- -----------------------------------------------------
-- Table `virtual_course`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `virtual_course`.`students` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(75) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `phone_number_UNIQUE` (`phone_number` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `virtual_course`.`courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `virtual_course`.`courses` (
  `courses_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(125) NOT NULL,
  `price` DECIMAL(9,2) NOT NULL,
  `description` VARCHAR(450) NOT NULL,
  `duration` TIME NOT NULL,
  PRIMARY KEY (`courses_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `virtual_course`.`enrollments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `virtual_course`.`enrollments` (
  `enrollment_id` INT NOT NULL AUTO_INCREMENT,
  `course_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  INDEX `fk_courses_has_students_students1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_courses_has_students_courses_idx` (`course_id` ASC) VISIBLE,
  PRIMARY KEY (`enrollment_id`),
  CONSTRAINT `fk_courses_has_students_courses`
    FOREIGN KEY (`course_id`)
    REFERENCES `virtual_course`.`courses` (`courses_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_courses_has_students_students1`
    FOREIGN KEY (`student_id`)
    REFERENCES `virtual_course`.`students` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `virtual_course`.`instructors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `virtual_course`.`instructors` (
  `instructor_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(75) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `biography` VARCHAR(225) NOT NULL,
  `course_id` INT NOT NULL,
  PRIMARY KEY (`instructor_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `phone_number_UNIQUE` (`phone_number` ASC) VISIBLE,
  INDEX `fk_instructors_courses1_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `fk_instructors_courses1`
    FOREIGN KEY (`course_id`)
    REFERENCES `virtual_course`.`courses` (`courses_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `virtual_course`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `virtual_course`.`payments` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL  DEFAULT NOW(),
  `amount` DECIMAL(9,2) NOT NULL ,
  `enrollment_id` INT NOT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `fk_payments_enrollments1_idx` (`enrollment_id` ASC) VISIBLE,
  CONSTRAINT `amount_positive` CHECK (`amount` > 0),
  CONSTRAINT `fk_payments_enrollments1`
    FOREIGN KEY (`enrollment_id`)
    REFERENCES `virtual_course`.`enrollments` (`enrollment_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `virtual_course`.`certificates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `virtual_course`.`certificates` (
  `certificate_id` INT NOT NULL AUTO_INCREMENT,
  `issue_date` DATETIME NOT NULL DEFAULT NOW(),
  `enrollment_id` INT NOT NULL,
  PRIMARY KEY (`certificate_id`),
  INDEX `fk_certificates_enrollments1_idx` (`enrollment_id` ASC) VISIBLE,
  CONSTRAINT `fk_certificates_enrollments1`
    FOREIGN KEY (`enrollment_id`)
    REFERENCES `virtual_course`.`enrollments` (`enrollment_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
