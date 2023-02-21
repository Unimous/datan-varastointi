-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema company
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema company
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `company` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `company` ;

-- -----------------------------------------------------
-- Table `company`.`employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `company`.`employee` ;

CREATE TABLE IF NOT EXISTS `company`.`employee` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(32) NULL DEFAULT NULL,
  `lname` VARCHAR(64) NULL DEFAULT NULL,
  `salary` DOUBLE NULL DEFAULT NULL,
  `bdate` DATE NULL DEFAULT NULL,
  `email` VARCHAR(64) NULL DEFAULT NULL,
  `department_id` INT NULL DEFAULT NULL,
  `phone1` VARCHAR(32) NULL DEFAULT NULL,
  `phone2` VARCHAR(32) NULL DEFAULT NULL,
  `image` VARCHAR(255) NULL DEFAULT NULL,
  `supervisor_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `emp_PK` (`id` ASC),
  INDEX `dep_FK` (`department_id` ASC),
  INDEX `fk_employee_employee1_idx` (`supervisor_id` ASC),
  CONSTRAINT `employee_ibfk_1`
    FOREIGN KEY (`department_id`)
    REFERENCES `company`.`department` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_employee_employee1`
    FOREIGN KEY (`supervisor_id`)
    REFERENCES `company`.`employee` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `company`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `company`.`department` ;

CREATE TABLE IF NOT EXISTS `company`.`department` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(32) NULL DEFAULT NULL,
  `manager_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `Osasto_PK` (`id` ASC),
  INDEX `fk_department_employee1_idx` (`manager_id` ASC),
  CONSTRAINT `fk_department_employee1`
    FOREIGN KEY (`manager_id`)
    REFERENCES `company`.`employee` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `company`.`dependent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `company`.`dependent` ;

CREATE TABLE IF NOT EXISTS `company`.`dependent` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `bdate` DATE NULL DEFAULT NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`id`, `employee_id`),
  INDEX `fk_dependent_employee1_idx` (`employee_id` ASC),
  CONSTRAINT `fk_dependent_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `company`.`employee` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `company`.`part`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `company`.`part` ;

CREATE TABLE IF NOT EXISTS `company`.`part` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `company`.`part_of`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `company`.`part_of` ;

