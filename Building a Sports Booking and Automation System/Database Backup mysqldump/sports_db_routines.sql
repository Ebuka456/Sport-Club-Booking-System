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
-- Temporary view structure for view `booking_vw`
--

DROP TABLE IF EXISTS `booking_vw`;
/*!50001 DROP VIEW IF EXISTS `booking_vw`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `booking_vw` AS SELECT 
 1 AS `booking_id`,
 1 AS `facility_id`,
 1 AS `facility_type`,
 1 AS `booked_date`,
 1 AS `booked_time`,
 1 AS `member_id`,
 1 AS `datetime_of_booking`,
 1 AS `payment_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `bookings_this_week`
--

DROP TABLE IF EXISTS `bookings_this_week`;
/*!50001 DROP VIEW IF EXISTS `bookings_this_week`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `bookings_this_week` AS SELECT 
 1 AS `booking_id`,
 1 AS `facility_id`,
 1 AS `facility_type`,
 1 AS `booked_date`,
 1 AS `DAY_OF_WEEK`,
 1 AS `booked_time`,
 1 AS `member_id`,
 1 AS `datetime_of_booking`,
 1 AS `payment_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `booking_vw`
--

/*!50001 DROP VIEW IF EXISTS `booking_vw`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `booking_vw` AS select `b`.`booking_id` AS `booking_id`,`b`.`facility_id` AS `facility_id`,`f`.`facility_type` AS `facility_type`,`b`.`booked_date` AS `booked_date`,`b`.`booked_time` AS `booked_time`,`b`.`member_id` AS `member_id`,`b`.`datetime_of_booking` AS `datetime_of_booking`,`b`.`payment_status` AS `payment_status` from (`bookings` `b` join `facilities` `f` on((`b`.`facility_id` = `f`.`facility_id`))) order by `b`.`booking_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `bookings_this_week`
--

/*!50001 DROP VIEW IF EXISTS `bookings_this_week`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `bookings_this_week` AS select `b`.`booking_id` AS `booking_id`,`b`.`facility_id` AS `facility_id`,`f`.`facility_type` AS `facility_type`,`b`.`booked_date` AS `booked_date`,dayname(`b`.`booked_date`) AS `DAY_OF_WEEK`,`b`.`booked_time` AS `booked_time`,`b`.`member_id` AS `member_id`,`b`.`datetime_of_booking` AS `datetime_of_booking`,`b`.`payment_status` AS `payment_status` from (`bookings` `b` join `facilities` `f` on((`b`.`facility_id` = `f`.`facility_id`))) where (week(`b`.`booked_date`,0) = week(now(),0)) order by `b`.`booking_id`,`b`.`booked_date` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping routines for database 'sports_db'
--
/*!50003 DROP PROCEDURE IF EXISTS `available_bookings` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `available_bookings`(
	IN p_date DATE,
    IN p_time INT,
    IN p_facility VARCHAR(255)
)
BEGIN 
	DECLARE v_facility VARCHAR(255) DEFAULT NULL;
    
    SELECT facility_id
    INTO v_facility
    FROM facilities
    WHERE facility_id = p_facility;
    
    IF p_date IS NULL AND p_time IS NULL AND p_facility IS NULL THEN
		SELECT "Null input parameters, Insert at least one non-null parameter" AS Output;
	ELSEIF p_date IS NOT NULL AND p_time IS NULL AND p_facility IS NULL THEN
		WITH DateRange AS (
				SELECT p_date AS date_value
			),
			timed as (
				SELECT 8 AS Hour UNION
				SELECT 9 UNION
				SELECT 10 UNION
				SELECT 11 UNION
				SELECT 12 UNION
				SELECT 13 UNION
				SELECT 14 UNION
				SELECT 15 UNION
				SELECT 16 UNION
				SELECT 17 
			),
			schedule AS (
				SELECT d.date_value Date, 
					   TIME_FORMAT(SEC_TO_TIME(t.hour * 3600), '%H:%i:%s') AS time, 
                       f.facility_id
				FROM timed t, 
					 daterange d, 
                     facilities f
			)
		SELECT s.*, 
			CASE WHEN b.booking_id IS NULL or b.payment_status = "Cancelled"
				THEN "Free"
			ELSE "Booked" 
			END AS "Booking Status"
		FROM schedule s LEFT JOIN bookings b
		ON b.facility_id = s.facility_id and b.booked_date = s.date and b.booked_time = s.time
			;
	ELSEIF p_date IS NOT NULL AND p_time NOT BETWEEN 8 AND 17 AND p_facility IS NULL THEN
		SELECT "Sport Complex open time is 8am to 5pm, input a time from 8 - 17" AS Output;
        
	ELSEIF p_date IS NOT NULL AND p_time BETWEEN 8 AND 17 AND p_facility IS NULL THEN
		WITH schedule AS (
			SELECT p_date Date, 
				TIME_FORMAT(SEC_TO_TIME(p_time * 3600), '%H:%i:%s') AS time, 
				f.facility_id
			FROM facilities f
			)
			SELECT s.*, 
				CASE WHEN b.booking_id IS NULL or b.payment_status = "Cancelled"
					THEN "Free"
				ELSE "Booked" 
				END AS "Booking Status"
			FROM schedule s LEFT JOIN bookings b
			ON b.facility_id = s.facility_id and b.booked_date = s.date and b.booked_time = s.time;
            
		ELSEIF p_date IS NOT NULL AND p_time BETWEEN 8 AND 17 AND v_facility IS NULL THEN
			SELECT "Invalid Facility ID, Input a correct Facility ID" AS Output;
            
		ELSEIF p_date IS NOT NULL AND p_time IS NULL AND p_facility = v_facility THEN
		WITH DateRange AS (
				SELECT p_date AS date_value
			),
			timed as (
				SELECT 8 AS Hour UNION
				SELECT 9 UNION
				SELECT 10 UNION
				SELECT 11 UNION
				SELECT 12 UNION
				SELECT 13 UNION
				SELECT 14 UNION
				SELECT 15 UNION
				SELECT 16 UNION
				SELECT 17 
			),
			schedule AS (
				SELECT d.date_value Date, 
					   TIME_FORMAT(SEC_TO_TIME(t.hour * 3600), '%H:%i:%s') AS time, 
                       p_facility AS facility_id
				FROM timed t, 
					 daterange d
			)
		SELECT s.*, 
			CASE WHEN b.booking_id IS NULL or b.payment_status = "Cancelled"
				THEN "Free"
			ELSE "Booked" 
			END AS "Booking Status"
		FROM schedule s LEFT JOIN bookings b
		ON b.facility_id = s.facility_id and b.booked_date = s.date and b.booked_time = s.time
			;
            
        ELSEIF p_date IS NOT NULL AND p_time BETWEEN 8 AND 17 AND p_facility = v_facility THEN 
			WITH schedule AS (
				SELECT p_date Date, 
					TIME_FORMAT(SEC_TO_TIME(p_time * 3600), '%H:%i:%s') AS time, 
					p_facility AS facility_id
				)
				SELECT s.*, 
					CASE WHEN b.booking_id IS NULL or b.payment_status = "Cancelled"
						THEN "Free"
					ELSE "Booked" 
					END AS "Booking Status"
				FROM schedule s LEFT JOIN bookings b
				ON b.facility_id = s.facility_id and b.booked_date = s.date and b.booked_time = s.time
			;
		ELSE 
			SELECT "Something is wrong Somewhere" AS Output;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cancel_bookings` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cancel_bookings`(
	p_booking_id VARCHAR(255)
)
BEGIN
	-- Declaring 4 variables to use to work
	DECLARE v_booked_date DATE;
    DECLARE v_payment_status VARCHAR(255);
    DECLARE v_member VARCHAR(255);
    DECLARE v_price DECIMAL(6,2);
    
    -- Input the result into the variables
    SELECT b.booked_date, 
		   b.payment_status,
           b.member_id,
           f.price
	INTO v_booked_date,
         v_payment_status,
         v_member,
         v_price
    FROM bookings b
	JOIN facilities f
	ON f.facility_id = b.facility_id
    WHERE b.booking_id = p_booking_id;
		
    -- To set the condtion for cancelling a booking
    IF v_booked_date >= NOW() THEN
		SELECT "Cancellation cannot be done on/after the booked date" AS Output;
	ELSEIF v_payment_status = "Paid" THEN
		SELECT "No Refunds. Cannot cancel paid bookings" AS Output;
	ELSEIF v_payment_status = "Cancelled" THEN
		SELECT "Booking has already been cancelled" AS Output;
	ELSE 
		UPDATE bookings
        SET payment_status = "Cancelled"
        WHERE booking_id = p_booking_id;
        
        -- Output message
        SELECT "Successfully Cancelled booking" AS Output;
	END IF;
    
    -- To update the payment due of the member
    UPDATE membership
    SET payment_due = payment_due - v_price
    WHERE member_id = v_member;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_member` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_member`(
	IN selected_member VARCHAR(255)
    )
BEGIN
	DELETE FROM membership
    WHERE member_id = selected_member;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_new_member` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_new_member`(
	IN p_id VARCHAR(255), 
    IN p_password VARCHAR(255), 
    IN p_email VARCHAR(255)
    )
BEGIN
	INSERT INTO membership (member_id, password, email)
    VALUES
		(p_id, p_password, p_email);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `make_booking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `make_booking`(
	IN p_facility VARCHAR(255),
    IN p_date DATE,
    IN p_time TIME,
    IN p_id VARCHAR(255)
)
BEGIN 
	DECLARE members VARCHAR(255) DEFAULT NULL;
    DECLARE facility_price DECIMAL(6,2) DEFAULT NULL;
    
    -- is the member part of the membership table
    SELECT member_id
    INTO members
    FROM membership
    WHERE member_id = p_id;
    
    -- To get the price of the facility
    SELECT price
    INTO facility_price
    FROM facilities
    WHERE facility_id = p_facility;
    
    -- Confirming if this is a member 
    IF members IS NOT NULL AND facility_price IS NOT NULL THEN
      -- Insert the new booking into the booking table
		INSERT INTO bookings (facility_id, booked_date, booked_time, member_id)
			VALUES (p_facility, p_date, p_time, p_id);
		
        -- Update the members new price 
		UPDATE membership
        SET payment_due = payment_due + facility_price
        WHERE member_id = p_id;
        
        -- Output
        SELECT "Booking Successfully Made" AS Output;
        
	ELSEIF facility_price IS NULL THEN
		SELECT "Wrong Facility ID Input" AS Output;
	ELSEIF members IS NULL THEN
		SELECT "Not a registered member" AS Output;
	ELSE 
		SELECT "Unsuccessful booking" AS Output;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_facilitator_email` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_facilitator_email`(
	IN m_id VARCHAR(255),
    IN m_email VARCHAR(255)
    )
BEGIN
	DECLARE old_email VARCHAR(255) DEFAULT NULL;
    -- Storing the value of the old email
    SELECT email
    INTO old_email
    FROM facilitator
    WHERE facilitator_id = m_id;
    
    -- To make the update
	UPDATE facilitator
	SET email = m_email
	WHERE facilitator_id = m_id;
    -- COMMIT;

	-- To create a condition to be sure the update is successful
	IF old_email IS NOT NULL AND old_email = m_email THEN
		SELECT "Unsuccessful Email Update" AS Output;
	ELSE 
		SELECT "Successful Email Update" AS Output;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_member_email` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_member_email`(
	IN m_id VARCHAR(255),
    IN m_email VARCHAR(255)
    )
BEGIN
	DECLARE old_email VARCHAR(255) DEFAULT NULL;
    -- Storing the value of the old email
    SELECT email
    INTO old_email
    FROM membership
    WHERE member_id = m_id;
    
    -- To make the update
	UPDATE membership
	SET email = m_email
	WHERE member_id = m_id;
    -- COMMIT;

	-- To create a condition to be sure the update is successful
	IF old_email IS NOT NULL AND old_email = m_email THEN
		SELECT "Unsuccessful Email Update" AS Output;
	ELSE 
		SELECT "Successful Email Update" AS Output;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_member_password` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_member_password`(
	IN m_id VARCHAR(255),
    IN old_password VARCHAR(255),
    IN new_password VARCHAR(255)
    )
BEGIN
	DECLARE current_password VARCHAR(255);
    DECLARE output_message VARCHAR(255);
    
    -- In case of an error
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
		SET output_message := 'Wrong Password, Please provide the correct Password';
	
    -- To store the current password in the variable
    SELECT password 
    INTO current_password
    FROM membership
    WHERE member_id = m_id;
    
    -- To create a condition to update the password if the old password is correct
    IF current_password IS NOT NULL AND old_password = current_password THEN 
		UPDATE membership
		SET password = new_password
		WHERE member_id = m_id;
        -- COMMIT;
        
        -- FOR THE OUTPUT
        SET output_message := "Password Updated Successfuly";
	ELSE 
		SET output_message :=  "Wrong Password, Please provide the correct Password";
	END IF
    ;
    
    -- FOR THE OUTPUT
    SELECT output_message AS Ouput;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `view_bookings` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `view_bookings`(
	IN p_id VARCHAR(255)
    )
BEGIN
	-- Declaring a variable for member_id
	DECLARE v_id VARCHAR(255) DEFAULT NULL;
    
    -- Store the memberId in the variable
    SELECT member_id
    INTO v_id
    FROM membership
    WHERE member_id = p_id;
    
    -- A condition to return the booking if the member ID is valid
    IF v_id IS NULL THEN
		SELECT "Not a member of the sport complex" AS Output;
	ELSE
		SELECT * 
        FROM bookings
        WHERE member_id = p_id;
	END IF;
	    
END ;;
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
