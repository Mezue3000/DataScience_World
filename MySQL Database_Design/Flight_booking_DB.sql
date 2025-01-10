-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Flight_booking_system
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Flight_booking_system
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Flight_booking_system` DEFAULT CHARACTER SET utf8 ;
USE `Flight_booking_system` ;


-- -----------------------------------------------------
-- Table `Flight_booking_system`.`passengers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Flight_booking_system`.`passengers` (
  `passenger_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(25) NOT NULL,
  `last_name` VARCHAR(25) NOT NULL,
  `email` VARCHAR(75) NOT NULL,
  `age` TINYINT NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`passenger_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Flight_booking_system`.`flights`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Flight_booking_system`.`flights` (
  `flight_id` INT NOT NULL AUTO_INCREMENT,
  `flight_number` VARCHAR(25) NOT NULL,
  `departure_time` DATETIME NOT NULL,
  `arrival_time` DATETIME NOT NULL,
  `distance_in_miles` INT NOT NULL,
  `flight_duration` INT NOT NULL,
  PRIMARY KEY (`flight_id`),
  UNIQUE INDEX `flight_number_UNIQUE` (`flight_number` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Flight_booking_system`.`tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Flight_booking_system`.`tickets` (
  `ticket_id` INT NOT NULL AUTO_INCREMENT,
  `flight_id` INT NOT NULL,
  `passenger_id` INT NOT NULL,
  `ticket_number` INT NOT NULL,
  `class` VARCHAR(25) NOT NULL,
  INDEX `fk_flights_has_passengers_passengers1_idx` (`passenger_id` ASC) VISIBLE,
  INDEX `fk_flights_has_passengers_flights_idx` (`flight_id` ASC) VISIBLE,
  PRIMARY KEY (`ticket_id`),
  CONSTRAINT `class_types` CHECK (`class` IN('economy', 'business', 'first')),
  CONSTRAINT `fk_flights_has_passengers_flights`
    FOREIGN KEY (`flight_id`)
    REFERENCES `Flight_booking_system`.`flights` (`flight_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_flights_has_passengers_passengers1`
    FOREIGN KEY (`passenger_id`)
    REFERENCES `Flight_booking_system`.`passengers` (`passenger_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Flight_booking_system`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Flight_booking_system`.`payments` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(9,2) NOT NULL,
  `date` DATETIME NOT NULL DEFAULT NOW(),
  `payment_method` VARCHAR(25) NOT NULL,
  `ticket_id` INT NOT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `fk_payments_tickets1_idx` (`ticket_id` ASC) VISIBLE,
  CONSTRAINT `payment_list` CHECK(`payment_method` IN('credit_card', 'debit_card', 'cash')),
  CONSTRAINT `fk_payments_tickets1`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `Flight_booking_system`.`tickets` (`ticket_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Flight_booking_system`.`airlines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Flight_booking_system`.`airlines` (
  `airline_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  `flight_id` INT NOT NULL,
  PRIMARY KEY (`airline_id`),
  INDEX `fk_airlines_flights1_idx` (`flight_id` ASC) VISIBLE,
  CONSTRAINT `fk_airlines_flights1`
    FOREIGN KEY (`flight_id`)
    REFERENCES `Flight_booking_system`.`flights` (`flight_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Flight_booking_system`.`aircrafts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Flight_booking_system`.`aircrafts` (
  `aircraft_id` INT NOT NULL AUTO_INCREMENT,
  `model` VARCHAR(25) NOT NULL,
  `capacity` INT NOT NULL,
  `airline_id` INT NOT NULL,
  PRIMARY KEY (`aircraft_id`),
  INDEX `fk_aircraft_airlines1_idx` (`airline_id` ASC) VISIBLE,
  CONSTRAINT `fk_aircraft_airlines1`
    FOREIGN KEY (`airline_id`)
    REFERENCES `Flight_booking_system`.`airlines` (`airline_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Flight_booking_system`.`airports`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Flight_booking_system`.`airports` (
  `airport_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  `code` INT NOT NULL,
  `country` VARCHAR(25) NOT NULL,
  `state` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`airport_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Flight_booking_system`.`airport_flights`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Flight_booking_system`.`airport_flights` (
  `airport_id` INT NOT NULL,
  `flight_id` INT NOT NULL,
  `flight_type` VARCHAR(25) NOT NULL,
  INDEX `fk_airports_has_flights_flights1_idx` (`flight_id` ASC) VISIBLE,
  INDEX `fk_airports_has_flights_airports1_idx` (`airport_id` ASC) VISIBLE,
  PRIMARY KEY (`airport_id`, `flight_id`),
  CONSTRAINT `flight_status` CHECK(`flight_type` IN('arrival', 'departure')),
  CONSTRAINT `fk_airports_has_flights_airports1`
    FOREIGN KEY (`airport_id`)
    REFERENCES `Flight_booking_system`.`airports` (`airport_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_airports_has_flights_flights1`
    FOREIGN KEY (`flight_id`)
    REFERENCES `Flight_booking_system`.`flights` (`flight_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Flight_booking_system`.`baggages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Flight_booking_system`.`baggages` (
  `baggage_id` INT NOT NULL AUTO_INCREMENT,
  `baggage_type` VARCHAR(25) NOT NULL,
  `weight_in_kg` INT NOT NULL,
  `ticket_id` INT NOT NULL,
  PRIMARY KEY (`baggage_id`),
  INDEX `fk_baggages_tickets1_idx` (`ticket_id` ASC) VISIBLE,
  CONSTRAINT `baggage_list` CHECK(`baggage_type` IN('carry_on', 'checked', 'hand', 'cabin')),
  CONSTRAINT `fk_baggages_tickets1`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `Flight_booking_system`.`tickets` (`ticket_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
