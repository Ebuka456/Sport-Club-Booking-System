CREATE DATABASE  IF NOT EXISTS `sports_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sports_db`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: sports_db
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `booking_id` int unsigned NOT NULL AUTO_INCREMENT,
  `facility_id` varchar(255) NOT NULL,
  `booked_date` date NOT NULL,
  `booked_time` time NOT NULL,
  `member_id` varchar(255) DEFAULT NULL,
  `datetime_of_booking` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `payment_status` varchar(255) NOT NULL DEFAULT 'Unpaid',
  PRIMARY KEY (`booking_id`),
  UNIQUE KEY `booking_id` (`booking_id`),
  UNIQUE KEY `unique_booking` (`facility_id`,`booked_date`,`booked_time`),
  KEY `member_fk` (`member_id`),
  KEY `booking_period_idx` (`booked_date`,`booked_time`),
  CONSTRAINT `facility_fk` FOREIGN KEY (`facility_id`) REFERENCES `facilities` (`facility_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `member_fk` FOREIGN KEY (`member_id`) REFERENCES `membership` (`member_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (1,'AR','2017-12-26','13:00:00','oreillys','2017-12-20 20:31:27','Paid'),(2,'MPF1','2017-12-30','17:00:00','noah51','2017-12-22 05:22:10','Paid'),(3,'T2','2017-12-31','16:00:00','macejkovic73','2017-12-28 18:14:23','Paid'),(4,'T1','2018-03-05','08:00:00','little31','2018-02-22 20:19:17','Unpaid'),(5,'MPF2','2018-03-02','11:00:00','marvin1','2018-03-01 16:13:45','Paid'),(6,'B1','2018-03-28','16:00:00','marvin1','2018-03-23 22:46:36','Paid'),(7,'B1','2018-04-15','14:00:00','macejkovic73','2018-04-12 22:23:20','Cancelled'),(8,'T2','2018-04-23','13:00:00','macejkovic73','2018-04-19 10:49:00','Cancelled'),(9,'T1','2018-05-25','10:00:00','marvin1','2018-05-21 11:20:46','Unpaid'),(10,'B2','2018-06-12','15:00:00','bbahringer','2018-05-30 14:40:23','Paid'),(11,'AR','2023-11-29','09:42:38','little31','2023-11-29 09:42:38','Unpaid');
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-30  9:50:26
