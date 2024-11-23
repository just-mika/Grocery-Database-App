CREATE DATABASE  IF NOT EXISTS `grocery_database` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `grocery_database`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: grocery_database
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int NOT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `first_name` varchar(45) DEFAULT NULL,
  `contact_number` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Smith','John','12345678901'),(2,'Doe','Jane','98765432101'),(3,'Johnson','Emily','55544433221'),(4,'Brown','Michael','32145698701'),(5,'Taylor','Jessica','65498712301'),(6,'Davis','Daniel','78965412301'),(7,'Miller','Emma','45632178901'),(8,'Wilson','Sophia','32178945601'),(9,'Moore','Olivia','12398745601'),(10,'Anderson','Liam','45678912301');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_items`
--

DROP TABLE IF EXISTS `customer_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_items` (
  `item_id` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '0',
  `product_total` decimal(10,2) NOT NULL DEFAULT '0.00',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `product_code` int NOT NULL,
  `transaction_id` int NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `fk_customer_items_product_info1_idx` (`product_code`),
  KEY `fk_customer_items_sales_transactions1_idx` (`transaction_id`),
  CONSTRAINT `fk_customer_items_product_info1` FOREIGN KEY (`product_code`) REFERENCES `product_info` (`product_code`),
  CONSTRAINT `fk_customer_items_sales_transactions1` FOREIGN KEY (`transaction_id`) REFERENCES `sales_transactions` (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_items`
--

LOCK TABLES `customer_items` WRITE;
/*!40000 ALTER TABLE `customer_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `payment_id` int NOT NULL,
  `payment_type` varchar(45) DEFAULT NULL,
  `transaction_id` int NOT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `fk_payment_sales_transactions_idx` (`transaction_id`),
  CONSTRAINT `fk_payment_sales_transactions` FOREIGN KEY (`transaction_id`) REFERENCES `sales_transactions` (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_info`
--

DROP TABLE IF EXISTS `product_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_info` (
  `product_code` int NOT NULL,
  `product_name` varchar(45) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `product_category` varchar(45) DEFAULT NULL,
  `quantity_in_stock` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_info`
--

LOCK TABLES `product_info` WRITE;
/*!40000 ALTER TABLE `product_info` DISABLE KEYS */;
INSERT INTO `product_info` VALUES (101,'Banana (per kilo)',90.00,'Fruit',100),(102,'Mango (per kilo)',150.00,'Fruit',50),(201,'Carrots (per kilo)',100.00,'Vegetables',60),(202,'Potatoes (per kilo)',80.00,'Vegetables',80),(301,'Fresh Milk (1L)',90.00,'Dairy',100),(302,'Cheddar Cheese (200g)',120.00,'Dairy',40),(401,'Eggs (Tray of 30)',210.00,'Eggs',70),(402,'Eggs (Dozen)',90.00,'Eggs',0),(501,'Chicken Breast (per kilo)',200.00,'Meat',50),(502,'Pork Belly (per kilo)',280.00,'Meat',40),(601,'Tilapia (per kilo)',160.00,'Seafood',30),(602,'Shrimp (per kilo)',450.00,'Seafood',0),(701,'Pandesal (pack of 10)',35.00,'Bakery',100),(702,'Loaf Bread (500g)',70.00,'Bakery',80),(801,'Rice (per kilo)',50.00,'Staple',500),(802,'Cooking Oil (1L)',150.00,'Staple',100),(901,'Potato Chips (200g)',80.00,'Snacks',70),(902,'Chocolate Bar (50g)',40.00,'Snacks',0),(1001,'Bottled Water (1L)',25.00,'Beverages',200),(1002,'Soft Drink (1.5L)',65.00,'Beverages',150),(1101,'Dishwashing Liquid (500ml)',70.00,'Supplies',100),(1102,'Laundry Detergent (1kg)',180.00,'Supplies',0),(1201,'Toothpaste (150g)',85.00,'Hygiene',200),(1202,'Shampoo (400ml)',180.00,'Hygiene',100);
/*!40000 ALTER TABLE `product_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_order_batch`
--

DROP TABLE IF EXISTS `product_order_batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_order_batch` (
  `batch_id` int unsigned NOT NULL,
  `quantity_ordered` int unsigned NOT NULL DEFAULT '0',
  `date_ordered` datetime DEFAULT NULL,
  `cost` decimal(10,2) NOT NULL DEFAULT '0.00',
  `product_code` int NOT NULL,
  `supplier_code` int NOT NULL,
  PRIMARY KEY (`batch_id`),
  KEY `fk_product_order_batch_product_info1_idx` (`product_code`),
  KEY `fk_product_order_batch_supplier1_idx` (`supplier_code`),
  CONSTRAINT `fk_product_order_batch_product_info1` FOREIGN KEY (`product_code`) REFERENCES `product_info` (`product_code`),
  CONSTRAINT `fk_product_order_batch_supplier1` FOREIGN KEY (`supplier_code`) REFERENCES `supplier` (`supplier_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_order_batch`
--

LOCK TABLES `product_order_batch` WRITE;
/*!40000 ALTER TABLE `product_order_batch` DISABLE KEYS */;
INSERT INTO `product_order_batch` VALUES (1,100,'2024-06-25 10:30:00',12000.00,602,6),(2,100,'2024-07-15 10:00:00',2500.00,902,10),(3,150,'2024-07-15 13:00:00',18000.00,602,6),(4,150,'2024-07-22 10:00:00',4500.00,1202,12),(5,250,'2024-07-25 10:30:00',5000.00,1102,11),(6,400,'2024-07-30 13:00:00',8000.00,1002,10),(7,100,'2024-08-05 10:00:00',9000.00,301,3),(8,300,'2024-08-05 11:00:00',3000.00,1101,11),(9,200,'2024-08-10 13:00:00',4000.00,1201,12),(10,150,'2024-08-10 15:00:00',3000.00,901,9),(11,60,'2024-08-12 09:15:00',6000.00,201,1),(12,50,'2024-08-20 13:00:00',10500.00,401,4),(13,200,'2024-08-20 14:00:00',6000.00,802,8),(14,500,'2024-08-25 09:30:00',2500.00,1001,10),(15,60,'2024-08-25 11:30:00',7200.00,502,5),(16,200,'2024-09-01 07:30:00',4000.00,701,7),(17,100,'2024-09-05 08:30:00',9000.00,402,4),(18,150,'2024-09-10 09:00:00',3000.00,702,7),(19,50,'2024-09-10 11:30:00',6000.00,302,3),(20,50,'2024-09-15 12:00:00',10000.00,501,5),(21,500,'2024-09-15 12:00:00',15000.00,801,8),(22,80,'2024-09-18 10:30:00',9600.00,601,6),(23,80,'2024-09-20 11:00:00',12000.00,102,1),(24,200,'2024-10-01 09:30:00',4000.00,901,9),(25,300,'2024-10-05 14:30:00',6000.00,1202,12),(26,700,'2024-10-10 16:00:00',3500.00,1001,10),(27,200,'2024-10-15 10:00:00',4000.00,702,7),(28,100,'2024-10-15 10:30:00',8000.00,101,1),(29,400,'2024-10-20 15:00:00',4000.00,1101,11),(30,150,'2024-11-01 14:00:00',3750.00,902,10),(31,250,'2024-11-01 16:30:00',7500.00,1202,12),(32,100,'2024-11-02 13:30:00',10000.00,201,2),(33,300,'2024-11-05 11:00:00',9000.00,802,8),(34,600,'2024-11-05 12:30:00',12000.00,1002,10),(35,100,'2024-11-05 13:00:00',12000.00,502,5),(36,150,'2024-11-05 14:45:00',12000.00,101,2),(37,120,'2024-11-08 12:00:00',14400.00,601,6),(38,350,'2024-11-09 09:00:00',7000.00,1102,11),(39,600,'2024-11-10 10:30:00',18000.00,801,8),(40,75,'2024-11-10 14:30:00',15000.00,501,5),(41,120,'2024-11-11 16:00:00',18000.00,102,2),(42,150,'2024-11-12 09:30:00',13500.00,301,3),(43,75,'2024-11-14 14:00:00',9000.00,302,3),(44,75,'2024-11-15 15:30:00',15750.00,401,4),(45,300,'2024-11-18 08:00:00',6000.00,701,7),(46,150,'2024-11-20 10:15:00',13500.00,402,4);
/*!40000 ALTER TABLE `product_order_batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_transactions`
--

DROP TABLE IF EXISTS `sales_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_transactions` (
  `transaction_id` int NOT NULL,
  `total_items` int NOT NULL DEFAULT '0',
  `total_cost` decimal(10,2) NOT NULL DEFAULT '0.00',
  `date_of_sale` datetime DEFAULT NULL,
  `customer_id` int NOT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `fk_sales_transactions_customer1_idx` (`customer_id`),
  CONSTRAINT `fk_sales_transactions_customer1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_transactions`
--

LOCK TABLES `sales_transactions` WRITE;
/*!40000 ALTER TABLE `sales_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `securitycheck`
--

DROP TABLE IF EXISTS `securitycheck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `securitycheck` (
  `idsecuritycheck` int NOT NULL,
  `password` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idsecuritycheck`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `securitycheck`
--

LOCK TABLES `securitycheck` WRITE;
/*!40000 ALTER TABLE `securitycheck` DISABLE KEYS */;
INSERT INTO `securitycheck` VALUES (1,'123456');
/*!40000 ALTER TABLE `securitycheck` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `supplier_code` int NOT NULL,
  `supplier_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`supplier_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES (1,'Fresh Harvest Inc.'),(2,'Tropical Produce Suppliers'),(3,'Dairy Delights Co.'),(4,'Golden Eggs Distributors'),(5,'Prime Cuts Meat Suppliers'),(6,'Ocean’s Bounty Seafood'),(7,'Baker’s Choice Enterprises'),(8,'Essential Pantry Distributors'),(9,'Snack Haven Supplies'),(10,'Thirst Quenchers Ltd.'),(11,'Household Essentials Corp.'),(12,'Hygiene Plus Solutions');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-23 12:59:49