CREATE TABLE IF NOT EXISTS `company`.`part_of` (
  `part_id` INT NOT NULL,
  `compart_id` INT NOT NULL,
  `quantity` INT NULL DEFAULT NULL,
  PRIMARY KEY (`part_id`, `compart_id`),
  INDEX `fk_part_part_part2_idx` (`compart_id` ASC),
  INDEX `fk_part_part_part1_idx` (`part_id` ASC),
  CONSTRAINT `fk_part_part_part1`
    FOREIGN KEY (`part_id`)
    REFERENCES `company`.`part` (`id`),
  CONSTRAINT `fk_part_part_part2`
    FOREIGN KEY (`compart_id`)
    REFERENCES `company`.`part` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `company`.`project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `company`.`project` ;

CREATE TABLE IF NOT EXISTS `company`.`project` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NULL DEFAULT NULL,
  `manager_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `project_PK` (`id` ASC),
  INDEX `project_FK` (`manager_id` ASC),
  CONSTRAINT `project_ibfk_1`
    FOREIGN KEY (`manager_id`)
    REFERENCES `company`.`employee` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `company`.`supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `company`.`supplier` ;

CREATE TABLE IF NOT EXISTS `company`.`supplier` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `company`.`supply`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `company`.`supply` ;

CREATE TABLE IF NOT EXISTS `company`.`supply` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `project_id` INT NULL DEFAULT NULL,
  `part_id` INT NULL DEFAULT NULL,
  `supplier_id` INT NULL DEFAULT NULL,
  `quantity` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_project_part_part1_idx` (`part_id` ASC),
  INDEX `fk_project_part_project1_idx` (`project_id` ASC),
  INDEX `fk_project_part_supplier1_idx` (`supplier_id` ASC),
  CONSTRAINT `fk_project_part_part1`
    FOREIGN KEY (`part_id`)
    REFERENCES `company`.`part` (`id`),
  CONSTRAINT `fk_project_part_project1`
    FOREIGN KEY (`project_id`)
    REFERENCES `company`.`project` (`id`),
  CONSTRAINT `fk_project_part_supplier1`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `company`.`supplier` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `company`.`works_on`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `company`.`works_on` ;

CREATE TABLE IF NOT EXISTS `company`.`works_on` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT NULL DEFAULT NULL,
  `project_id` INT NULL DEFAULT NULL,
  `hours` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `emp_FK_1` (`id` ASC),
  INDEX `eid` (`employee_id` ASC),
  INDEX `Pro_FK` (`project_id` ASC),
  CONSTRAINT `works_on_ibfk_1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `company`.`employee` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `works_on_ibfk_2`
    FOREIGN KEY (`project_id`)
    REFERENCES `company`.`project` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Data for table `employee`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `employee` (`id`, `fname`, `lname`, `salary`, `bdate`, `email`, `department_id`, `phone1`, `phone2`, `image`, `supervisor_id`) VALUES (DEFAULT, 'Iso', 'Pomo', 10000, '1952-1-1', 'iso.pomo@firma.fi', 1, '342342343', '342342344', NULL, 1);
INSERT INTO `employee` (`id`, `fname`, `lname`, `salary`, `bdate`, `email`, `department_id`, `phone1`, `phone2`, `image`, `supervisor_id`) VALUES (DEFAULT, 'Make', 'Myyjä', 2500, '1956-6-16', 'make.myyja@firma.fi', 2, '434234222', '678674865', NULL, 10);
INSERT INTO `employee` (`id`, `fname`, `lname`, `salary`, `bdate`, `email`, `department_id`, `phone1`, `phone2`, `image`, `supervisor_id`) VALUES (DEFAULT, 'Maiju', 'Myyjä', 2500, '1960-4-1', 'maiju.myyja@firma.fi', 2, '453454333', NULL, NULL, 2);
INSERT INTO `employee` (`id`, `fname`, `lname`, `salary`, `bdate`, `email`, `department_id`, `phone1`, `phone2`, `image`, `supervisor_id`) VALUES (DEFAULT, 'Mike', 'Markkinoija', 3000, '1970-6-19', 'mike.markkinoija@firma.fi', 3, '546456456', '786765688', NULL, 10);
INSERT INTO `employee` (`id`, `fname`, `lname`, `salary`, `bdate`, `email`, `department_id`, `phone1`, `phone2`, `image`, `supervisor_id`) VALUES (DEFAULT, 'Masa', 'Markkina', 3000, '1967-4-1', 'masa.markkina@firma.fi', 3, '345534574', NULL, NULL, 3);
INSERT INTO `employee` (`id`, `fname`, `lname`, `salary`, `bdate`, `email`, `department_id`, `phone1`, `phone2`, `image`, `supervisor_id`) VALUES (DEFAULT, 'Tiina', 'Tuote', 2500, '1955-5-25', 'tiina.tuote@firma.fi', 4, '564527534', NULL, NULL, 8);
INSERT INTO `employee` (`id`, `fname`, `lname`, `salary`, `bdate`, `email`, `department_id`, `phone1`, `phone2`, `image`, `supervisor_id`) VALUES (DEFAULT, 'Taisto', 'Tähdellinen', 2800, '1951-11-11', 'taisto.tahdellinen@firma.fi', 4, '645364533', NULL, NULL, 8);
INSERT INTO `employee` (`id`, `fname`, `lname`, `salary`, `bdate`, `email`, `department_id`, `phone1`, `phone2`, `image`, `supervisor_id`) VALUES (DEFAULT, 'Jaana', 'Jämäkkä', 3250, '1969-6-1', 'jaana.jamakka@firma.fi', 4, '634675675', '867877775', NULL, 10);
INSERT INTO `employee` (`id`, `fname`, `lname`, `salary`, `bdate`, `email`, `department_id`, `phone1`, `phone2`, `image`, `supervisor_id`) VALUES (DEFAULT, 'Ismo', 'Insinööri', 2900, '1970-6-2', 'ismo.insinoori@firma.fi', 4, '654368568', NULL, NULL, 8);
INSERT INTO `employee` (`id`, `fname`, `lname`, `salary`, `bdate`, `email`, `department_id`, `phone1`, `phone2`, `image`, `supervisor_id`) VALUES (DEFAULT, 'Peke', 'Pomo', 5900, '1973-1-15', 'peke.pomo@firma.fi', 1, '645368563', '454567567', NULL, 1);
INSERT INTO `employee` (`id`, `fname`, `lname`, `salary`, `bdate`, `email`, `department_id`, `phone1`, `phone2`, `image`, `supervisor_id`) VALUES (DEFAULT, 'Taavi', 'Tanakka', 2300, '1985-3-3', 'taavi.tanakka@firma.fi', 5, '674657262', NULL, NULL, 14);
INSERT INTO `employee` (`id`, `fname`, `lname`, `salary`, `bdate`, `email`, `department_id`, `phone1`, `phone2`, `image`, `supervisor_id`) VALUES (DEFAULT, 'Maija', 'Mainio', 2600, '1965-7-6', 'maija.mainio@firma.fi', 5, '634667867', NULL, NULL, 14);
INSERT INTO `employee` (`id`, `fname`, `lname`, `salary`, `bdate`, `email`, `department_id`, `phone1`, `phone2`, `image`, `supervisor_id`) VALUES (DEFAULT, 'Mikko', 'Meikäläinen', 2500, '1986-3-21', 'mikko.meikalainen@firma.fi', 5, '456446777', NULL, NULL, 14);
INSERT INTO `employee` (`id`, `fname`, `lname`, `salary`, `bdate`, `email`, `department_id`, `phone1`, `phone2`, `image`, `supervisor_id`) VALUES (DEFAULT, 'Satu', 'Särmä', 2700, '1973-3-2', 'satu.sarma@firma.fi', 5, '626767655', '786787664', NULL, 10);
INSERT INTO `employee` (`id`, `fname`, `lname`, `salary`, `bdate`, `email`, `department_id`, `phone1`, `phone2`, `image`, `supervisor_id`) VALUES (DEFAULT, 'Heikki', 'Häijy', 2600, '1951-11-11', 'heikki.haijy@firma.fi', 5, '787686755', NULL, NULL, 14);

COMMIT;


-- -----------------------------------------------------
-- Data for table `department`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `department` (`id`, `name`, `manager_id`) VALUES (DEFAULT, 'Johtoporras', 1);
INSERT INTO `department` (`id`, `name`, `manager_id`) VALUES (DEFAULT, 'Myynti', 2);
INSERT INTO `department` (`id`, `name`, `manager_id`) VALUES (DEFAULT, 'Markkinointi', 4);
INSERT INTO `department` (`id`, `name`, `manager_id`) VALUES (DEFAULT, 'Tuotekehitys', 8);
INSERT INTO `department` (`id`, `name`, `manager_id`) VALUES (DEFAULT, 'Tuotanto', 14);

COMMIT;


-- -----------------------------------------------------
-- Data for table `dependent`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `dependent` (`id`, `name`, `bdate`, `employee_id`) VALUES (DEFAULT, 'Matti', '2000-01-12', 2);
INSERT INTO `dependent` (`id`, `name`, `bdate`, `employee_id`) VALUES (DEFAULT, 'Maija', '2002-04-13', 2);
INSERT INTO `dependent` (`id`, `name`, `bdate`, `employee_id`) VALUES (DEFAULT, 'Pertti', '2005-10-4', 3);
INSERT INTO `dependent` (`id`, `name`, `bdate`, `employee_id`) VALUES (DEFAULT, 'Liisa', '2010-4-23', 4);
INSERT INTO `dependent` (`id`, `name`, `bdate`, `employee_id`) VALUES (DEFAULT, 'Martta', '2001-09-03', 3);
INSERT INTO `dependent` (`id`, `name`, `bdate`, `employee_id`) VALUES (DEFAULT, 'Matti', '2002-02-02', 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `part`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `part` (`id`, `name`) VALUES (DEFAULT, 'Peruskone');
INSERT INTO `part` (`id`, `name`) VALUES (DEFAULT, 'SuperMylly');
INSERT INTO `part` (`id`, `name`) VALUES (DEFAULT, 'Emolevy Z1');
INSERT INTO `part` (`id`, `name`) VALUES (DEFAULT, 'Emolevy Z2');
INSERT INTO `part` (`id`, `name`) VALUES (DEFAULT, 'Muistikampa 4 Gb');
INSERT INTO `part` (`id`, `name`) VALUES (DEFAULT, 'Muistikampa 8 Gb');
INSERT INTO `part` (`id`, `name`) VALUES (DEFAULT, 'Kovalevy 1000');
INSERT INTO `part` (`id`, `name`) VALUES (DEFAULT, 'Kovalevy SSD 512');
INSERT INTO `part` (`id`, `name`) VALUES (DEFAULT, 'Kotelo X1');
INSERT INTO `part` (`id`, `name`) VALUES (DEFAULT, 'Kotelo X2');

COMMIT;


-- -----------------------------------------------------
-- Data for table `part_of`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `part_of` (`part_id`, `compart_id`, `quantity`) VALUES (1, 4, 1);
INSERT INTO `part_of` (`part_id`, `compart_id`, `quantity`) VALUES (2, 3, 1);
INSERT INTO `part_of` (`part_id`, `compart_id`, `quantity`) VALUES (1, 5, 2);
INSERT INTO `part_of` (`part_id`, `compart_id`, `quantity`) VALUES (2, 6, 4);
INSERT INTO `part_of` (`part_id`, `compart_id`, `quantity`) VALUES (1, 7, 1);
INSERT INTO `part_of` (`part_id`, `compart_id`, `quantity`) VALUES (2, 7, 1);
INSERT INTO `part_of` (`part_id`, `compart_id`, `quantity`) VALUES (2, 8, 1);
INSERT INTO `part_of` (`part_id`, `compart_id`, `quantity`) VALUES (1, 10, 1);
INSERT INTO `part_of` (`part_id`, `compart_id`, `quantity`) VALUES (2, 9, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `project`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `project` (`id`, `name`, `manager_id`) VALUES (DEFAULT, 'SuperMylly', 8);
INSERT INTO `project` (`id`, `name`, `manager_id`) VALUES (DEFAULT, 'Peruskone', 10);
INSERT INTO `project` (`id`, `name`, `manager_id`) VALUES (DEFAULT, 'DesignMylly', 10);
INSERT INTO `project` (`id`, `name`, `manager_id`) VALUES (DEFAULT, 'HyperMylly', 14);
INSERT INTO `project` (`id`, `name`, `manager_id`) VALUES (DEFAULT, 'Pelikone', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `supplier`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `supplier` (`id`, `name`) VALUES (DEFAULT, 'Möttösen Toimitus Oy');
INSERT INTO `supplier` (`id`, `name`) VALUES (DEFAULT, 'Varma Toimitus Ky');
INSERT INTO `supplier` (`id`, `name`) VALUES (DEFAULT, 'Ekselent Oy');
INSERT INTO `supplier` (`id`, `name`) VALUES (DEFAULT, 'Oy Yhtyneet Toimittajat Ab');
INSERT INTO `supplier` (`id`, `name`) VALUES (DEFAULT, 'Pientä Laittoa Ky');

COMMIT;


-- -----------------------------------------------------
-- Data for table `supply`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `supply` (`id`, `project_id`, `part_id`, `supplier_id`, `quantity`) VALUES (DEFAULT, 1, 3, 1, 30);
INSERT INTO `supply` (`id`, `project_id`, `part_id`, `supplier_id`, `quantity`) VALUES (DEFAULT, 2, 4, 1, 50);
INSERT INTO `supply` (`id`, `project_id`, `part_id`, `supplier_id`, `quantity`) VALUES (DEFAULT, 1, 6, 1, 100);
INSERT INTO `supply` (`id`, `project_id`, `part_id`, `supplier_id`, `quantity`) VALUES (DEFAULT, 2, 5, 1, 100);
INSERT INTO `supply` (`id`, `project_id`, `part_id`, `supplier_id`, `quantity`) VALUES (DEFAULT, 1, 7, 1, 150);
INSERT INTO `supply` (`id`, `project_id`, `part_id`, `supplier_id`, `quantity`) VALUES (DEFAULT, 2, 7, 1, 150);
INSERT INTO `supply` (`id`, `project_id`, `part_id`, `supplier_id`, `quantity`) VALUES (DEFAULT, 1, 8, 1, 50);
INSERT INTO `supply` (`id`, `project_id`, `part_id`, `supplier_id`, `quantity`) VALUES (DEFAULT, 1, 9, 2, 50);
INSERT INTO `supply` (`id`, `project_id`, `part_id`, `supplier_id`, `quantity`) VALUES (DEFAULT, 1, 9, 3, 70);
INSERT INTO `supply` (`id`, `project_id`, `part_id`, `supplier_id`, `quantity`) VALUES (DEFAULT, 2, 10, 2, 100);
INSERT INTO `supply` (`id`, `project_id`, `part_id`, `supplier_id`, `quantity`) VALUES (DEFAULT, 2, 10, 3, 150);
INSERT INTO `supply` (`id`, `project_id`, `part_id`, `supplier_id`, `quantity`) VALUES (DEFAULT, 1, 3, 2, 200);
INSERT INTO `supply` (`id`, `project_id`, `part_id`, `supplier_id`, `quantity`) VALUES (DEFAULT, 1, 6, 3, 100);
INSERT INTO `supply` (`id`, `project_id`, `part_id`, `supplier_id`, `quantity`) VALUES (DEFAULT, 2, 7, 2, 150);

COMMIT;


-- -----------------------------------------------------
-- Data for table `works_on`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `works_on` (`id`, `employee_id`, `project_id`, `hours`) VALUES (DEFAULT, 3, 1, 3);
INSERT INTO `works_on` (`id`, `employee_id`, `project_id`, `hours`) VALUES (DEFAULT, 3, 2, 4);
INSERT INTO `works_on` (`id`, `employee_id`, `project_id`, `hours`) VALUES (DEFAULT, 4, 2, 3);
INSERT INTO `works_on` (`id`, `employee_id`, `project_id`, `hours`) VALUES (DEFAULT, 4, 1, 1);
INSERT INTO `works_on` (`id`, `employee_id`, `project_id`, `hours`) VALUES (DEFAULT, 5, 3, 2);
INSERT INTO `works_on` (`id`, `employee_id`, `project_id`, `hours`) VALUES (DEFAULT, 5, 4, 5);
INSERT INTO `works_on` (`id`, `employee_id`, `project_id`, `hours`) VALUES (DEFAULT, 6, 3, 4);
INSERT INTO `works_on` (`id`, `employee_id`, `project_id`, `hours`) VALUES (DEFAULT, 6, 4, 3);
INSERT INTO `works_on` (`id`, `employee_id`, `project_id`, `hours`) VALUES (DEFAULT, 7, 2, 4);
INSERT INTO `works_on` (`id`, `employee_id`, `project_id`, `hours`) VALUES (DEFAULT, 8, 3, 7);
INSERT INTO `works_on` (`id`, `employee_id`, `project_id`, `hours`) VALUES (DEFAULT, 9, 2, 3);
INSERT INTO `works_on` (`id`, `employee_id`, `project_id`, `hours`) VALUES (DEFAULT, 9, 4, 4);
INSERT INTO `works_on` (`id`, `employee_id`, `project_id`, `hours`) VALUES (DEFAULT, 10, 3, 1);
INSERT INTO `works_on` (`id`, `employee_id`, `project_id`, `hours`) VALUES (DEFAULT, 10, 2, 2);
INSERT INTO `works_on` (`id`, `employee_id`, `project_id`, `hours`) VALUES (DEFAULT, 10, 1, 4);
INSERT INTO `works_on` (`id`, `employee_id`, `project_id`, `hours`) VALUES (DEFAULT, 11, 1, 7);
INSERT INTO `works_on` (`id`, `employee_id`, `project_id`, `hours`) VALUES (DEFAULT, 12, 2, 7);
INSERT INTO `works_on` (`id`, `employee_id`, `project_id`, `hours`) VALUES (DEFAULT, 13, 3, 7);
INSERT INTO `works_on` (`id`, `employee_id`, `project_id`, `hours`) VALUES (DEFAULT, 14, 4, 7);

COMMIT;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
