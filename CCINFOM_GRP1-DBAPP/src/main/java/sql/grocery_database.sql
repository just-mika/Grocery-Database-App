-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema grocery_database
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `grocery_database` ;

-- -----------------------------------------------------
-- Schema grocery_database
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `grocery_database` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `grocery_database` ;

-- -----------------------------------------------------
-- Table `grocery_database`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grocery_database`.`customer` ;

CREATE TABLE IF NOT EXISTS `grocery_database`.`customer` (
  `customer_id` INT NOT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `contact_number` INT NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `grocery_database`.`product_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grocery_database`.`product_info` ;

CREATE TABLE IF NOT EXISTS `grocery_database`.`product_info` (
  `product_code` INT NOT NULL,
  `product_name` VARCHAR(45) NULL DEFAULT NULL,
  `price` FLOAT NOT NULL DEFAULT '0',
  `product_category` VARCHAR(45) NULL DEFAULT NULL,
  `quantity_in_stock` INT NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `grocery_database`.`sales_transactions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grocery_database`.`sales_transactions` ;

CREATE TABLE IF NOT EXISTS `grocery_database`.`sales_transactions` (
  `transaction_id` INT NOT NULL,
  `total_items` INT NOT NULL DEFAULT '0',
  `total_cost` FLOAT NOT NULL DEFAULT '0',
  `date_of_sale` DATETIME NULL DEFAULT NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`transaction_id`),
  INDEX `fk_sales_transactions_customer1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_sales_transactions_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `grocery_database`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `grocery_database`.`customer_items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grocery_database`.`customer_items` ;

CREATE TABLE IF NOT EXISTS `grocery_database`.`customer_items` (
  `item_id` INT NOT NULL,
  `quantity` INT NOT NULL DEFAULT '0',
  `product_total` FLOAT NOT NULL DEFAULT 0.0,
  `price` FLOAT NOT NULL DEFAULT '0',
  `product_code` INT NOT NULL,
  `sales_transactions_transaction_id` INT NOT NULL,
  PRIMARY KEY (`item_id`),
  INDEX `fk_customer_items_product_info1_idx` (`product_code` ASC) VISIBLE,
  INDEX `fk_customer_items_sales_transactions1_idx` (`sales_transactions_transaction_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_items_product_info1`
    FOREIGN KEY (`product_code`)
    REFERENCES `grocery_database`.`product_info` (`product_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_items_sales_transactions1`
    FOREIGN KEY (`sales_transactions_transaction_id`)
    REFERENCES `grocery_database`.`sales_transactions` (`transaction_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `grocery_database`.`payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grocery_database`.`payment` ;

CREATE TABLE IF NOT EXISTS `grocery_database`.`payment` (
  `payment_id` INT NOT NULL,
  `payment_type` VARCHAR(45) NULL,
  `transaction_id` INT NOT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `fk_payment_sales_transactions_idx` (`transaction_id` ASC) VISIBLE,
  CONSTRAINT `fk_payment_sales_transactions`
    FOREIGN KEY (`transaction_id`)
    REFERENCES `grocery_database`.`sales_transactions` (`transaction_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `grocery_database`.`supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grocery_database`.`supplier` ;

CREATE TABLE IF NOT EXISTS `grocery_database`.`supplier` (
  `supplier_code` INT NOT NULL,
  `supplier_name` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`supplier_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `grocery_database`.`product_order_batch`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grocery_database`.`product_order_batch` ;

CREATE TABLE IF NOT EXISTS `grocery_database`.`product_order_batch` (
  `batch_id` INT UNSIGNED NOT NULL,
  `quantity_ordered` INT UNSIGNED NOT NULL DEFAULT '0',
  `date_ordered` DATETIME NULL DEFAULT NULL,
  `cost` FLOAT UNSIGNED NOT NULL DEFAULT '0',
  `product_code` INT NOT NULL,
  `supplier_code` INT NOT NULL,
  PRIMARY KEY (`batch_id`),
  INDEX `fk_product_order_batch_product_info1_idx` (`product_code` ASC) VISIBLE,
  INDEX `fk_product_order_batch_supplier1_idx` (`supplier_code` ASC) VISIBLE,
  CONSTRAINT `fk_product_order_batch_product_info1`
    FOREIGN KEY (`product_code`)
    REFERENCES `grocery_database`.`product_info` (`product_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_order_batch_supplier1`
    FOREIGN KEY (`supplier_code`)
    REFERENCES `grocery_database`.`supplier` (`supplier_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `grocery_database`.`securitycheck`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grocery_database`.`securitycheck` ;

CREATE TABLE IF NOT EXISTS `grocery_database`.`securitycheck` (
  `idsecuritycheck` INT NOT NULL,
  `password` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idsecuritycheck`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
