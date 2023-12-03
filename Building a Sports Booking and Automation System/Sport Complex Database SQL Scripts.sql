-- SQL PROJECT: DATABASE DESIGN FOR AN IMAGINABLE SPORTS COMPLEX

/* 
PROJECT OVERVIEW
-----------------

This project requires us to build a simple database to help us manage the
booking process of a sports complex. The sports complex has the following
facilities: 2 tennis courts, 2 badminton courts, 2 multi-purpose fields and 1
archery range. Each facility can be booked for a duration of one hour.
Only registered users are allowed to make a booking. After booking, the
complex allows users to cancel their bookings latest by the day prior to the
booked date. Cancellation is free.

INSTRUCTIONS
----------------

The Database should contain the following tables
1) Membership
2) Pending Terminations
3) Facilities
4) Bookings
5) Facilitator
6) Payments

TIME TO DESIGN THE DATABASE
*/ 

----------------------------------------------------------------------------------------------
-- DATABASE CREATION

-- DROP DATABASE IF EXISTS
DROP DATABASE IF EXISTS Sports_DB;

-- CREATE A DATABASE FOR SPORT COMPLEX
CREATE DATABASE Sports_DB 
DEFAULT CHARACTER SET utf8mb4;


-- TO BE SURE THE DATABASE WAS CREATED 
SHOW DATABASES;


-------------------------------------------------------------------------------------------------

-- TABLE CREATION
/* 
From the instruction given, there would be six tables in the database. 
The details of the tables ara given below
1) Membership: The Membership tables contains details about the members registered in the sport complex. 
		       It contains information such as the unique ID of the members, their password, email and other columns. 
2) Pending Termination: The pending terminations table contains Records from the members table will be transferred 
			   here under certain circumstances.
3) Facilities: This table contains information regarding the facilties at the sport complex. Such facilities include
               tennis courts, badminton courts etc.
4) Bookings: This table contains information on the booking for the members. It helps track details on each members bookings
5) Facilitator: This table contains information on the facilitators in charge of organizing and maintaining the facilities
6) Payments: This table contains all payments from members or ex-members who have pending payments. This table stores all 
			 transactions.

The next step is to create the table for the sport complex database
*/

-- TO MAKE IT THE ACTIVE DATABASE
USE Sports_DB;

-- TO CREATE THE MEMBERSHIP TABLE

DROP TABLE IF EXISTS membership;

