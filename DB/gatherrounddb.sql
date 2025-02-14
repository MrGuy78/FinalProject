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
-- Table `address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `address` ;

CREATE TABLE IF NOT EXISTS `address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `address` VARCHAR(200) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zip` VARCHAR(12) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
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
  `image_url` VARCHAR(2000) NULL,
  `biography` TEXT NULL,
  `role` VARCHAR(45) NULL,
  `enabled` TINYINT NULL,
  `create_date` DATETIME NULL,
  `last_update` DATETIME NULL,
  `address_id` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  INDEX `fk_user_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group_category` ;

CREATE TABLE IF NOT EXISTS `group_category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  `image_url` VARCHAR(2000) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `social_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `social_group` ;

CREATE TABLE IF NOT EXISTS `social_group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT NULL,
  `image_url` VARCHAR(2000) NULL,
  `create_date` DATETIME NULL,
  `last_update` DATETIME NULL,
  `enabled` TINYINT NULL,
  `owner_id` INT NOT NULL,
  `group_category_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  INDEX `fk_social_group_user1_idx` (`owner_id` ASC) VISIBLE,
  INDEX `fk_social_group_group_category1_idx` (`group_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_social_group_user1`
    FOREIGN KEY (`owner_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_social_group_group_category1`
    FOREIGN KEY (`group_category_id`)
    REFERENCES `group_category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `social_event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `social_event` ;

CREATE TABLE IF NOT EXISTS `social_event` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `description` TEXT NOT NULL,
  `event_date` DATE NOT NULL,
  `start_time` TIME NOT NULL,
  `end_time` TIME NULL,
  `image_url` VARCHAR(2000) NULL,
  `create_date` DATETIME NULL,
  `last_update` DATETIME NULL,
  `cost` DECIMAL(5,2) NULL,
  `enabled` TINYINT NULL,
  `member_only` TINYINT NULL,
  `meet_address_id` INT NOT NULL,
  `event_address_id` INT NULL,
  `social_group_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_event_meet_location_idx` (`meet_address_id` ASC) VISIBLE,
  INDEX `fk_social_event_address1_idx` (`event_address_id` ASC) VISIBLE,
  INDEX `fk_social_event_social_group1_idx` (`social_group_id` ASC) VISIBLE,
  INDEX `fk_social_event_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_event_meet_location`
    FOREIGN KEY (`meet_address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_social_event_address1`
    FOREIGN KEY (`event_address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_social_event_social_group1`
    FOREIGN KEY (`social_group_id`)
    REFERENCES `social_group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_social_event_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group_user` ;

CREATE TABLE IF NOT EXISTS `group_user` (
  `user_id` INT NOT NULL,
  `group_id` INT NOT NULL,
  `approved` TINYINT NULL,
  `create_date` DATETIME NULL,
  `approved_date` DATETIME NULL,
  `leader` TINYINT NULL,
  PRIMARY KEY (`user_id`, `group_id`),
  INDEX `fk_group_user_group1_idx` (`group_id` ASC) VISIBLE,
  CONSTRAINT `fk_group_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_group_user_group1`
    FOREIGN KEY (`group_id`)
    REFERENCES `social_group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `event_comment` ;

CREATE TABLE IF NOT EXISTS `event_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comment` TEXT NOT NULL,
  `create_date` DATETIME NULL,
  `last_update` DATETIME NULL,
  `enabled` TINYINT NULL,
  `user_id` INT NOT NULL,
  `event_id` INT NOT NULL,
  `in_reply_to_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_event_comment_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_event_comment_event1_idx` (`event_id` ASC) VISIBLE,
  INDEX `fk_event_comment_event_comment1_idx` (`in_reply_to_id` ASC) VISIBLE,
  CONSTRAINT `fk_event_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_comment_event1`
    FOREIGN KEY (`event_id`)
    REFERENCES `social_event` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_comment_event_comment1`
    FOREIGN KEY (`in_reply_to_id`)
    REFERENCES `event_comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group_comment` ;

CREATE TABLE IF NOT EXISTS `group_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comment` TEXT NOT NULL,
  `create_date` DATETIME NULL,
  `last_update` DATETIME NULL,
  `enabled` TINYINT NULL,
  `user_id` INT NOT NULL,
  `group_id` INT NOT NULL,
  `in_reply_to_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_event_comment_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_group_comment_group1_idx` (`group_id` ASC) VISIBLE,
  INDEX `fk_group_comment_group_comment1_idx` (`in_reply_to_id` ASC) VISIBLE,
  CONSTRAINT `fk_event_comment_user10`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_group_comment_group1`
    FOREIGN KEY (`group_id`)
    REFERENCES `social_group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_group_comment_group_comment1`
    FOREIGN KEY (`in_reply_to_id`)
    REFERENCES `group_comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `event_user` ;

CREATE TABLE IF NOT EXISTS `event_user` (
  `user_id` INT NOT NULL,
  `event_id` INT NOT NULL,
  `attending` TINYINT NULL,
  `create_date` DATETIME NULL,
  `rating` INT NULL,
  `remarks` TEXT NULL,
  PRIMARY KEY (`user_id`, `event_id`),
  INDEX `fk_group_user_copy1_event1_idx` (`event_id` ASC) VISIBLE,
  CONSTRAINT `fk_group_user_user10`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_group_user_copy1_event1`
    FOREIGN KEY (`event_id`)
    REFERENCES `social_event` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `event_image` ;

