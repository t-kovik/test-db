CREATE DATABASE  IF NOT EXISTS `storage` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `storage`;
-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: storage
-- ------------------------------------------------------
-- Server version	8.0.26

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
-- Table structure for table `expenditure`
--

DROP TABLE IF EXISTS `expenditure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expenditure` (
  `exp_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `amount` int DEFAULT NULL,
  `store_id` int NOT NULL,
  `shipping_date` date NOT NULL,
  PRIMARY KEY (`exp_id`),
  KEY `fk_product_id_expenditure_idx` (`product_id`),
  KEY `fk_store_expenditure_idx` (`store_id`),
  CONSTRAINT `fk_product_id_expenditure` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `fk_store_expenditure` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenditure`
--

LOCK TABLES `expenditure` WRITE;
/*!40000 ALTER TABLE `expenditure` DISABLE KEYS */;
INSERT INTO `expenditure` VALUES (1,9,24,3,'2021-08-10'),(2,5,18,3,'2021-08-10'),(3,2,350,4,'2021-10-06');
/*!40000 ALTER TABLE `expenditure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `keeping`
--

DROP TABLE IF EXISTS `keeping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `keeping` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `store_id` int NOT NULL,
  `amount` int DEFAULT NULL,
  `shipping_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_product_keeping_idx` (`product_id`),
  KEY `fk_store_keeping_idx` (`store_id`),
  CONSTRAINT `fk_product_keeping` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `fk_store_keeping` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `keeping`
--

LOCK TABLES `keeping` WRITE;
/*!40000 ALTER TABLE `keeping` DISABLE KEYS */;
INSERT INTO `keeping` VALUES (1,1,1,110,'2021-02-25'),(2,2,4,350,'2021-02-08'),(3,3,4,125,'2021-05-10'),(4,4,3,1000,'2020-11-11'),(5,5,3,14,'2021-06-17'),(6,6,4,20,'2021-06-21'),(7,7,1,300,'2021-08-05'),(8,8,1,10,'2021-09-28'),(9,9,3,24,'2021-07-14');
/*!40000 ALTER TABLE `keeping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package_type`
--

DROP TABLE IF EXISTS `package_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `package_type` (
  `package_id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`package_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_type`
--

LOCK TABLES `package_type` WRITE;
/*!40000 ALTER TABLE `package_type` DISABLE KEYS */;
INSERT INTO `package_type` VALUES (1,'коробка'),(2,'пакет'),(3,'ящик');
/*!40000 ALTER TABLE `package_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `unit_id` int NOT NULL,
  `package_id` int NOT NULL,
  `name` varchar(128) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`product_id`),
  KEY `fk_unit_product_idx` (`unit_id`),
  KEY `fk_package_type_product_idx` (`package_id`),
  CONSTRAINT `fk_package_type_product` FOREIGN KEY (`package_id`) REFERENCES `package_type` (`package_id`),
  CONSTRAINT `fk_unit_product` FOREIGN KEY (`unit_id`) REFERENCES `unit_type` (`unit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,1,1,'Клавиатура'),(2,1,1,'Мышь'),(3,1,1,'Наушники'),(4,1,2,'Коврик для мыши'),(5,1,3,'Монитор'),(6,1,3,'Принтер'),(7,2,2,'Кабель'),(8,3,1,'Бумага'),(9,3,2,'Кронштейн');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receipt`
--

DROP TABLE IF EXISTS `receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receipt` (
  `receipt_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `amount` int NOT NULL,
  `store_id` int NOT NULL,
  `shipping_date` date NOT NULL,
  PRIMARY KEY (`receipt_id`),
  KEY `fk_product_receipt_idx` (`product_id`),
  KEY `fk_store_receipt_idx` (`store_id`),
  CONSTRAINT `fk_product_receipt` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_store_receipt` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receipt`
--

LOCK TABLES `receipt` WRITE;
/*!40000 ALTER TABLE `receipt` DISABLE KEYS */;
INSERT INTO `receipt` VALUES (1,9,24,4,'2021-08-10'),(2,5,18,1,'2021-08-10'),(3,2,350,2,'2021-10-06'),(4,1,10,3,'2021-10-19'),(5,2,4,2,'2021-10-20');
/*!40000 ALTER TABLE `receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store`
--

DROP TABLE IF EXISTS `store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store` (
  `store_id` int NOT NULL AUTO_INCREMENT,
  `address` varchar(128) COLLATE utf8_bin NOT NULL,
  `special_equipment` tinyint(1) NOT NULL,
  `area` decimal(5,2) NOT NULL,
  PRIMARY KEY (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store`
--

LOCK TABLES `store` WRITE;
/*!40000 ALTER TABLE `store` DISABLE KEYS */;
INSERT INTO `store` VALUES (1,'Иваново',0,565.70),(2,'Ярославль',0,455.60),(3,'Санкт-Петербург',1,700.00),(4,'Москва',1,900.55);
/*!40000 ALTER TABLE `store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit_type`
--

DROP TABLE IF EXISTS `unit_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unit_type` (
  `unit_id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`unit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit_type`
--

LOCK TABLES `unit_type` WRITE;
/*!40000 ALTER TABLE `unit_type` DISABLE KEYS */;
INSERT INTO `unit_type` VALUES (1,'штука'),(2,'метр'),(3,'упаковка');
/*!40000 ALTER TABLE `unit_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-24 17:14:54
