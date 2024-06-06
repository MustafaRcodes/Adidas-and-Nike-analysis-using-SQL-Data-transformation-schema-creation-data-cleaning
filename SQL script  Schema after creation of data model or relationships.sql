-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema retaildata_new
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema retaildata_new
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `retaildata_new` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `retaildata_new` ;

-- -----------------------------------------------------
-- Table `retaildata_new`.`brands`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `retaildata_new`.`brands` (
  `product_id` VARCHAR(50) NOT NULL,
  `brand` VARCHAR(50) NULL DEFAULT NULL,
  `modified_brand` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE INDEX `product_id_UNIQUE` (`product_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `retaildata_new`.`finance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `retaildata_new`.`finance` (
  `product_id` VARCHAR(50) NOT NULL,
  `listing_price` DOUBLE NULL DEFAULT NULL,
  `sale_price` DOUBLE NULL DEFAULT NULL,
  `discount` DOUBLE NULL DEFAULT NULL,
  `revenue` DOUBLE NULL DEFAULT NULL,
  `modified_listing_price` DOUBLE NULL DEFAULT NULL,
  `modified_sale_price` DOUBLE NULL DEFAULT NULL,
  `modified_discount` DOUBLE NULL DEFAULT NULL,
  `modified_revenue` DOUBLE NULL DEFAULT NULL,
  `brands_product_id` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE INDEX `finance_product_id_IDX` (`product_id` ASC) VISIBLE,
  INDEX `fk_finance_brands1_idx` (`brands_product_id` ASC) VISIBLE,
  CONSTRAINT `fk_finance_brands1`
    FOREIGN KEY (`brands_product_id`)
    REFERENCES `retaildata_new`.`brands` (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `retaildata_new`.`info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `retaildata_new`.`info` (
  `product_name` VARCHAR(512) NULL DEFAULT NULL,
  `product_id` VARCHAR(50) NOT NULL,
  `description` VARCHAR(1000) NULL DEFAULT NULL,
  `modified_product_name` VARCHAR(512) NULL DEFAULT NULL,
  `modified_description` VARCHAR(1000) NULL DEFAULT NULL,
  `brands_product_id` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE INDEX `info_product_id_IDX` (`product_id` ASC) VISIBLE,
  INDEX `fk_info_brands1_idx` (`brands_product_id` ASC) VISIBLE,
  CONSTRAINT `fk_info_brands1`
    FOREIGN KEY (`brands_product_id`)
    REFERENCES `retaildata_new`.`brands` (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `retaildata_new`.`reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `retaildata_new`.`reviews` (
  `product_id` VARCHAR(50) NOT NULL,
  `rating` VARCHAR(50) NULL DEFAULT NULL,
  `reviews` VARCHAR(50) NULL DEFAULT NULL,
  `Hour` DOUBLE NULL DEFAULT NULL,
  `minute` DOUBLE NULL DEFAULT NULL,
  `real_rating` VARCHAR(50) NULL DEFAULT NULL,
  `real_reviews` DOUBLE NULL DEFAULT NULL,
  `Unnamed` VARCHAR(50) NULL DEFAULT NULL,
  `brands_product_id` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE INDEX `product_id_UNIQUE` (`product_id` ASC) VISIBLE,
  INDEX `fk_reviews_brands_idx` (`brands_product_id` ASC) VISIBLE,
  CONSTRAINT `fk_reviews_brands`
    FOREIGN KEY (`brands_product_id`)
    REFERENCES `retaildata_new`.`brands` (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `retaildata_new`.`traffic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `retaildata_new`.`traffic` (
  `product_id` VARCHAR(50) NOT NULL,
  `last_visited` TINYTEXT NULL DEFAULT NULL,
  `modified_last_visited` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE INDEX `product_id_UNIQUE` (`product_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `retaildata_new`.`traffic_has_reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `retaildata_new`.`traffic_has_reviews` (
  `traffic_product_id` VARCHAR(50) NOT NULL,
  `reviews_product_id` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`traffic_product_id`, `reviews_product_id`),
  INDEX `fk_traffic_has_reviews_reviews1_idx` (`reviews_product_id` ASC) VISIBLE,
  INDEX `fk_traffic_has_reviews_traffic1_idx` (`traffic_product_id` ASC) VISIBLE,
  CONSTRAINT `fk_traffic_has_reviews_reviews1`
    FOREIGN KEY (`reviews_product_id`)
    REFERENCES `retaildata_new`.`reviews` (`product_id`),
  CONSTRAINT `fk_traffic_has_reviews_traffic1`
    FOREIGN KEY (`traffic_product_id`)
    REFERENCES `retaildata_new`.`traffic` (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