CREATE TABLE IF NOT EXISTS `event_image` (
  `id` INT NOT NULL,
  `image_url` VARCHAR(2000) NULL,
  `caption` VARCHAR(45) NULL,
  `create_date` DATETIME NULL,
  `social_event_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_event_image_social_event1_idx` (`social_event_id` ASC) VISIBLE,
  INDEX `fk_event_image_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_event_image_social_event1`
    FOREIGN KEY (`social_event_id`)
    REFERENCES `social_event` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_image_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `direct_message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `direct_message` ;

CREATE TABLE IF NOT EXISTS `direct_message` (
  `id` INT NOT NULL,
  `comment` TEXT NULL,
  `create_date` DATETIME NULL,
  `sender_id` INT NOT NULL,
  `recipient_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_direct_message_user1_idx` (`sender_id` ASC) VISIBLE,
  INDEX `fk_direct_message_user2_idx` (`recipient_id` ASC) VISIBLE,
  CONSTRAINT `fk_direct_message_user1`
    FOREIGN KEY (`sender_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_direct_message_user2`
    FOREIGN KEY (`recipient_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
-- Data for table `address`
-- -----------------------------------------------------
START TRANSACTION;
USE `gatherrounddb`;
INSERT INTO `address` (`id`, `name`, `address`, `city`, `state`, `zip`) VALUES (1, 'Spanish Fork Pickleball Courts', '701 W Park Dr', 'Spanish Fork', 'Utah', '84660');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `gatherrounddb`;
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (1, 'pickleballPat', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Ben', 'Johnstun', 'ben@email.com', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (2, 'discoDeb', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Debra', 'Kramer', 'deb@email.com', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `group_category`
-- -----------------------------------------------------
START TRANSACTION;
USE `gatherrounddb`;
INSERT INTO `group_category` (`id`, `name`, `description`, `image_url`) VALUES (1, 'Sports', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `social_group`
-- -----------------------------------------------------
START TRANSACTION;
USE `gatherrounddb`;
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (1, 'Pickleball', NULL, NULL, NULL, NULL, 1, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `social_event`
-- -----------------------------------------------------
START TRANSACTION;
USE `gatherrounddb`;
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (1, '2x2 Pickleball', 'Come and play', '2025-2-25 10:30:00', '10:00:10', NULL, NULL, NULL, NULL, 0.00, 1, 1, 1, 1, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `group_user`
-- -----------------------------------------------------
START TRANSACTION;
USE `gatherrounddb`;
INSERT INTO `group_user` (`user_id`, `group_id`, `approved`, `create_date`, `approved_date`, `leader`) VALUES (1, 1, 1, '2025-1-23', '2025-1-24', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `event_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `gatherrounddb`;
INSERT INTO `event_comment` (`id`, `comment`, `create_date`, `last_update`, `enabled`, `user_id`, `event_id`, `in_reply_to_id`) VALUES (1, 'Great courts and we had a lot of fun!', NULL, NULL, 1, 1, 1, NULL);
INSERT INTO `event_comment` (`id`, `comment`, `create_date`, `last_update`, `enabled`, `user_id`, `event_id`, `in_reply_to_id`) VALUES (2, 'Great to meet you ', NULL, NULL, 1, 2, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `group_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `gatherrounddb`;
INSERT INTO `group_comment` (`id`, `comment`, `create_date`, `last_update`, `enabled`, `user_id`, `group_id`, `in_reply_to_id`) VALUES (1, 'Hey group', NULL, NULL, 1, 1, 1, NULL);
INSERT INTO `group_comment` (`id`, `comment`, `create_date`, `last_update`, `enabled`, `user_id`, `group_id`, `in_reply_to_id`) VALUES (2, 'Welcome', NULL, NULL, 1, 2, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `event_user`
-- -----------------------------------------------------
START TRANSACTION;
USE `gatherrounddb`;
INSERT INTO `event_user` (`user_id`, `event_id`, `attending`, `create_date`, `rating`, `remarks`) VALUES (1, 1, 1, '2025-1-23', 7, 'Great time');

COMMIT;


-- -----------------------------------------------------
-- Data for table `event_image`
-- -----------------------------------------------------
START TRANSACTION;
USE `gatherrounddb`;
INSERT INTO `event_image` (`id`, `image_url`, `caption`, `create_date`, `social_event_id`, `user_id`) VALUES (1, NULL, NULL, NULL, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `direct_message`
-- -----------------------------------------------------
START TRANSACTION;
USE `gatherrounddb`;
INSERT INTO `direct_message` (`id`, `comment`, `create_date`, `sender_id`, `recipient_id`) VALUES (1, NULL, NULL, 1, 2);
INSERT INTO `direct_message` (`id`, `comment`, `create_date`, `sender_id`, `recipient_id`) VALUES (2, NULL, NULL, 2, 1);

COMMIT;

