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
  `enabled` TINYINT NULL,
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
  `id` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT NULL,
  `image_url` VARCHAR(2000) NULL,
  `create_date` DATETIME NULL,
  `last_update` DATETIME NULL,
  `enabled` TINYINT NULL,
  `owner_id` INT NOT NULL,
  `group_category_id` INT NOT NULL AUTO_INCREMENT,
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
INSERT INTO `address` (`id`, `name`, `address`, `city`, `state`, `zip`, `enabled`) VALUES (1, 'Spanish Fork Pickleball Courts', '701 W Park Dr', 'Spanish Fork', 'Utah', '84660', 1);
INSERT INTO `address` (`id`, `name`, `address`, `city`, `state`, `zip`, `enabled`) VALUES (2, 'Peak Nights Dance Hall', '505 E 1860 S', 'Provo', 'Utah', '84606', 1);
INSERT INTO `address` (`id`, `name`, `address`, `city`, `state`, `zip`, `enabled`) VALUES (3, 'Game Grid', '400 Millpond Dr #F', 'Lehi', 'Utah', '84043', 1);
INSERT INTO `address` (`id`, `name`, `address`, `city`, `state`, `zip`, `enabled`) VALUES (4, 'WeWork', '1633 W Innovation Way 5th Floor', 'Lehi', 'Utah', '84043', 1);
INSERT INTO `address` (`id`, `name`, `address`, `city`, `state`, `zip`, `enabled`) VALUES (5, 'Denver Community Recreation', '1849 Emerson St', 'Denver', 'Colorado', '80218', 1);
INSERT INTO `address` (`id`, `name`, `address`, `city`, `state`, `zip`, `enabled`) VALUES (6, 'Scheels Sandy', '11282 S State St', 'Sandy', 'Utah', '84070', 1);
INSERT INTO `address` (`id`, `name`, `address`, `city`, `state`, `zip`, `enabled`) VALUES (7, 'Denver City Park', '2001 Colorado Blvd', 'Denver', 'Colorado', '80205', 1);
INSERT INTO `address` (`id`, `name`, `address`, `city`, `state`, `zip`, `enabled`) VALUES (8, 'Mandalay Bay', '3950 S Las Vegas Blvd', 'Las Vegas', 'Nevada', '89119', 1);
INSERT INTO `address` (`id`, `name`, `address`, `city`, `state`, `zip`, `enabled`) VALUES (9, 'My Little Paintbrush', '102 W Main St', 'Lehi', 'Utah', '84043', 1);
INSERT INTO `address` (`id`, `name`, `address`, `city`, `state`, `zip`, `enabled`) VALUES (10, 'Discovery Park', '1511 N 100 E', 'Pleasant Grove', 'Utah', '84062', 1);
INSERT INTO `address` (`id`, `name`, `address`, `city`, `state`, `zip`, `enabled`) VALUES (11, 'Westminster Hills Off-Leash Area', '10499 Simms St', 'Westminster', 'Colorado', '80005', 1);
INSERT INTO `address` (`id`, `name`, `address`, `city`, `state`, `zip`, `enabled`) VALUES (12, 'YogaSix Edgewater', '5471 W 20th Ave', 'Edgewater', 'Colorado', '80214', 1);
INSERT INTO `address` (`id`, `name`, `address`, `city`, `state`, `zip`, `enabled`) VALUES (13, 'Dough Counter Pizza\n', '2466 S Colorado Blvd Unit 101', 'Denver', 'Colorado', '80222', 1);
INSERT INTO `address` (`id`, `name`, `address`, `city`, `state`, `zip`, `enabled`) VALUES (14, 'Tabitha\'s Way Food Pantry', '45 E 100 N', 'Spanish Fork', 'Utah', '84660', 1);
INSERT INTO `address` (`id`, `name`, `address`, `city`, `state`, `zip`, `enabled`) VALUES (15, 'Pikes Peak Library', '5550 N Union Blvd', 'Colorado Springs', 'Colorado', '80918', 1);
INSERT INTO `address` (`id`, `name`, `address`, `city`, `state`, `zip`, `enabled`) VALUES (16, 'Strawberry Resovoir', '1555 Strawberry Bay Road', 'Heber City', 'Utah', '84032', 1);
INSERT INTO `address` (`id`, `name`, `address`, `city`, `state`, `zip`, `enabled`) VALUES (17, 'Utah Whitewater Gear', '7307 S State St', 'Midvale', 'Utah', '84047', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `gatherrounddb`;
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (1, 'pickleballPat', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Patrick', 'Johnstun', 'ben@email.com', '555-985-6482', 'https://leadershipcircle.com/wp-content/uploads/2022/07/Mark-Burrell.png', 'My name is Pat and I try to play pickleball at least twice a week. I would consider myself on the more skilled side.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (2, 'dancingDeb', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Debra', 'Kramer', 'deb@email.com', '555-985-6251', 'https://leadershipcircle.com/wp-content/uploads/2025/01/Shawn-Snelgrove_2022.png', 'My name is Debra (call me Deb) and I love to dance, especially the disco because it takes me WAY back.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (3, 'boardGameGreg', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Greg', 'MacArthur', 'greg@email.com', '555-265-1487', 'https://leadershipcircle.com/wp-content/uploads/2024/07/Gil-Jose-Manuel.png', 'My name is Greg and I am a board game nerd. I play all different kinds of games and like to have group games where 3-6 of us play. I have started a few game groups on here so check them out and request to join the group and I will be happy to approve fellow gamers.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (4, 'coderCory', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Cory', 'Hunt', 'cory@email.com', '555-958-7421', 'https://leadershipcircle.com/wp-content/uploads/2023/07/Matt-Ingersole-1b.png', 'Hi, I\'m Cory and I am a full-stack Java developer looking to meet up with other coders to learn and share ideas.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (5, 'swimmerSara', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Sara', 'Burke', 'sara@email.com', '555-485-2584', 'https://leadershipcircle.com/wp-content/uploads/2022/07/Betsy-Leatherman-8.png', 'Hello, my name is Sara and I love to swim. It would be great to find some friends on here who also enjoy swimming.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (6, 'hikingHenry', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Henry', 'Clyde', 'henry@email.com', '555-695-3284', 'https://leadershipcircle.com/wp-content/uploads/2025/01/Franklin-Bobga-Headshot.png', 'Hello, I\'m Henry and I have hiked Everest, Kilimanjaro, and Mt. Whitney. I would like to meet other hikers and go explore nature. ', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (7, 'walkingWhitney', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Whitney', 'Fleming', 'whitney@email.com', '555-425-8562', 'https://leadershipcircle.com/wp-content/uploads/2025/01/Lauren-Condie.png', 'Whitney here. I have been a part of many walking groups and just moved to the area. I would love to find some ladies to walk with.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (8, 'concertCarly', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Carly', 'Abbott', 'carly@email.com', '555-625-8521', 'https://leadershipcircle.com/wp-content/uploads/2025/01/Miranda-Dunn.png', 'Hello, Carly here. I have been to many concerts and really enjoy them, whether they are inside or outside, rock or jazz, I love them all.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (9, 'artsyAmy', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Amy', 'Walton', 'amy@email.com', '555-520-9658', 'https://leadershipcircle.com/wp-content/uploads/2025/01/Jeri-Gilbert-2.png', 'Hi, I\'m Amy and I love to draw and paint. I enjoy all things art.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (10, 'playDatePenny', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Penny', 'Jackson', 'penny@email.com', '555-965-3265', 'https://leadershipcircle.com/wp-content/uploads/2025/01/Corie-Walch.png', 'Penny here. I am a Mom of 3 kiddos and would like to meet other Moms who want to chat at the park or splash pad while the kids play.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (11, 'dogParkDave', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Dave', 'Walters', 'dave@email.com', '555-854-2154', 'https://leadershipcircle.com/wp-content/uploads/2022/07/Paul-Byrne-23.png', 'Dave here. I foster dogs and they love to go to the park. I would enjoy meeting up with other dog lovers at the local parks.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (12, 'yogaYolanda', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Yolanda', 'Rivera', 'yolanda@email.com', '555-635-5687', 'https://leadershipcircle.com/wp-content/uploads/2022/07/Carolina-Paez.png', 'My name is Yolanda and I love to do yoga every morning. It grounds and centers me. I am looking for people who would also like to do yoga in the mornings.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (13, 'foodieFred', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Fred', 'Adams', 'fred@email.com', '555-215-6258', 'https://leadershipcircle.com/wp-content/uploads/2022/07/Aaronde-Creighton-5.png', 'Hi I\'m Fred and I can be found restaurant hopping all over our city. I LOVE food.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (14, 'serviceSam', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Sam', 'Torres', 'sam@email.com', '555-632-5628', 'https://leadershipcircle.com/wp-content/uploads/2022/07/Steve-Athey.png', 'My name is Sam and I have teamed up with local food pantries and homeless shelters to help those in need. I am looking for people who would like to help out.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (15, 'bookClubBetty', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Betty', 'Harrison', 'betty@email.com', '555-815-6259', 'https://leadershipcircle.com/wp-content/uploads/2025/01/Stephanie-Laflamme-2048x2048.png', 'I\'m Betty and I have been a part of many book clubs and look forward to talking about the books I read. I enjoy fiction books.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (16, 'fishingFrank', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Frank', 'Reyes', 'frank@email.com', '555-965-3265', 'https://leadershipcircle.com/wp-content/uploads/2022/07/Steve-Athey.png', 'I\'m Frank and I enjoy being outdoors and fishing the different lakes and rivers in our area.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (17, 'raftingRob', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Rob', 'Nelson', 'rob@email.com', '555-326-5248', 'https://leadershipcircle.com/wp-content/uploads/2025/01/David-Takapu-1.png', 'My name is Rob and I love to raft and do all kinds of watersports.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (18, 'boardGameBob', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Bob', 'Anderson', 'bob@email.com', '555-123-4567', 'https://leadershipcircle.com/wp-content/uploads/2022/07/Bob-Anderson-5.png', 'I\'m Bob and I enjoy playing all kinds of card and board games.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (19, 'paintingPatty', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Patty', 'Bennett', 'patty@email.com', '555-234-5678', 'https://leadershipcircle.com/wp-content/uploads/2023/04/Amy-FR-new-portrait2023.png', 'My name is Patty and I have been painting since I was little. I love to paint!', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (20, 'pickleballPete', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Pete', 'Carter', 'pete@email.com', '555-345-6789', 'https://leadershipcircle.com/wp-content/uploads/2022/07/Jud-Kennedy-3.png', 'Pete here. I love to be outside and play pickleball, whether it\'s casual 1 on 1 or 2 on 2 or a city league.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (21, 'walkingWendy', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Wendy', 'Dawson', 'wendy@email.com', '555-456-7890', 'https://leadershipcircle.com/wp-content/uploads/2022/07/Betsy-Leatherman-8.png', 'My name is Wendy and I love to go on walks. It\'s a great way to start my day.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (22, 'bookClubBryan', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Bryan', 'Evans', 'bryan@email.com', '555-567-8901', 'https://leadershipcircle.com/wp-content/uploads/2022/07/Russ-Olsen-headshot-02.png', 'I\'m Bryan and I have been doing a business book club for years. I\'m looking for others to join me.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (23, 'fishingFiona', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Fiona', 'Garcia', 'fiona@email.com', '555-678-9012', 'https://leadershipcircle.com/wp-content/uploads/2023/10/cindy-adams.png', 'My name is Fiona and I learned to fish with my father when I was a little girl. I love to fish!', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (24, 'serviceSal', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Sal', 'Ingram', 'sal@email.com', '555-789-0123', 'https://leadershipcircle.com/wp-content/uploads/2024/05/Raul_Delatorre_Headshot.png', 'My name is Sal and I love to volunteer and serve. I like to see the smile on the faces of those who are being served. It brings me joy.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (25, 'walkingWalter', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Walter', 'Harrison', 'walter@email.com', '555-890-1234', 'https://leadershipcircle.com/wp-content/uploads/2022/09/Tom-HARKER.png', 'I\'m Walter and I really enjoy going on walks. I like to walk outside, inside when it\'s cold, and on the local beach.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (26, 'basketballBill', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Bill', 'Lawson', 'bill@email.com', '555-901-2345', 'https://leadershipcircle.com/wp-content/uploads/2025/01/Jared-Palmer.png', 'My name is Bill and I am looking for groups that do things I am interested in so that I can find and make new friends.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (27, 'memberAndrew', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Andrew', 'Keller', 'andrew@email.com', '555-012-3456', 'https://leadershipcircle.com/wp-content/uploads/2023/04/Andrew-Parker-Instagram.png', 'My name is Andrew and I am looking for groups that do things I am interested in so that I can find and make new friends.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (28, 'memberCristina', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Cristina', 'Jackson', 'cristina@email.com', '555-282-3344', 'https://leadershipcircle.com/wp-content/uploads/2025/01/Cristina-Perez-2025-01.png', 'My name is Cristina and I am looking for groups that do things I am interested in so that I can find and make new friends.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (29, 'memberMartha', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Martha', 'Owens', 'martha@email.com', '555-339-4455', 'https://leadershipcircle.com/wp-content/uploads/2024/05/Christina-Rothschild2.png', 'My name is Martha and I am looking for groups that do things I am interested in so that I can find and make new friends.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (30, 'memberAlex', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Alex', 'Mitchell', 'alex@email.com', '555-447-5566', 'https://leadershipcircle.com/wp-content/uploads/2025/01/Alex-Sacca.png', 'My name is Alex and I am looking for groups that do things I am interested in so that I can find and make new friends.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (31, 'memberLaura', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Laura', 'Quinn', 'laura@email.com', '555-505-6677', 'https://leadershipcircle.com/wp-content/uploads/2024/05/Lani-Van-Dusen-Cropped.png', 'My name is Laura and I am looking for groups that do things I am interested in so that I can find and make new friends.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (32, 'memberTyler', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Tyler', 'Reynolds', 'tyler@email.com', '555-696-7788', 'https://leadershipcircle.com/wp-content/uploads/2022/07/Tyson-Andrus.png', 'My name is Tyler and I am looking for groups that do things I am interested in so that I can find and make new friends.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (33, 'memberDave', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Dave', 'Sullivan', 'dave@email.com', '555-988-9658', 'https://leadershipcircle.com/wp-content/uploads/2022/07/Dave-Schrader.png', 'My name is Dave and I am looking for groups that do things I am interested in so that I can find and make new friends.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (34, 'memberSusie', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Susie', 'Thompson', 'susie@email.com', '555-235-6587', 'https://leadershipcircle.com/wp-content/uploads/2022/07/karen-Michaels.png', 'My name is Susie and I am looking for groups that do things I am interested in so that I can find and make new friends.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (35, 'memberJeff', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Jeff', 'Craig', 'jeff@email.com', '555-985-6574', 'https://leadershipcircle.com/wp-content/uploads/2025/01/Peter-Stoppelengurg_2023.png', 'My name is Jeff and I am looking for groups that do things I am interested in so that I can find and make new friends.', NULL, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (36, 'memberChris', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Chris', 'Winder', 'chris@email.com', '555-489-6587', 'https://leadershipcircle.com/wp-content/uploads/2022/07/David-Spach-18.png', 'My name is Chris and I am looking for groups that do things I am interested in so that I can find and make new friends.', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `image_url`, `biography`, `role`, `enabled`, `create_date`, `last_update`, `address_id`) VALUES (37, 'memberKari', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Kari', 'Michaelson', 'kari@email.com', '555-215-6521', 'https://leadershipcircle.com/wp-content/uploads/2022/07/Suzanne-Kietselaer-3.png', 'My name is Kari and I am looking for groups that do things I am interested in so that I can find and make new friends.', NULL, NULL, NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `group_category`
-- -----------------------------------------------------
START TRANSACTION;
USE `gatherrounddb`;
INSERT INTO `group_category` (`id`, `name`, `description`, `image_url`) VALUES (1, 'Sports', 'Recreational sports where groups have teams and competitive play.', 'https://img.freepik.com/premium-vector/football-soccer-logo_609550-353.jpg?semt=ais_hybrid');
INSERT INTO `group_category` (`id`, `name`, `description`, `image_url`) VALUES (2, 'Social', 'Gatherings and get-togethers that focus on talking and getting to know one another.', 'https://cdn.vectorstock.com/i/500p/50/32/team-work-icon-vector-1545032.jpg');
INSERT INTO `group_category` (`id`, `name`, `description`, `image_url`) VALUES (3, 'Food', 'Enjoy local bars and restaurants and sharing food ideas, cooking, baking, and more.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9xhucuFgKXi65B0p6GojuuuhhlhnbJ5hx1NLnNebFF-9UGywwiq6umaQVI4Mw72-QhVU&usqp=CAU');
INSERT INTO `group_category` (`id`, `name`, `description`, `image_url`) VALUES (4, 'Animals', 'Anything related to animals including farm animals and pets.', 'https://static.vecteezy.com/system/resources/previews/008/249/492/non_2x/veterinary-logo-cat-and-dog-logo-design-pet-care-vet-clinic-logo-pet-clinic-free-vector.jpg');
INSERT INTO `group_category` (`id`, `name`, `description`, `image_url`) VALUES (5, 'Outdoors', 'Activities related to the outdoors like hiking, fishing, camping, exploring, etc.', 'https://placeit-img-1-p.cdn.aws.placeit.net/uploads/stage/stage_image/90796/optimized_product_thumb_stage.jpg');
INSERT INTO `group_category` (`id`, `name`, `description`, `image_url`) VALUES (6, 'Exercise', 'Groups that focus on getting your heart rate up and exercising as the main goal.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtFBo6d1pZm65ASfGWrXUOt795tF4hOUafaA&s');
INSERT INTO `group_category` (`id`, `name`, `description`, `image_url`) VALUES (7, 'Education', 'For groups that are educational in nature and focus on learning.', 'https://png.pngtree.com/png-vector/20240515/ourmid/pngtree-open-book-logo-png-image_12467719.png');
INSERT INTO `group_category` (`id`, `name`, `description`, `image_url`) VALUES (8, 'Volunteering', 'Serve the community by volunteering your time to help those in need.', 'https://images-platform.99static.com/ZenxnGu5ltEF-XyZfNPk3RSUItI=/500x500/top/smart/99designs-contests-attachments/55/55881/attachment_55881037');

COMMIT;


-- -----------------------------------------------------
-- Data for table `social_group`
-- -----------------------------------------------------
START TRANSACTION;
USE `gatherrounddb`;
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (1, 'Pickleball Players', 'We play pickleball a couple of times a week. If weather is bad then we go to the indoor courts.', 'https://ih1.redbubble.net/image.4845242364.4734/bg,f8f8f8-flat,750x,075,f-pad,750x1000,f8f8f8.jpg', NULL, NULL, 1, 1, 1);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (2, 'Senior Disco', 'We are a group of Seniors who love going out dancing to bring back memories of the good \'ol days.', 'https://media.istockphoto.com/id/1503289491/vector/disco-ball-and-disco-wave.jpg?s=612x612&w=0&k=20&c=xdWgXRyyFQYQIS5W4D0EG10z_loDDWLmvZuFxloJ2XI=', NULL, NULL, 1, 2, 2);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (3, 'Board Gamers', 'We are a bunch of nerds who get together to play games and eat junk food. We meet at local game shops once every two weeks to play.', 'https://3.files.edl.io/3ca3/18/10/10/130025-cedcc2ed-b568-42c3-b067-db67cad003ce.jpg', NULL, NULL, 1, 3, 2);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (4, 'Full-Stack Coders', 'We are a group of coders with varying background and experience who want to share knowledge, different tools and frameworks, and help the up and coming junior developers. We meet weekly at the shared workspace in Silicon Slopes.', 'https://i.pinimg.com/736x/fa/e8/62/fae862fff4f6100d000a1c01c4030db0.jpg', NULL, NULL, 1, 4, 7);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (5, 'Swimming Savants', 'We meet at the rec center once a week to swim and enjoy one another\'s company. Come and join us!', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKwxaRRtOVystC0H7NlfKiUIeVNu82drESQA&s', NULL, NULL, 1, 5, 6);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (6, 'Hiking Heroes', 'We are a small group of local hikers who invite young and old to come join us, get outside, and get some healthy exercise while enjoying nature\'s beauty.', 'https://img.freepik.com/premium-vector/hikers_1306637-2032.jpg?semt=ais_hybrid', NULL, NULL, 1, 6, 5);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (7, 'Women\'s Walking', 'We are a group of women who love to walk and get some exercise while supporting one another as we chat about life.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHjf7uBKilwX_uoC19dACb04eENgKWhIEErA&s', NULL, NULL, 1, 7, 6);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (8, 'Concert Goers', 'We are a group of people who love to go to different concerts in the area. There is some cost involved with the tickets, but we all have a great time.', 'https://img.freepik.com/free-vector/abstract-grunge-live-music-poster_1017-9864.jpg', NULL, NULL, 1, 8, 2);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (9, 'Art Enthusiasts', 'We are an art group who meets once every two weeks to do water color or painting or whatever we find we would like to do. We meet at the local art supply shop.', 'https://image.isu.pub/140327163135-7d4aad209e49ff8074f1327133213363/jpg/page_1_thumb_large.jpg', NULL, NULL, 1, 9, 7);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (10, 'Mommy Playdates', 'We are a group of tired Moms who created this group so that we can get out of the house, meet one another, support one another, and let our kids get out and play. We meet at different local parks and would love more members.', 'https://scontent-lax3-1.xx.fbcdn.net/v/t39.30808-6/312115585_5450160828412591_1390224846805993987_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=U4IRRfGSUQkQ7kNvgE37l5x&_nc_oc=Adhgbyg1WZ9yZDlpFVBB5u6Xx5cnw-vaV1aJ5Vy-aD_-_eBpeAj50jkQ2DetKo-Bkog&_nc_zt=23&_nc_ht=scontent-lax3-1.xx&_nc_gid=AVZZw2swOMdu_ZCjZYgUcZD&oh=00_AYArv7JusQ9VN1u9gXt8KhdzzyTWRk8_5Qalr6cW7Vo8ag&oe=67B8775A', NULL, NULL, 1, 10, 2);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (11, 'Dog Parkers', 'We are dog lovers and created this group so that we can meet up and have our pups play together.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSthKi282dxop_djCI9_nPTqTYyilaxZYLr-Q&s', NULL, NULL, 1, 11, 4);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (12, 'Morning Yoga', 'We are a yoga group who find peace in doing yoga. Bring you yoga pad and join us at the local yoga studio or sometimes we meet outdoors. ', 'https://static.vecteezy.com/system/resources/previews/031/115/244/non_2x/yoga-logo-design-stock-human-meditation-in-lotus-flower-illustration-vector.jpg', NULL, NULL, 1, 12, 6);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (13, 'Foodie Friends', 'We love to research new and exciting food in the area and then meet up to try everything. Come and join us for fun and food.', 'https://logopond.com/logos/c47964b8a82be22fedadb42e05ac335e.png', NULL, NULL, 1, 13, 3);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (14, 'Live 2 Serve', 'We meet at local homeless shelters and food pantries to see what they need to serve those who have less. Please join us and do some good.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNmyTNQ8yOOQP6I20zq69paJ2wGdkMtVTzD22xCdosRUeX_1xM-j739CWbZeyK6BRtpNQ&usqp=CAU', NULL, NULL, 1, 14, 8);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (15, 'Fiction Book Club', 'We are a book club that focuses primarily on fiction books. We usually have treats and meet at the local Starbucks or Barnes and Noble.', 'https://broward.libnet.info/images/events/broward/WR_Teen_Book_Club.png', NULL, NULL, 1, 15, 7);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (16, 'Keep It Reel Fishers', 'We enjoy getting out and fishing the local lakes and rivers. We love to teach others how to fish and also welcome the experienced fishers to our group.', 'https://d3o2e4jr3mxnm3.cloudfront.net/Mens-Keep-It-Reel-Bass-Short-Sleeve-CrusherLITE-Tee_100874_2_lg.png', NULL, NULL, 1, 16, 5);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (17, 'White Water Rafters', 'We meet during the Spring/Summer and plan trips to white water raft together. We hold planning meetings to make sure we have the gear we need and then we go out and have fun.', 'https://cdn.dribbble.com/users/6605372/screenshots/16056990/rafting2525-02.jpg', NULL, NULL, 1, 17, 5);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (18, 'Ballroom Group', 'Join our ballroom dance group to learn elegant moves, build confidence, and have fun! No partner or experience needed—just bring your enthusiasm!', 'https://img.freepik.com/premium-vector/couple-dancing-ballroom-dance-vector-logo-illustration-silhouette_1151527-3653.jpg', NULL, NULL, 1, 2, 1);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (19, 'Dungeon & Dragons', 'A friendly Dungeons & Dragons group for adventurers of all experience levels! Join us for epic quests, creative storytelling, and great company. New players welcome!', 'https://images.bigbadtoystore.com/images/p/full/2020/09/9a41487f-2309-4767-b5fd-c82fce8b4095.jpg', NULL, NULL, 1, 3, 1);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (20, 'Coding Beginners', 'A welcoming group for beginner coders to learn, practice, and collaborate! No experience needed—just curiosity and a desire to build cool projects together!', 'https://us.v-cdn.net/6036147/uploads/LQGA35MU4B1K/group9-5-1-1200x675.jpg', NULL, NULL, 1, 4, 7);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (21, 'Senior Devs', 'A community for senior developers to network, share expertise, and collaborate on advanced projects. Connect with like-minded professionals and stay ahead in tech!', 'https://ih1.redbubble.net/image.347082423.4653/raf,360x360,075,t,fafafa:ca443f4786.u3.jpg', NULL, NULL, 1, 4, 7);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (22, 'Hot Tubbers', 'Relax and unwind with us as we explore the best hot tubs and natural hot springs! Great company, scenic soaks, and ultimate relaxation guaranteed!', 'https://static.vecteezy.com/system/resources/previews/041/138/797/non_2x/hot-tub-isolated-flat-illustration-free-vector.jpg', NULL, NULL, 1, 5, 2);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (23, 'Nature Walks', 'Join us for peaceful nature walks, fresh air, and great company! Explore scenic trails, connect with nature, and enjoy a relaxing stroll with fellow walkers.', 'https://yt3.googleusercontent.com/x0liZkdIWiidXnGfSjrTC7oLP-K6nopv0z4O0J6gWKo77ZiHu-R1MEQA5I0nt9cT65ssgMbTI54=s900-c-k-c0x00ffffff-no-rj', NULL, NULL, 1, 6, 5);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (24, 'Happy Campers', 'Adventure awaits! Join our camping group to explore the great outdoors, share campfires, and make lasting memories under the stars.', 'https://png.pngtree.com/png-vector/20230421/ourmid/pngtree-outdoor-camping-logo-vector-image_6718364.png', NULL, NULL, 1, 6, 5);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (25, 'Men\'s Walking', 'A group for men to walk, talk, and stay active together. Enjoy fresh air, good company, and great conversations on scenic walks.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSm6LCMWH2h2V2CDFY-6Pk_P60w2Cr8wsTu-NnjKa_oK2e77iXCKnpsVCLA8OTQY_qc-2k&usqp=CAU', NULL, NULL, 1, 7, 6);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (26, 'Outdoor Concerts', 'Experience live music under the open sky! Join us for outdoor concerts, great vibes, and unforgettable nights with fellow music lovers.', 'https://toledocitypaper.com/wp-content/uploads/2017/07/outdoor-concerts.jpg', NULL, NULL, 1, 8, 2);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (27, 'Pottery Pals', 'Get your hands dirty and unleash your creativity! Join our pottery group to relax, learn, and create unique ceramic pieces with fellow pottery enthusiasts.', 'https://logo.com/image-cdn/images/kts928pd/production/446e5ed7381181c8b1f202ae9496e6a29d885592-731x731.jpg?w=1080&q=72&fm=webp', NULL, NULL, 1, 9, 7);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (28, 'Cats & Friends', 'A cozy social group where cat lovers gather with their feline friends to relax, share stories, and enjoy some quality time together.', 'https://logopond.com/logos/84988471b8b92cb311159e855ae3ce7d.png', NULL, NULL, 1, 11, 4);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (29, 'Goat Yoga', 'A fun-loving group that practices yoga alongside playful goats, combining relaxation, laughter, and a unique connection with nature.', 'https://bloximages.newyork1.vip.townnews.com/republicaneagle.com/content/tncms/assets/v3/editorial/3/5b/35b7bac9-7bcb-5246-81d1-06018883fa94/60881c1842393.image.jpg?resize=500%2C500', NULL, NULL, 1, 12, 4);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (30, 'Bread Bakers', 'A warm and welcoming group that comes together to bake bread, share techniques, and learn the art and science of baking.', 'https://ih1.redbubble.net/image.2338888829.6561/st,small,845x845-pad,1000x1000,f8f8f8.jpg', NULL, NULL, 1, 13, 3);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (32, 'Business Book Club', 'A motivated book club where we read and discuss business books, sharing insights and strategies to grow personally and professionally.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4ttR65OlSw8EZJ_po49M9kv9d73aM-QLORYj0bc4m6oWJknofcfJT1TKC9erl8RlbX9U&usqp=CAU', NULL, NULL, 1, 15, 7);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (33, 'Ice Fishers', 'A dedicated group of ice fishing enthusiasts who gather to drill, fish, and enjoy the frozen outdoors together.', 'https://grandrivercasino.com/wp-content/uploads/2024/11/IceFishingWebsite-1024x640.png', NULL, NULL, 1, 16, 5);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (34, 'Fly Fishers', 'A passionate group of fly fishers who come together to cast, connect, and share the art of fly fishing in beautiful waters.', 'https://cdn.dribbble.com/users/11826969/screenshots/19933079/media/55d358598c966acbae46b7da117ea87a.jpg?format=webp&resize=400x300&vertical=center', NULL, NULL, 1, 16, 5);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (35, 'City Pickleball League', 'A fun and competitive group that plays city league pickleball, bringing energy, teamwork, and good vibes to the court.', 'https://assets.opensports.net/groups/teFK6tLMJ39.OittaaKR5j.jpg', NULL, NULL, 1, 17, 1);
INSERT INTO `social_group` (`id`, `name`, `description`, `image_url`, `create_date`, `last_update`, `enabled`, `owner_id`, `group_category_id`) VALUES (36, 'Basketballers', 'A lively group of basketball enthusiasts who come together to play, compete, and have fun on the court.', 'https://i.fbcd.co/products/original/basketball-logo10-converted-01-638db99b01e85ead7ab3a681ff8d532e200d24bdf814ebcedce5f332ea62ea8e.jpg', NULL, NULL, 1, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `social_event`
-- -----------------------------------------------------
START TRANSACTION;
USE `gatherrounddb`;
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (1, '2x2 Pickleball', 'We are going to reserve the courts and play 2 on 2. Come and join us.', '2025-2-25', '10:30:00', '12:30:00', 'https://recreation.uic.edu/wp-content/uploads/sites/377/2023/12/unnamed-1090x675.jpg', NULL, NULL, 0.00, 1, 1, 1, 1, 1, 1);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (2, 'Dance Night', 'We reserved the dance hall and will be learning how to do different dances.', '2025-2-13', '6:00:00', '8:00:00', 'https://www.dupageseniorcouncil.org/wp-content/uploads/2022/04/Senior-Dance-Party-2.png', NULL, NULL, 5.00, 1, 2, 2, 2, 2, 2);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (3, 'Settlers of Catan', 'Come play Catan with us. We will have snacks and drinks and have several boards set up.', '2025-3-5', '6:30:00', '8:30:00', 'https://i.redd.it/u4qvn2w6ocgb1.jpg', NULL, NULL, 0.00, 1, 1, 3, 3, 3, 3);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (4, '7 Wonders', 'We will be teaching and learning how to play 7 Wonders.', '2025-3-12', '7:00:00', '9:00:00', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmHODaouY-822wijoSLmep5ENkzW-Tus_bdw&s', NULL, NULL, 0.00, 1, 1, 3, 3, 3, 3);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (5, 'Javascript Review', 'Come and get a refresher course on Javascript, using VS Code and other tools.', '2025-3-10', '11:00:00', '1:00:00', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSe13awn1J9cI-xqOLF4Zw_9ee35D1rrV_cyA&s', NULL, NULL, 200.00, 1, 2, 4, 4, 4, 4);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (6, 'CSS Class', 'We will be running through CSS and answering questions on syntax while seeing real-time design changes on a website.', '2025-3-15', '10:00:00', '12:00:00', 'https://blog.10pines.com/content/images/size/w2000/2021/06/pankaj-patel-SXihyA4oEJs-unsplash.jpg', NULL, NULL, 200.00, 1, 2, 4, 4, 4, 4);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (7, 'Casual Swim', 'Come and relax; no set plan or agenda. We will probably get lunch afterwards.', '2025-3-18', '12:00:00', '1:00:00', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYJIMnT82bxE7f2c77-w63-mmmDL21t3eN1A&s', NULL, NULL, 5.00, 1, 1, 5, 5, 5, 5);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (8, 'Swim at the Hot Springs', 'We will be meeting at the entrance and walking up to the springs. Bring a towel and sunscreen.', '2025-3-9', '10:30:00', '12:30:00', 'https://www.traxplorio.com/wp-content/uploads/2023/04/Jemez-Hot-Springs-Main-Pool.jpg', NULL, NULL, 0.00, 1, 1, 5, 5, 22, 5);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (9, 'Hiking Timpanogos Cave', 'Meet at the visitor\'s center and then we will hike up to the caves. Bring good shoes and a flashlight. Meet afterwards to eat.', '2025-3-25', '9:00:00', '1:00:00', 'https://www.nps.gov/tica/learn/education/images/group-on-trail_1.png', NULL, NULL, 10.00, 1, 2, 6, 6, 6, 6);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (10, 'Hike Mt. Olympus', 'We have been planning this for a couple weeks now. It\'s time to do the hike! Make sure that you have the gear and food on the supplies list.', '2025-4-19', '9:00:00', '5:00:00', 'https://appalachiantrail.org/wp-content/uploads/2020/01/ATC_RP14251_DSC_5582-lpr.jpg', NULL, NULL, 0.00, 1, 1, 6, 6, 6, 6);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (11, 'Weekend Overnight Hike', 'This is our yearly overnighter. Make sure to triple check your gear. We will meet at the base of the canyon since cell service is spotty once you get up to the trailhead.', '2025-5-29', '9:00:00', '4:00:00', 'https://www.snowys.com.au/blog/wp-content/uploads/2017/08/Header-Night-Hiking-1-1280x720.jpg', NULL, NULL, 20.00, 1, 1, 6, 6, 6, 6);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (12, 'Morning Walk', 'Come and join our ladies group in the morning for a walk around the neighborhood.', '2025-3-18', '8:30:00', '9:15:00', 'https://www.healthifyme.com/blog/wp-content/uploads/2022/06/Morning-Walking-1.jpg', NULL, NULL, 0.00, 1, 1, 7, 7, 7, 7);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (13, 'Michael Jackson ONE', 'We will be going to see the Michael Jackson concert. Make sure to check your email for your tickets.', '2025-4-6', '7:00:00', '9:30:00', 'https://thelibrary.mgmresorts.com/transform/AKBoM7mE3iT782WN/mandalay-bay-entertainment-michael-jackson-one-key-art-large-2022.jpg', NULL, NULL, 150.00, 1, 1, 8, 8, 8, 8);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (14, 'Imagine Dragons', 'This concert is finally here! Make sure to save your QR code for entrance into the venue. It\'s going to be awesome!', '2025-6-1', '7:00:00', '10:00:00', 'https://i.ytimg.com/vi/Wc1GL_ZhOLE/maxresdefault.jpg', NULL, NULL, 175.00, 1, 1, 8, 8, 8, 8);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (15, 'Zach Bryan', 'Can\'t wait to see you all at the Zach Bryan concert! Come early and we can hang out. Don\'t forget your tickets!', '2025-8-9', '7:00:00', '9:30:00', 'https://www.ticketnews.com/wp-content/uploads/2024/11/Zach-Bryan-1.webp', NULL, NULL, 200.00, 1, 1, 8, 8, 8, 8);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (16, 'Painting on Canvas', 'We will be learning how to paint an outdoor lake and mountain scene. Come ready to have fun!', '2025-5-15', '6:00:00', '8:00:00', 'https://cdn.shopify.com/s/files/1/0015/2666/1233/files/Step_5_Starry_Night_Sky.png?v=1630667167', NULL, NULL, 30.00, 1, 1, 9, 9, 9, 19);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (17, 'Date Night Paint Night', 'Bring your spouse! We will be painting two sides of heart that you will join together.', '2025-2-13', '7:00:00', '8:30:00', 'https://uncorkedcanvas.com/wp-content/uploads/2019/12/Date-night-bold-heart-scaled.jpg', NULL, NULL, 15.00, 1, 1, 9, 9, 9, 19);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (18, 'Playdate at Provo Splash Pad', 'Bring your kiddos and get out of the heat at the splash pad. Make sure you bring towels and sunscreen.', '2025-4-30', '10:00:00', '12:00:00', NULL, NULL, NULL, 0.00, 1, 2, 10, 10, 10, 10);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (19, 'Playdate at Discovery', 'This is an awesome park with lots to do for the kids. Bring a folding chair and a picnic item to share. Check the sign up sheet to see who is bringing what.', '2025-5-25', '10:00:00', '12:00:00', NULL, NULL, NULL, 0.00, 1, 2, 10, 10, 10, 10);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (20, 'Dog Meetup at Dry Creek Park', 'Just a short meetup to let the pups run around and play. Bring a leash since you will need it to get to the dog area, but can take it off once you let them in.', '2025-3-22', '9:00:00', '11:00:00', NULL, NULL, NULL, 0.00, 1, 2, 11, 11, 11, 11);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (21, 'Westminster Dog Meetup', 'We are going to have lunch and let the pups play and have fun. We will have a dog trainer there to talk to us about obedience school and they have a discount for our group.', '2025-4-16', '10:00:00', '12:00:00', NULL, NULL, NULL, 0.00, 1, 2, 11, 11, 11, 11);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (22, 'Yoga at the Studio', 'Meet at the studio for a relaxing session.', '2025-3-26', '7:00:00', '8:00:00', NULL, NULL, NULL, 0.00, 1, 1, 12, 12, 12, 12);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (23, 'Yoga at the Outdoor Pool', 'Meet at the Clyde rec center. We were able to reserve the pool before it opens to the public. Watch the sunrise with us.', '2025-4-26', '7:00:00', '8:00:00', NULL, NULL, NULL, 0.00, 1, 1, 12, 12, 12, 12);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (24, 'Yoga in the Park', 'We will meet at the Centennial Park just before sun rise to greet the new day with a great session of core yoga.', '2025-5-9', '7:00:00', '8:00:00', NULL, NULL, NULL, 0.00, 1, 1, 12, 12, 12, 12);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (25, 'Restaurant Hopping Friday', 'We will be starting at Tsunami for sushi, going over to R&R for some BBQ, and then finishing the night at Keys on Main for drinks.', '2025-5-14', '5:30:00', '9:00:00', 'https://pbs.twimg.com/media/D0U2GaVXQAEZlce.jpg', NULL, NULL, 200.00, 1, 1, 13, 13, 13, 13);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (26, 'Harmons Cooking Class', 'They will be teaching how to make carne asada tacos with all of the fixins.', '2025-6-2', '5:30:00', '8:30:00', 'https://www.harmonsgrocery.com/app/uploads/2021/10/Cooking_School_Search_Return_Images17.jpg', NULL, NULL, 80.00, 1, 1, 13, 13, 13, 13);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (27, 'Dutch Oven Baking', 'Learn how to make chicken and dumplings and peach cobbler with a Dutch overn expert.', '2025-7-26', '5:30:00', '8:00:00', 'https://littlehousebigalaska.com/wp-content/uploads/2020/11/Dutch-Oven-Bread-7-1024x666.jpg', NULL, NULL, 10.00, 1, 1, 13, 13, 13, 13);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (28, 'Monthly Food Drive', 'This is an ongoing monthly event where we go around and collect donated food and bring it to the pantry.', '2025-3-21', '11:30:00', '1:00:00', NULL, NULL, NULL, 0.00, 1, 2, 14, 14, 14, 14);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (29, 'Feed the Homeless', 'We will be serving dinner at the Pantry for those in need. Come and serve!', '2025-4-4', '5:30:00', '7:30:00', NULL, NULL, NULL, 0.00, 1, 2, 14, 14, 14, 14);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (30, 'Clean Up Main Street', 'We will meet early Saturday morning to pick up trash along Main Street. ', '2025-5-6', '8:30:00', '10:30:00', NULL, NULL, NULL, 0.00, 1, 2, 14, 14, 14, 14);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (31, 'Harry Potter Discussion', 'We will be discussing book 5 so hopefully you have finished it. If not, get to it and we will talk about the plot twist at the end!', '2025-4-6', '6:30:00', '8:00:00', NULL, NULL, NULL, 0.00, 1, 1, 15, 15, 15, 15);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (32, 'Next Book Planning Meeting', 'We will be calendaring our next 4 books that we want to read by taking suggestions and voting.', '2025-6-9', '6:30:00', '8:00:00', NULL, NULL, NULL, 0.00, 1, 1, 15, 15, 15, 15);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (33, 'Fishing Meetup', 'We will meet at Harmons and head up to the Provo river for fly fishing. There is cell service in the canyon if you are late you can still come up and join us.', '2025-5-21', '7:30:00', '2:00:00', NULL, NULL, NULL, 0.00, 1, 1, 16, 16, 16, 16);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (34, 'Fly Tying Night', 'Come and bring your fly tying gear and we will help you build a few and share fish stories.', '2025-6-18', '7:00:00', '8:30:00', NULL, NULL, NULL, 5.00, 1, 1, 16, 16, 34, 16);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (35, 'Planning Trip to the Snake River', 'We are planning our big trip up to the Snake River in June.', '2025-5-9', '5:30:00', '7:00:00', NULL, NULL, NULL, 0.00, 1, 1, 17, 17, 17, 17);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (36, 'City Pickleball Tournament', 'Come join the city league; they pair up varying skill levels so there is a place for everyone. RSVP.', '2025-5-20', '9:00:00', '11:00:00', 'https://cloudfront-us-east-1.images.arcpublishing.com/advancelocal/YYBBDKR2DZHIZFGVZNNPFXTDDM.jpg', NULL, NULL, 18.00, 1, 1, 1, 1, 35, 20);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (37, 'Ballroom Dance Lessons', 'A lively and elegant event where dancers of all levels come together to learn and enjoy the art of ballroom dance in a fun, welcoming atmosphere.', '2025-5-26', '7:00:00', '8:30:00', 'https://i.ytimg.com/vi/9Xwa1qzDSyw/sddefault.jpg', NULL, NULL, 15.00, 1, 2, 2, 2, 18, 2);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (38, 'Men\'s Morning Walk', 'A casual and social walking event for men to get outdoors, stay active, and enjoy good conversation while getting some steps in.', '2025-6-5', '8:00:00', '9:00:00', 'https://www.myshrewsbury.co.uk/assets/bXlzaHJld3NidXJ5/images/news-105/menwalkingandtalking-320/menwalkingandtalking.jpg', NULL, NULL, 0.00, 1, 2, 7, 7, 25, 25);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (39, 'Business Book Discussion', 'A dynamic book club event where professionals gather to read, discuss, and share insights from top business books to grow and succeed together.', '2025-7-19', '7:00:00', '8:30:00', NULL, NULL, NULL, 0.00, 1, 1, 15, 15, 32, 22);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (40, 'Line Dancing', 'A fun and energetic event where we learn the steps, rhythm, and moves of line dancing—perfect for all skill levels!', '2025-8-2', '7:00:00', '8:30:00', 'https://i.pinimg.com/736x/78/4f/1f/784f1fbf7969869df0603d939ac42eae.jpg', NULL, NULL, 15.00, 1, 2, 2, 2, 2, 2);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (41, 'D&D Night', 'An adventurous night of Dungeons & Dragons where we roll dice, tell epic stories, and embark on thrilling quests together. ', '2025-8-5', '6:30:00', '8:30:00', NULL, NULL, NULL, 5.00, 1, 1, 3, 3, 19, 18);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (42, 'Intro to HTML', 'A beginner-friendly event where we dive into the basics of HTML, learning how to structure web pages and build a solid coding foundation.', '2025-8-9', '11:00:00', '1:00:00', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUbSVogNvQrFoWKML12KN41NKNQy9q0wb3nw&s', NULL, NULL, 200.00, 1, 2, 4, 4, 20, 4);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (43, 'Advanced Java', 'A deep-dive event for experienced Java developers, exploring advanced concepts, best practices, and hands-on coding to level up your skills.', '2025-7-19', '11:00:00', '1:00:00', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQE1JE7gFbpwJ9owmVhk47P86IbXZ0_xanR0w&s', NULL, NULL, 200.00, 1, 2, 4, 4, 21, 4);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (44, 'Walk Dripping Rock Trail', 'A scenic group walk to Dripping Rock Trail, where we’ll enjoy nature, fresh air, and great company along the way.', '2025-7-26', '9:00:00', '10:00:00', NULL, NULL, NULL, 0.00, 1, 1, 7, 7, 23, 25);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (45, 'Moab Camping Trip', 'An epic camping trip to Moab, filled with breathtaking views, outdoor adventures, and unforgettable memories under the desert sky.', '2025-7-12', '3:00:00', '5:00:00', NULL, NULL, NULL, 90.00, 1, 1, 6, 6, 24, 6);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (46, 'Outdoor Concert at Scera Park', 'A vibrant outdoor concert featuring great music, fresh air, and good vibes—come enjoy live performances under the open sky!', '2025-7-23', '6:30:00', '8:30:00', NULL, NULL, NULL, 10.00, 1, 2, 8, 8, 26, 8);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (47, 'Build a Vase Night', 'A creative and hands-on pottery night where you’ll shape, design, and build your own unique vase—no experience needed!', '2025-8-3', '7:00:00', '8:30:00', 'https://i.ytimg.com/vi/JNuXhqrUC9c/sddefault.jpg', NULL, NULL, 20.00, 1, 1, 9, 9, 27, 9);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (48, 'Cat Meetup', 'A purr-fectly fun meetup where cat lovers and their feline friends gather to socialize, share stories, and enjoy a cozy time together.', '2025-8-9', '9:30:00', '11:00:00', NULL, NULL, NULL, 0.00, 1, 1, 11, 11, 28, 11);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (49, 'Goat Yoga at the Farm', 'A fun and relaxing goat yoga session where you can stretch, unwind, and enjoy playful interactions with friendly goats.', '2025-8-14', '9:00:00', '10:00:00', NULL, NULL, NULL, 0.00, 1, 1, 12, 12, 29, 12);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (50, 'Sourdough Bread Techniques', 'A hands-on sourdough baking night where you’ll learn the art of making, shaping, and baking delicious homemade bread.', '2025-8-18', '7:00:00', '8:30:00', 'https://static.wixstatic.com/media/1a9edf_9e07a16672af4f55bf569b470535e8e6~mv2.png/v1/fill/w_640,h_360,fp_0.50_0.50,q_85,usm_0.66_1.00_0.01,enc_auto/1a9edf_9e07a16672af4f55bf569b470535e8e6~mv2.png', NULL, NULL, 10.00, 1, 1, 13, 13, 30, 13);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (51, 'Pumpkin Chocolate Chip Bread', 'A cozy bake night where we mix, bake, and enjoy the warm flavors of homemade pumpkin chocolate chip loaf—perfect for fall vibes!', '2025-9-2', '7:00:00', '8:30:00', 'https://food.fnr.sndimg.com/content/dam/images/food/fullset/2022/06/15/0/FNK_VEGAN_PUMPKIN_CHOCOLATE_CHIP_BREAD_H_f_s4x3.jpg.rend.hgtvcom.616.462.suffix/1655312036609.webp', NULL, NULL, 10.00, 1, 1, 13, 13, 30, 13);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (52, 'Think & Grow Rich Book Reading', 'A motivating book reading event where we dive into Think and Grow Rich, exploring its timeless principles for success and personal growth.', '2025-8-7', '7:00:00', '8:30:00', NULL, NULL, NULL, 0.00, 1, 1, 15, 15, 32, 22);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (53, 'Ice Fishing at Strawberry', 'A thrilling day of ice fishing at Strawberry Reservoir, enjoying the frozen landscape, great company, and the chance to reel in some big catches!', '2025-2-15', '9:00:00', '12:00:00', NULL, NULL, NULL, 20.00, 1, 1, 16, 16, 33, 23);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (54, 'Fly Fishing at Provo River', 'A relaxing day of fly fishing at the Provo River, surrounded by scenic views, flowing water, and the thrill of the perfect cast.', '2025-6-8', '8:00:00', '11:00:00', NULL, NULL, NULL, 10.00, 1, 2, 16, 16, 34, 23);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (55, '5v5 Pickup Games', 'A fast-paced and fun 5v5 pickup basketball game—bring your skills, energy, and team spirit for some friendly competition on the court!', '2025-6-23', '11:00:00', '1:00:00', NULL, NULL, NULL, 0.00, 1, 2, 1, 1, 36, 26);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (56, 'Casual Basketball at the Park', 'A laid-back and fun pickup basketball game—come shoot hoops, get some exercise, and enjoy friendly competition on the court!', '2025-7-9', '2:00:00', '4:00:00', NULL, NULL, NULL, 0.00, 1, 2, 1, 1, 36, 26);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (57, '1v1 Pickleball Meetup', 'A competitive yet fun 1v1 pickleball meetup—test your skills, challenge a partner, and enjoy fast-paced rallies on the court!', '2025-8-15', '12:00:00', '2:00:00', 'https://cdn.sanity.io/images/jvolei4i/production/cded304f5af6eacc8194c370ba7ea2a840c57128-736x490.png', NULL, NULL, 0.00, 1, 2, 1, 1, 1, 1);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (58, 'Family Pickleball Day', 'A fun-filled Family Pickleball Day for all ages! Enjoy friendly games, laughter, and quality time on the court.', '2025-9-4', '10:00:00', '12:00:00', 'https://6amcity.brightspotcdn.com/dims4/default/28f6e85/2147483647/strip/true/crop/808x455+0+0/resize/1000x563!/quality/90/?url=https%3A%2F%2Fk1-prod-sixam-city.s3.us-east-2.amazonaws.com%2Fbrightspot%2F2f%2Fd2%2F3e542ff54630931713a46e0c6f29%2Fscreen-shot-2022-11-18-at-1.43.51%20PM.png', NULL, NULL, 0.00, 1, 2, 1, 1, 1, 20);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (59, 'Splendor Board Game Night', 'A fun and strategic game night featuring Splendor! Come test your skills, collect gems, and compete to build the most successful empire.', '2025-8-7', '7:00:00', '9:00:00', 'https://m.media-amazon.com/images/I/81Ny4ShcdOL.jpg', NULL, NULL, 10.00, 1, 1, 3, 3, 3, 3);
INSERT INTO `social_event` (`id`, `title`, `description`, `event_date`, `start_time`, `end_time`, `image_url`, `create_date`, `last_update`, `cost`, `enabled`, `member_only`, `meet_address_id`, `event_address_id`, `social_group_id`, `user_id`) VALUES (60, 'Intro to Javascript', 'A beginner-friendly night diving into JavaScript! Learn the basics of coding, interactive web development, and get hands-on with fun exercises.', '2025-9-6', '11:00:00', '1:00:00', 'https://i.ytimg.com/vi/LImhRKI_AVs/sddefault.jpg', NULL, NULL, 200.00, 1, 2, 4, 4, 20, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `group_user`
-- -----------------------------------------------------
START TRANSACTION;
USE `gatherrounddb`;
INSERT INTO `group_user` (`user_id`, `group_id`, `approved`, `create_date`, `approved_date`, `leader`) VALUES (1, 1, 1, '2025-1-23', '2025-1-24', 1);
INSERT INTO `group_user` (`user_id`, `group_id`, `approved`, `create_date`, `approved_date`, `leader`) VALUES (2, 1, 1, '2025-2-3', '2025-2-3', 1);
INSERT INTO `group_user` (`user_id`, `group_id`, `approved`, `create_date`, `approved_date`, `leader`) VALUES (3, 3, 1, '2025-2-5', '2025-2-5', 1);
INSERT INTO `group_user` (`user_id`, `group_id`, `approved`, `create_date`, `approved_date`, `leader`) VALUES (4, 4, 1, '2025-2-8', '2025-2-8', 1);
INSERT INTO `group_user` (`user_id`, `group_id`, `approved`, `create_date`, `approved_date`, `leader`) VALUES (5, 5, 1, '2025-2-11', '2025-2-12', 1);
INSERT INTO `group_user` (`user_id`, `group_id`, `approved`, `create_date`, `approved_date`, `leader`) VALUES (6, 6, 1, '2025-2-12', '2025-2-12', 1);
INSERT INTO `group_user` (`user_id`, `group_id`, `approved`, `create_date`, `approved_date`, `leader`) VALUES (7, 7, 1, '2025-2-12', '2025-2-13', 1);
INSERT INTO `group_user` (`user_id`, `group_id`, `approved`, `create_date`, `approved_date`, `leader`) VALUES (8, 8, 1, '2025-2-13', '2025-2-13', 1);
INSERT INTO `group_user` (`user_id`, `group_id`, `approved`, `create_date`, `approved_date`, `leader`) VALUES (9, 9, 1, '2025-2-13', '2025-2-14', 1);
INSERT INTO `group_user` (`user_id`, `group_id`, `approved`, `create_date`, `approved_date`, `leader`) VALUES (10, 10, 1, '2025-2-15', '2025-2-15', 1);

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

