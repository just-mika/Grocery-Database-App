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
  `product_total` float NOT NULL DEFAULT '0',
  `price` float NOT NULL DEFAULT '0',
  `product_code` int NOT NULL,
  `sales_transactions_transaction_id` int NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `fk_customer_items_product_info1_idx` (`product_code`),
  KEY `fk_customer_items_sales_transactions1_idx` (`sales_transactions_transaction_id`),
  CONSTRAINT `fk_customer_items_product_info1` FOREIGN KEY (`product_code`) REFERENCES `product_info` (`product_code`),
  CONSTRAINT `fk_customer_items_sales_transactions1` FOREIGN KEY (`sales_transactions_transaction_id`) REFERENCES `sales_transactions` (`transaction_id`)
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
  `price` float NOT NULL DEFAULT '0',
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
  `cost` float unsigned NOT NULL DEFAULT '0',
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
  `total_cost` float NOT NULL DEFAULT '0',
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

-- Dump completed on 2024-11-18 21:31:36
