-- MySQL Script generated by MySQL Workbench
-- 11/19/15 02:45:03
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema SM
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema SM
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SM` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `SM` ;


-- -----------------------------------------------------
-- Table `SM`.`genderbread`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SM`.`genderbread` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `genderbread_identity` ENUM('1', '2', '3', '4', '5', '6', '7') NULL,
  `genderbread_identity_visibility` ENUM('Public', 'Protected', 'Private') NULL,
  `genderbread_expression` ENUM('1', '2', '3', '4', '5', '6', '7') NULL,
  `genderbread_expression_visibility` ENUM('Public', 'Protected', 'Private') NULL,
  `genderbread_asex` ENUM('1', '2', '3', '4', '5', '6', '7') NOT NULL,
  `genderbread_asex_visibility` ENUM('Public', 'Protected', 'Private') NOT NULL,
  `genderbread_attracted` ENUM('1', '2', '3', '4', '5', '6', '7') NULL,
  `genderbread_attracted_visibility` ENUM('Public', 'Protected', 'Private') NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SM`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SM`.`user` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `auth_key` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `password_hash` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `password_reset_token` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL,
  `email` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `status` SMALLINT(6) NOT NULL DEFAULT '10',
  `created_at` INT(11) NOT NULL,
  `updated_at` INT(11) NOT NULL,
  `lastname` VARCHAR(255) NOT NULL,
  `data_of_birth` DATE NOT NULL,
  `genderbread_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username` (`username` ASC),
  UNIQUE INDEX `email` (`email` ASC),
  UNIQUE INDEX `password_reset_token` (`password_reset_token` ASC),
  INDEX `fk_user_genderbread_idx` (`genderbread_id` ASC),
  CONSTRAINT `fk_user_genderbread`
    FOREIGN KEY (`genderbread_id`)
    REFERENCES `SM`.`genderbread` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `SM`.`migration`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SM`.`migration` (
  `version` VARCHAR(180) NOT NULL,
  `apply_time` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`version`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SM`.`accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SM`.`accounts` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `accounts_status` ENUM('Active', 'Cancel', 'Suspend', 'Disable') NOT NULL,
  `accounts_registered` DATE NOT NULL,
  `accounts_cancelled` DATE NULL,
  `user_id` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_accounts_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_accounts_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `SM`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SM`.`messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SM`.`messages` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `messages_text` BLOB NOT NULL,
  `messages_date` DATE NOT NULL,
  `messages_time` TIME(6) NOT NULL,
  `accounts_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_messages_accounts1_idx` (`accounts_id` ASC),
  CONSTRAINT `fk_messages_accounts1`
    FOREIGN KEY (`accounts_id`)
    REFERENCES `SM`.`accounts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SM`.`types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SM`.`types` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `types_object` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SM`.`photos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SM`.`photos` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `photos_name` VARCHAR(90) NULL,
  `photos_path` VARCHAR(90) NOT NULL,
  `photos_caption` TEXT NULL,
  `photos_date` DATE NOT NULL,
  `photos_time` TIME(6) NOT NULL,
  `accounts_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_photos_accounts1_idx` (`accounts_id` ASC),
  CONSTRAINT `fk_photos_accounts1`
    FOREIGN KEY (`accounts_id`)
    REFERENCES `SM`.`accounts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SM`.`network`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SM`.`network` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `network_name` VARCHAR(90) NOT NULL,
  `network_description` TEXT NULL,
  `accounts_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_network_accounts1_idx` (`accounts_id` ASC),
  CONSTRAINT `fk_network_accounts1`
    FOREIGN KEY (`accounts_id`)
    REFERENCES `SM`.`accounts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SM`.`user_has_photos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SM`.`user_has_photos` (
  `user_id` INT(11) UNSIGNED NOT NULL,
  `photos_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`, `photos_id`),
  INDEX `fk_user_has_photos_photos1_idx` (`photos_id` ASC),
  INDEX `fk_user_has_photos_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_photos_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `SM`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_photos_photos1`
    FOREIGN KEY (`photos_id`)
    REFERENCES `SM`.`photos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `SM`.`user_has_messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SM`.`user_has_messages` (
  `user_id` INT(11) UNSIGNED NOT NULL,
  `messages_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`, `messages_id`),
  INDEX `fk_user_has_messages_messages1_idx` (`messages_id` ASC),
  INDEX `fk_user_has_messages_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_messages_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `SM`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_messages_messages1`
    FOREIGN KEY (`messages_id`)
    REFERENCES `SM`.`messages` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `SM`.`network_has_messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SM`.`network_has_messages` (
  `network_id` INT UNSIGNED NOT NULL,
  `messages_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`network_id`, `messages_id`),
  INDEX `fk_network_has_messages_messages1_idx` (`messages_id` ASC),
  INDEX `fk_network_has_messages_network1_idx` (`network_id` ASC),
  CONSTRAINT `fk_network_has_messages_network1`
    FOREIGN KEY (`network_id`)
    REFERENCES `SM`.`network` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_network_has_messages_messages1`
    FOREIGN KEY (`messages_id`)
    REFERENCES `SM`.`messages` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SM`.`user_has_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SM`.`user_has_types` (
  `user_id` INT(11) UNSIGNED NOT NULL,
  `types_id` INT UNSIGNED NOT NULL,
  `messages_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`, `types_id`),
  INDEX `fk_user_has_types_types1_idx` (`types_id` ASC),
  INDEX `fk_user_has_types_user1_idx` (`user_id` ASC),
  INDEX `fk_user_has_types_messages1_idx` (`messages_id` ASC),
  CONSTRAINT `fk_user_has_types_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `SM`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_types_types1`
    FOREIGN KEY (`types_id`)
    REFERENCES `SM`.`types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_types_messages1`
    FOREIGN KEY (`messages_id`)
    REFERENCES `SM`.`messages` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `SM`.`user_has_types1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SM`.`user_has_types1` (
  `user_id` INT(11) UNSIGNED NOT NULL,
  `types_id` INT UNSIGNED NOT NULL,
  `photos_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`, `types_id`),
  INDEX `fk_user_has_types1_types1_idx` (`types_id` ASC),
  INDEX `fk_user_has_types1_user1_idx` (`user_id` ASC),
  INDEX `fk_user_has_types1_photos1_idx` (`photos_id` ASC),
  CONSTRAINT `fk_user_has_types1_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `SM`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_types1_types1`
    FOREIGN KEY (`types_id`)
    REFERENCES `SM`.`types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_types1_photos1`
    FOREIGN KEY (`photos_id`)
    REFERENCES `SM`.`photos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `SM`.`network_has_photos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SM`.`network_has_photos` (
  `network_id` INT UNSIGNED NOT NULL,
  `photos_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`network_id`, `photos_id`),
  INDEX `fk_network_has_photos_photos1_idx` (`photos_id` ASC),
  INDEX `fk_network_has_photos_network1_idx` (`network_id` ASC),
  CONSTRAINT `fk_network_has_photos_network1`
    FOREIGN KEY (`network_id`)
    REFERENCES `SM`.`network` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_network_has_photos_photos1`
    FOREIGN KEY (`photos_id`)
    REFERENCES `SM`.`photos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SM`.`photos_has_messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SM`.`photos_has_messages` (
  `photos_id` INT UNSIGNED NOT NULL,
  `messages_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`photos_id`, `messages_id`),
  INDEX `fk_photos_has_messages_messages1_idx` (`messages_id` ASC),
  INDEX `fk_photos_has_messages_photos1_idx` (`photos_id` ASC),
  CONSTRAINT `fk_photos_has_messages_photos1`
    FOREIGN KEY (`photos_id`)
    REFERENCES `SM`.`photos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_photos_has_messages_messages1`
    FOREIGN KEY (`messages_id`)
    REFERENCES `SM`.`messages` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SM`.`network_has_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SM`.`network_has_user` (
  `network_id` INT UNSIGNED NOT NULL,
  `user_id` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`network_id`, `user_id`),
  INDEX `fk_network_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_network_has_user_network1_idx` (`network_id` ASC),
  CONSTRAINT `fk_network_has_user_network1`
    FOREIGN KEY (`network_id`)
    REFERENCES `SM`.`network` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_network_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `SM`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SM`.`user_has_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SM`.`user_has_user` (
  `user_id` INT(11) UNSIGNED NOT NULL,
  `user_id1` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`, `user_id1`),
  INDEX `fk_user_has_user_user2_idx` (`user_id1` ASC),
  INDEX `fk_user_has_user_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `SM`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_user_user2`
    FOREIGN KEY (`user_id1`)
    REFERENCES `SM`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
