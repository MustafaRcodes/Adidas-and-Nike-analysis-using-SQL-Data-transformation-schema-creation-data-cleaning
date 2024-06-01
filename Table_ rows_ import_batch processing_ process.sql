CREATE TABLE IF NOT EXISTS `retaildata`.`brandscsvimport` (
  `product_id` VARCHAR(50) NULL DEFAULT NULL,
  `brand` VARCHAR(50) NULL DEFAULT NULL,
  `modified_brand` VARCHAR(100) NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Brands.csv' INTO TABLE brandscsvimport
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;
--- below is to check path where CSV file will be saved for batch processing or loading 
SHOW VARIABLES LIKE "secure_file_priv";
