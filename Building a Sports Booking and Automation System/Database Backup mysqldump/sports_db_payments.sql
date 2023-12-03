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
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `Amount` decimal(6,2) NOT NULL,
  `Datetime_of_payment` datetime DEFAULT CURRENT_TIMESTAMP,
  `member_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `payment_member_idx` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `payment_update` AFTER INSERT ON `payments` FOR EACH ROW BEGIN
	DECLARE pending_member VARCHAR(255) DEFAULT NULL;
    DECLARE actual_member VARCHAR(255) DEFAULT NULL;
    DECLARE p_payment_due VARCHAR(255) DEFAULT NULL;
    DECLARE a_payment_due VARCHAR(255) DEFAULT NULL;
    
    -- Input the member who made payment into the variables
    SELECT member_id
    INTO actual_member
    FROM membership
    WHERE member_id = new.member_id;
    
    SELECT payment_due
    INTO a_payment_due
    FROM membership
    WHERE member_id = new.member_id;
    
    SELECT payment_due
    INTO p_payment_due
    FROM pending_terminations
    WHERE member_id = new.member_id;
    
    SELECT member_id
    INTO pending_member
    FROM pending_terminations
    WHERE member_id = new.member_id;
    
    -- Setting up the condition for trigger
    IF actual_member IS NOT NULL AND pending_member IS NULL AND new.amount >= 0 THEN
		IF new.amount >= a_payment_due THEN
			UPDATE membership
			SET payment_due = 0
			WHERE member_id = new.member_id;
            
            UPDATE bookings
            SET payment_status = "Paid"
            WHERE member_id = new.member_id;
            
           -- SELECT "Full Payment made successfully" AS Output;
		ELSE 
			UPDATE membership
			SET payment_due = payment_due - new.amount
			WHERE member_id = new.member_id;
            
          --  SELECT "Part Payment made successfully" AS Output;
		END IF;
        
	ELSEIF actual_member IS NULL AND pending_member IS NOT NULL and new.amount >= 0 THEN
		IF new.amount >= p_payment_due THEN
			UPDATE pending_terminations
            SET payment_due = 0
            WHERE member_id = new.member_id;
            
			DELETE FROM pending_terminations
			WHERE member_id = new.member_id;
            
          --  SELECT "Full Payment made successfully" AS Output;
		ELSE 
			UPDATE pending_terminations
            SET payment_due = payment_due - new.amount
            WHERE member_id = new.member_id;
            
         --   SELECT "Part Payment made successfully" AS Output;
		END IF;
	-- ELSE 
		-- SELECT "Payment made is Zero or Below Zero" AS Output;
        
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-30  9:50:27
