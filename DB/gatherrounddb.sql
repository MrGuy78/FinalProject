-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema gatherrounddb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `gatherrounddb` ;

-- -----------------------------------------------------
-- Schema gatherrounddb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `gatherrounddb` DEFAULT CHARACTER SET utf8 ;
USE `gatherrounddb` ;

-- -----------------------------------------------------
-- Table `group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group` ;

CREATE TABLE IF NOT EXISTS `group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT NULL,
  `category` VARCHAR(45) NULL,
  `image_url` VARCHAR(2000) NULL,
  `created_by` INT NULL,
  `create_date` DATETIME NULL,
  `last_update` DATETIME NULL,
  `active` TINYINT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(100) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(20) NULL,
  `profile_image_url` VARCHAR(2000) NULL,
  `bio` TEXT NULL,
  `role` VARCHAR(45) NULL,
  `enabled` TINYINT NOT NULL,
  `created_date` DATETIME NULL,
  `last_update` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `activity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `activity` ;

CREATE TABLE IF NOT EXISTS `activity` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `description` TEXT NOT NULL,
  `date_time` DATETIME NOT NULL,
  `image_url` VARCHAR(2000) NULL,
  `create_date` DATETIME NULL,
  `last_update` DATETIME NULL,
  `meet_location_url` VARCHAR(2000) NULL,
  `activity_location_url` VARCHAR(2000) NOT NULL,
  `cost` DOUBLE NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `leader`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `leader` ;

CREATE TABLE IF NOT EXISTS `leader` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS activitygroupie@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'activitygroupie'@'localhost' IDENTIFIED BY 'activitygroupie';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'activitygroupie'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `group`
-- -----------------------------------------------------
START TRANSACTION;
USE `gatherrounddb`;
INSERT INTO `group` (`id`, `name`, `description`, `category`, `image_url`, `created_by`, `create_date`, `last_update`, `active`) VALUES (1, 'Pickleball', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `gatherrounddb`;
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `profile_image_url`, `bio`, `role`, `enabled`, `created_date`, `last_update`) VALUES (1, 'pickleballPlaya', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Ben', 'Johnstun', 'ben@email.com', NULL, NULL, NULL, NULL, 1, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `activity`
-- -----------------------------------------------------
START TRANSACTION;
USE `gatherrounddb`;
INSERT INTO `activity` (`id`, `title`, `description`, `date_time`, `image_url`, `create_date`, `last_update`, `meet_location_url`, `activity_location_url`, `cost`) VALUES (1, '2x2 Pickleball', 'Come and play', '2025-2-25 10:30:00', NULL, NULL, NULL, NULL, 'https://www.google.com/maps/place/Pickleball+Courts/@40.0994869,-111.6662265,883m/data=!3m2!1e3!4b1!4m6!3m5!1s0x874dbd3d09506fcf:0x6ad8fd9414eebdd0!8m2!3d40.0994869!4d-111.6662265!16s%2Fg%2F11gxr4gcsc?entry=ttu&g_ep=EgoyMDI1MDIxMC4wIKXMDSoASAFQAw%3D%3D', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `leader`
-- -----------------------------------------------------
START TRANSACTION;
USE `gatherrounddb`;
INSERT INTO `leader` (`id`, `first_name`, `last_name`) VALUES (1, 'Ben', 'Johnstun');

COMMIT;