CREATE TABLE membership (
	member_id VARCHAR(255),
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    member_since DATETIME NOT NULL DEFAULT NOW(),
    payment_due DECIMAL(5,2) NOT NULL DEFAULT 0,
    PRIMARY KEY (member_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    
-- TO CREATE THE PENDING TERMINATION TABLE

DROP TABLE IF EXISTS pending_terminations;

CREATE TABLE pending_terminations (
	member_id VARCHAR(255), 
    email VARCHAR(255) NOT NULL, 
    request_date DATETIME NOT NULL DEFAULT NOW(),
    payment_due DECIMAL(6,2) NOT NULL DEFAULT 0
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    
-- TO CREATE THE TABLE FOR FACILITIES

DROP TABLE IF EXISTS Facilities;

CREATE TABLE Facilities (
	facility_id VARCHAR(255),
    facility_type VARCHAR(255) NOT NULL,
    price DECIMAL(6,2) NOT NULL,
    facilitator_id VARCHAR(255),
    PRIMARY KEY (facility_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    
    
-- TO CREATE THE TABLE FOR FACILITATORS 

DROP TABLE IF EXISTS Facilitators;

CREATE TABLE Facilitator (
	facilitator_id VARCHAR(255),
    full_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(255) NOT NULL,
    email VARCHAR(255), 
    PRIMARY KEY (facilitator_id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- TO CREATE THE TABLE FOR BOOKINGS

DROP TABLE IF EXISTS bookings;

CREATE TABLE bookings (
	booking_id INT UNSIGNED AUTO_INCREMENT UNIQUE,
    facility_id VARCHAR(255) NOT NULL,
    booked_date DATE NOT NULL,
    booked_time TIME NOT NULL,
    member_id VARCHAR(255),
    datetime_of_booking DATETIME NOT NULL DEFAULT NOW(),
    payment_status VARCHAR(255) NOT NULL DEFAULT "Unpaid",
    PRIMARY KEY (booking_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    
    
-- TO CREATE THE TABLE FOR BOOKINGS

-- DROP TABLE IF EXISTS
DROP TABLE IF EXISTS payments;

-- TO CREATE THE TABLE
CREATE TABLE payments (
	payment_id INT AUTO_INCREMENT,
    Amount DECIMAL(6,2) NOT NULL,
    Datetime_of_payment DATETIME DEFAULT NOW(),
    member_id VARCHAR(255),
    PRIMARY KEY (payment_id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    
-- TO VERIFY IF ALL THE TABLES WERE CREATED 
SELECT * 
FROM information_schema.columns
WHERE TABLE_SCHEMA = "sports_db";



-- ALTERING TABLE CONSTRAINTS


-- BOOKINGS TABLE FOREIGN KEY: member_id
/*
For the `member_id` column in the foreign key, the rule to create this foreign key is given below

RULE APPLIED
 When the record in the memberships table is updated or deleted, the record in the booking table will also be updated or
deleted accordingly. This rule should be applied in creating the foreign key in the bookings table.

*/

-- Altering the bookings table to add foreign key
ALTER TABLE bookings 
  ADD CONSTRAINT member_fk 
  FOREIGN KEY (member_id) 
  REFERENCES membership(member_id) 
  ON DELETE CASCADE
  ON UPDATE CASCADE;
  
  
-- BOOKINGS TABLE FOREIGN KEY: facility_id

/* 
  RULE APPLIED
  
  When the record in the facilities table is updated or deleted, the record in the bookings table will also be 
  updated or deleted accordingly. This rule should be applied in creating the foreign key in the bookings table.
  
*/

-- Altering the bookings table to add foreign key
ALTER TABLE bookings 
  ADD CONSTRAINT facility_fk 
  FOREIGN KEY (facility_id) 
  REFERENCES facilities(facility_id) 
  ON DELETE CASCADE
  ON UPDATE CASCADE;
  

-- FACILITIES TABLE FOREIGN KEY: FACILITATOR_ID

/*
RULE APPLIED

When the record in the facilitor table is deleted, the record in the facilities table will also be 
replaced with null and when the records from the Facilitator table is updated, the records in the Facilities table 
should be updated. This rule should be applied in creating the foreign key in the bookings table.

*/

-- Altering the facilities table to add foreign key
ALTER TABLE facilities 
  ADD CONSTRAINT facilitator_fk 
  FOREIGN KEY (facilitator_id) 
  REFERENCES facilitator(facilitator_id) 
  ON DELETE SET NULL
  ON UPDATE CASCADE;
  
  
  
-- BOOKINGS TABLE UNIQUE CONTRAINT

/* 
RULES APPLIED

For the Bookings table, Members should not be book the same facility at the same time(Hour) on the same day. This means that the 
facility_id, booked_day and book_time should be unique.

*/

-- Altering the bookings table to add Unique key

ALTER TABLE bookings
ADD UNIQUE INDEX `unique_booking` (facility_id, booked_date, booked_time);


-- To check if the tables were created and constraints are properly placed
DESCRIBE bookings;
DESCRIBE facilities;
DESCRIBE facilitator;
DESCRIBE memberships;
DESCRIBE pending_terminations;
DESCRIBE payments;
  

----------------------------------------------------------------------------------------------------

-- INSERTING DATA INTO THE TABLES
 /* 
 The tables are ready and the next step is to import values into the table with the data for 
 the sport complex. 
 */
 
 -- INSERTING DATA INTO THE MEMBERSHIP TABLE 
 INSERT INTO membership (member_id, password, email, member_since, payment_due) 
 VALUES 
	('afeil', 'feil1988<3', 'Abdul.Feil@hotmail.com', '2017-04-15 12:10:13', 0),
	('amely_18', 'loseweightin18', 'Amely.Bauch91@yahoo.com', '2018-02-06 16:48:43', 0),
	('bbahringer', 'iambeau17', 'Beaulah_Bahringer@yahoo.com', '2017-12-28 05:36:50', 0),
	('little31', 'whocares31', 'Anthony_Little31@gmail.com', '2017-06-01 21:12:11', 10),
	('macejkovic73', 'jadajeda12', 'Jada.Macejkovic73@gmail.com', '2017-05-30 17:30:22', 0),
	('marvin1', 'if0909mar', 'Marvin_Schulist@gmail.com', '2017-09-09 02:30:49', 10),
	('nitzsche77', 'bret77@#', 'Bret_Nitzsche77@gmail.com', '2018-01-09 17:36:49', 0),
	('noah51', '18Oct1976#51', 'Noah51@gmail.com', '2017-12-16 22:59:46', 0),
	('oreillys', 'reallycool#1', 'Martine_OReilly@yahoo.com', '2017-10-12 05:39:20', 0),
	('wyattgreat', 'wyatt111', 'Wyatt_Wisozk2@gmail.com', '2017-07-18 16:28:35', 0);


 -- INSERTING DATA INTO THE FACILITIES TABLE 
INSERT INTO facilities (facility_id, facility_type, price, facilitator_id) 
VALUES 
	('AR', 'Archery Range', 120, 'F1'),
	('B1', 'Badminton Court', 8, 'F5'), 
	('B2', 'Badminton Court', 8, 'F3'), 
	('MPF1', 'Multi Purpose Field', 50, 'F2'), 
	('MPF2', 'Multi Purpose Field', 60, 'F7'), 
	('T1', 'Tennis Court', 10, 'F6'), 
	('T2', 'Tennis Court', 10, 'F4');


 -- INSERTING DATA INTO THE BOOKINGS TABLE 
INSERT INTO bookings (booking_id, facility_id, booked_date, booked_time, member_id, datetime_of_booking, payment_status) 
VALUES
	(1, 'AR', '2017-12-26', '13:00:00', 'oreillys', '2017-12-20 20:31:27', 'Paid'),
	(2, 'MPF1', '2017-12-30', '17:00:00', 'noah51', '2017-12-22 05:22:10', 'Paid'),
	(3, 'T2', '2017-12-31', '16:00:00', 'macejkovic73', '2017-12-28 18:14:23', 'Paid'),
	(4, 'T1', '2018-03-05', '08:00:00', 'little31', '2018-02-22 20:19:17', 'Unpaid'),
	(5, 'MPF2', '2018-03-02', '11:00:00', 'marvin1', '2018-03-01 16:13:45', 'Paid'),
	(6, 'B1', '2018-03-28', '16:00:00', 'marvin1', '2018-03-23 22:46:36', 'Paid'),
	(7, 'B1', '2018-04-15', '14:00:00', 'macejkovic73', '2018-04-12 22:23:20', 'Cancelled'),
	(8, 'T2', '2018-04-23', '13:00:00', 'macejkovic73', '2018-04-19 10:49:00', 'Cancelled'),
	(9, 'T1', '2018-05-25', '10:00:00', 'marvin1', '2018-05-21 11:20:46', 'Unpaid'),
	(10, 'B2', '2018-06-12', '15:00:00', 'bbahringer', '2018-05-30 14:40:23', 'Paid');
 
  
  
 -- INSERTING DATA INTO THE FACILITATOR TABLE 
INSERT INTO Facilitator (facilitator_id, full_name, phone_number, email)
VALUES
	('F1', 'John Doe', '1234567890', 'john.doe@example.com'),
	('F2', 'Jane Smith', '9876543210', 'jane.smith@example.com'),
	('F3', 'Alice Johnson', '5551112233', 'alice.johnson@example.com'),
	('F4', 'Bob Williams', '9998887777', 'bob.williams@example.com'),
	('F5', 'Eve Davis', '4445556666', 'eve.davis@example.com'),
	('F6', 'Charlie Brown', '1231231234', 'charlie.brown@example.com'),
	('F7', 'Lucy Taylor', '9876543210', 'lucy.taylor@example.com');
    
    
-- TO BE SURE THE DATA WAS SUCCESSFULLY INSERTED INTO THE TABLES
SELECT * FROM facilitator;
SELECT * FROM bookings;
SELECT * FROM membership;
SELECT * FROM facilities;


-- ENCRYPTING THE PASSWORD COLUMN
/* 
The password is a very sensitive information and it has to be protected so that anyone who has access to the table
will not have access to their password. I would be hashing the column for safety and security purposes.

Some of the hashing functions are 
- MD5
- SHA1
- SHA2
- password
*/

UPDATE membership
SET password = MD5(password);

-- To check if it worked
SELECT * FROM membership;

--------------------------------------------------------------------------------

-- CREATING VIEWS

/*
Now that the tables hav been created and data has been inserted into the tables, we are ready to
select data from our tables.

The sports facility manager wants to be able to view all the booking details of a booking. 

To executte this task, I would be creating a view which the manager can use to always get the booking details
*/

DROP VIEW IF EXISTS booking_vw;

CREATE VIEW booking_vw AS
SELECT 
	booking_id, 
    facility_id,
    facility_type,
    booked_date,
    booked_time, 
    member_id,
    datetime_of_booking,
    payment_status
FROM bookings b
JOIN facilities f
USING (facility_id)
ORDER BY b.booking_id;

-- To view all the booking details, they are in the booking_vw which makes it easy for the Sport Facility Manager
-- To test if the view works

SELECT * FROM 
booking_vw;

/* 
A view would be also be created to show all the bookings available for the current week. This could help the Sports Facility
Manager and the facilitators know the current week's bookings and schedule so that they can plan ahead
*/

DROP VIEW IF EXISTS bookings_this_week;

CREATE VIEW bookings_this_week AS
SELECT 
	booking_id, 
    facility_id,
    facility_type,
    booked_date,
    DAYNAME(booked_date) DAY_OF_WEEK,
    booked_time, 
    member_id,
    datetime_of_booking,
    payment_status
FROM bookings b
JOIN facilities f
USING (facility_id)
WHERE WEEK(booked_date) = WEEK(NOW()) 
ORDER BY b.booking_id, b.booked_date;


-- To test if the view works

SELECT * FROM 
bookings_this_week;

-------------------------------------------------------------------------------------

-- CREATING STORED PROCEDURES

-- STORED PROCEDURE 1: Stored Procedure to insert new members

/*
The first procedure would be used to insert new members to the membership table. To achieve this, this would be done
using a stored procedure that takes the new members detail and adds it to the membership table
*/

DROP PROCEDURE IF EXISTS insert_new_member;

-- To create the procedure
DELIMITER $$
CREATE PROCEDURE insert_new_member (
	IN p_id VARCHAR(255), 
    IN p_password VARCHAR(255), 
    IN p_email VARCHAR(255)
    )
BEGIN
	INSERT INTO membership (member_id, password, email)
    VALUES
		(p_id, MD5(p_password), p_email);
END $$
DELIMITER ;


-- STORED PROCEDURE 2: Stored Procedure to delete existing members

/*
This procedure would be used to delete records from the membership table. The procedure would be supplied the ID of the member
which would be deleted from the membership table
*/

-- To create the procedure

DELIMITER $$
 CREATE PROCEDURE delete_member (
	IN selected_member VARCHAR(255)
    )
BEGIN
	DELETE FROM membership
    WHERE member_id = selected_member;
END $$
DELIMITER ;


-- To test the first two procedures

-- The new member `papito` would be used to test the procedures, first step is to confirm that papito isnt among the members
SELECT * FROM membership;

-- Then insert papito using the procedure
CALL insert_new_member ('papito', 'papito_2', 'papito@gmail.com');

-- Check if the new member was inserted
SELECT * FROM membership;

-- To drop the new member and test the delete member procedures
CALL delete_member ('papito');

-- To check if it worked
SELECT * FROM membership;


-- STORED PROCEDURE 3: Stored Procedure to update data in the membership and Facilitators table

/*
The next procedure would be used to update the password and email of the users on the membership and the 
facilitator details on the facilitators table. The procedure would need the member_id of the member and the
facilitator ID of the facilitator then use that to update their details.
*/

DROP PROCEDURE IF EXISTS update_member_email; -- IF EXISTS

-- To create the procedure to update member email
DELIMITER //
CREATE PROCEDURE update_member_email (
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
END //
DELIMITER ;


-- To create the procedure to update member password
/* 
For the password since it is a delicate information, the member would have to specify the previous password
and if the previous password is correct then the new password will be accepted, else it wont be accepted
*/
DROP PROCEDURE IF EXISTS update_member_password; -- if exists

DELIMITER //
CREATE PROCEDURE update_member_password (
	IN m_id VARCHAR(255),
    IN old_password VARCHAR(255),
    IN new_password VARCHAR(255)
    )
BEGIN
	DECLARE current_password VARCHAR(255);
    DECLARE hashed_password VARCHAR(255);
    DECLARE output_message VARCHAR(255);
    
     -- In case of an error
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
		SET output_message := 'Wrong Password, Please provide the correct Password';
    
    -- To hash the password input
    SET hashed_password := MD5(old_password);   
	
    -- To store the current password in the variable
    SELECT password 
    INTO current_password
    FROM membership
    WHERE member_id = m_id;
    
    -- To create a condition to update the password if the old password is correct
    IF current_password IS NOT NULL AND hashed_password = current_password THEN 
		UPDATE membership
		SET password = MD5(new_password)
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
END //
DELIMITER ;


-- Procedure to update the Facilitator email

DROP PROCEDURE IF EXISTS update_facilitator_email;

DELIMITER //
CREATE PROCEDURE update_facilitator_email (
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
END //
DELIMITER ;

-- To test if the procedures are working properly

-- First is to put off the autocommit feature
SET @@autocommit = FALSE;

SELECT @@autocommit; -- to check if it turned off

-- Lets pick a member to use as test case 
SELECT * FROM membership;

-- The chosen member has member_id `little31`. The password for this member is `whocares31` and the 
-- email is `Anthony_Little31@gmail.com`.alter

-- To change the email to Little_Anthony31@gmail.com
CALL update_member_email('little31', 'Little_Anthony31@gmail.com');

-- To change the password for little31, new password is whocares
CALL update_member_password('little31', 'whocares3', 'whocares'); -- Testing with a wrong password
CALL update_member_password('little31', 'whocares31', 'whocares'); -- Testing with a correct password

-- To check if the changes have been made
SELECT * FROM membership
WHERE member_id = 'little31';

-- To test if the facilitator procedure is working, we will try to change the facilitator email
CALL update_facilitator_email ('F3', 'alic.johnson@example.com');

-- Since autocommit is off, the changes made are temporary, so I can rollback
ROLLBACK;

-- Check again, the changes have been reverted
SELECT * FROM membership
WHERE member_id = 'little31';


-- STORED PROCEDURE 4: Stored Procedure to make a booking
/*
The next procedure would be used to make a booking. To insert a booking, four input parameters are needed
which are the facility_id, booked_date, booked_time and member_id. The remaining columns in the booking table
have a default value. Each Facility_id has a price, Once a booking is made by a member, the price would be updated 
in the payment_due of that particular member
*/
DROP PROCEDURE IF EXISTS make_booking;

DELIMITER $$
CREATE PROCEDURE make_booking (
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
END $$
DELIMITER ;

-- To test if the procedure works, we would make a booking for little31
CALL make_booking ( 'AR', DATE(NOW()), TIME(NOW()), 'little3'); -- for a wrong member ID
CALL make_booking ( 'ARw', DATE(NOW()), TIME(NOW()), 'little31'); -- For a wrong facility
CALL make_booking ( 'AR', DATE(NOW()), TIME(NOW()), 'little31'); -- successful booking made

-- Check the bookings table for the new booking, check the members table for the payment addition
SELECT * FROM bookings;
SELECT * FROM membership;


-- STORED PROCEDURE 5: Stored Procedure to show all bookings for a member

/* 
This procedure would be used to show all the bookings that a particular member has with made currently and 
in the past. The procedure would take in the member id and return all bookings for the member
*/

DROP PROCEDURE IF EXISTS view_bookings;

DELIMITER //
CREATE PROCEDURE view_bookings (
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
	    
END //
DELIMITER ;


-- To test if it works
CALL view_bookings ('little3'); -- Invalid member
CALL view_bookings ('little31'); -- Valid member


-- STORED PROCEDURE 6: Stored Procedure to show all available bookings for each day, time and facility

/*
The procedure will be used to show all available bookings for each day, time and facility. The procedure requires
one compulsory input parameters and two optional parameters. The compulsory parameter is the date of booking and it would return all 
the available slots for that day at all time the sports complex will be open (8am - 5pm). If you want to check if a particular time
and/or facility is booked, you can also indicate the time and facility ID and it would give you a result
*/

DROP PROCEDURE IF EXISTS available_bookings; 

DELIMITER //
CREATE PROCEDURE available_bookings (
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
END //

DELIMITER ;


-- TEST
/*
To test this procedure, I would be using '2018-03-05' for my date variable, 8 for my time variable, T1 for my sports facility 
varible. I would test these variables to see if the procedure works properly
*/

-- Testing for all null values
CALL available_bookings (
	NULL, -- Input your date yyyy-mm-dd
    NULL, -- Input your time from 8 to 17 (8am - 5pm)
    NULL -- Input your facility choice
    );
-- testing for only date
CALL available_bookings ('2018-03-05', NULL, NULL);

-- testing for date and time not between 8 and 17
CALL available_bookings ('2018-03-05', 19, NULL);

-- testing for date and time between 8 and 17
CALL available_bookings ('2018-03-05', 17, NULL);

-- testing for date, time and invalid facilty
CALL available_bookings ('2018-03-05', 17, 'AM');

-- testing for date, time and facilty
CALL available_bookings ('2018-03-05', 17, 'AR');
CALL available_bookings ('2018-03-05', 8, 'T1');

-- testing for date, no selected time and facility
CALL available_bookings ('2018-03-05', NULL, 'T1');


-- STORED PROCEDURE 7: Stored Procedure to cancel bookings

/*
This procedure would be used to cancel the bookings made on the bookings table. The conditions for cancelling the bookings 
are that the booking cannot be cancelled on the day of the booking. It can only be cancelled a day before the booking
date. No refund is allowed. Once a booking is already paid, it cannot be cancelled. Once a booking is cancelled, the price of the facility
would be deducted from the payment due for the member 
*/

DROP PROCEDURE IF EXISTS cancel_bookings;

DELIMITER //
CREATE PROCEDURE cancel_bookings (
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
    
END //
DELIMITER ;

-- To test if the procedure is working 
CALL cancel_bookings(4);

-- To cechk if the changes has been made
select * from bookings
WHERE booking_id = 4;

-- To undo what has been done
ROLLBACK;

---------------------------------------------------------------------------------------------------------------

-- SETTING UP TRIGGERS

-- TRIGGER 1: iNITIATE A TRIGGER FOR PENDING TERMINATIONS

/* 
In a case where a member wants to cancel their membership but they still have payment due to be paid, the member would be added
to the pending termination table till their payment is completed. This would be done using a trigger. 
*/

-- SETTING UP THE TRIGGER

-- Drop if exists
DROP TRIGGER IF EXISTS payment_check;

-- CREATING THE TRIGGER
DELIMITER //
CREATE TRIGGER payment_check 
BEFORE DELETE on sports_db.membership
FOR EACH ROW 
BEGIN
	IF old.payment_due > 0 THEN 
		INSERT INTO pending_terminations (member_id, email, payment_due)
        VALUES (old.member_id, old.email, old.payment_due);
	END IF;
END //
DELIMITER ;

-- To test if it works
DELETE FROM membership
WHERE member_id = 'little31';

DELETE FROM membership
WHERE member_id = 'afeil';

-- To reverse it all
ROLLBACK;


-- TRIGGER 2: UPDATE PAYMENT DUE FOR A MEMBER AFTER MAKING PAYMENTS

/*
When a memebr makes a payment, the money should be automatically updated in the payment due for the member. If the payment due for 
member A is $100 and member A pays $30 then he should have $70 left to pay. Once a member's payment due gets to zero then all payment 
status be updated to Paid. A member's payment due cannot go below zero.
*/

-- SETTING UP TRIGGER

-- DROP TRIGGER IF EXISTS
DROP TRIGGER IF EXISTS payment_update;

-- CREATE THE TRIGGER
DELIMITER //
CREATE TRIGGER payment_update
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
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
END //
DELIMITER ;

-- To test if the trigger is working

-- To confirm that the autocommit is off
SELECT @@autocommit;

-- To test with the following operations
DELETE FROM membership
WHERE member_id = 'little31'; -- This member would be moved to pending terminations
-- To insert the following payments
INSERT INTO payments (amount, member_id)
VALUES (30, 'little3');
INSERT INTO payments (amount, member_id)
VALUES (30, 'little31');
INSERT INTO payments (amount, member_id)
VALUES (100, 'little31');
INSERT INTO payments (amount, member_id)
VALUES (30, 'little31');
INSERT INTO payments (amount, member_id)
VALUES (10, 'marvin1');

-- to check if it works
SELECT * FROM MEMBERSHIP;
SELECT * FROM pending_terminations;
SELECT * FROM PAYMENTS;
select * from bookings;

-- SETTING UP INDEXES FOR QUERY OPTIMIZATION
/*
To improve query performance, Indexes will be set up so as to improve the performance of database when querying 
the database. 

Columns chosen to be indexed in the database are 
- Facilities [facility_type]
- Bookings [booked_date]
- Bookings [booked_time]
- Facilitator [full_name]
- membership [email]
- Payment [member_id]
- Pending_transaction [member_id]

Note that the choice of which columns to index should be based on a thorough understanding of your database and columns used 
for JOIN and WHERE operations in your analysis. The choice of columns to index is indeed flexible and can evolve over time 
based on the usage patterns of your database.
*/

-- To create an index on the above listed columns
CREATE INDEX facility_type_idx ON Facilities (Facility_id);
CREATE INDEX booking_period_idx ON bookings (booked_date, booked_time);
CREATE INDEX facilitator_name_idx ON Facilitator (full_name);
CREATE INDEX email_idx ON membership (email);
CREATE INDEX payment_member_idx ON Payments (member_id);
CREATE INDEX pending_member_idx ON Pending_terminations (member_id);

-- To show all indexex in the database
SELECT DISTINCT TABLE_NAME,
	 INDEX_NAME
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'sports_db';



----------------------------------------------------------------------------------------------------------

-- USER MANAGEMENT AND PRIVILEGES
/* 
The next step is to create users, manage them and grant privileges to the users. User management is important because they play a 
vital role in ensuring the security, integrity, and efficiency of a database system. They enforce access control, limiting database 
interactions to authorized individuals and preventing unauthorized access.

The following users and access would be given
- Admin: The user should be able to perform all actions on the datadase from creating, querying, changing and deleting instructors, 
		 members, bookings, facilities etc.
- Facilitator: The facilitator should be able to check and query the facilitator and facilities tables and should be able to 
	     update their personal details on the facilitator table. They should also be able to view bookings details and 
         bookings for the week
- Member: Members should be able to check and update their details on the membership table. Members should be able to view available 
	     bookings, should be able to make bookings and can view their own weekly bookings.
	 
*/

-- TO create the users 

-- For admin
CREATE USER IF NOT EXISTS "sports_admin"@'localhost'
IDENTIFIED BY "sports_admin";

-- For Facilitator
CREATE USER IF NOT EXISTS "sports_facilitator"@'localhost'
IDENTIFIED BY "facilitator";

-- For Member
CREATE USER IF NOT EXISTS "sports_member"@'localhost'
IDENTIFIED BY "Member";


-- GRANTING USER ACCESS AND PRIVILEGES

-- For Admin
GRANT ALL PRIVILEGES 
ON sports_db.*
TO "sports_admin"@'localhost';

-- For Facilitator
GRANT SELECT ON sports_db.facilitator -- to be able to query the facilitator table
TO "sports_facilitator"@'localhost';

GRANT SELECT ON sports_db.facilities -- to be able to query the facilities table
TO "sports_facilitator"@'localhost';

GRANT EXECUTE ON PROCEDURE sports_db.update_facilitator_email -- to be able to update records
TO "sports_facilitator"@'localhost';

-- To grant privilege to view bookings this week and booking details
GRANT SELECT ON sports_db.booking_vw TO "sports_facilitator"@'localhost';
GRANT SELECT ON sports_db.bookings_this_week TO "sports_facilitator"@'localhost';


-- For members
GRANT SELECT ON sports_db.membership -- to be able to query the membership table
TO "sports_member"@'localhost';

GRANT EXECUTE ON PROCEDURE sports_db.update_member_email -- to be able to update member email
TO "sports_member"@'localhost';

GRANT EXECUTE ON PROCEDURE sports_db.update_member_password -- to be able to update member password
TO "sports_member"@'localhost';

GRANT EXECUTE ON PROCEDURE sports_db.available_bookings -- to be able to view available bookings
TO "sports_member"@'localhost';

GRANT EXECUTE ON PROCEDURE sports_db.make_booking -- to be able to make bookings
TO "sports_member"@'localhost';

GRANT EXECUTE ON PROCEDURE sports_db.cancel_bookings -- to be able to cancel bookings
TO "sports_member"@'localhost';

GRANT EXECUTE ON PROCEDURE sports_db.view_bookings -- to be able to view personal bookings
TO "sports_member"@'localhost';

-- To be sure the privileges are accurately given
SHOW GRANTS FOR "sports_admin"@'localhost';
SHOW GRANTS FOR "sports_facilitator"@'localhost';
SHOW GRANTS FOR "sports_member"@'localhost';

/* NOTE BELOW
In the result of the previous query, this Privilege "GRANT USAGE ON *.* TO `sports_member`@`localhost`" was present for 
all users and it means that the privilege allows the user to connect to the MySQL server from the host localhost, 
but it doesn't grant any specific privileges within any databases or tables. This is often a starting point when 
creating a user.
*/

-- DATABASE BACKUP AND RECOVERY

/*
Database backups are crucial for data recovery and continuity, providing a safeguard against data loss due to accidental
deletion, corruption, or system failures, ensuring the ability to restore databases to a previous state and minimizing 
downtime in the event of unexpected incidents.

The database for the sports complex has been exported using mysqldump, database backup method we can use to make sure
we can restore data if we lose it.
*/



  





