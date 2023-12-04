<h1 align= "center">A Sports Club Booking and Automation System</h1>
<p align="center"><em>A database design project</em></p>

---

<p align="center">
<img src="https://github.com/Ebuka456/Sport-Club-Booking-System/blob/main/Building%20a%20Sports%20Booking%20and%20Automation%20System/pexels-photo-4058691.jpeg" alt="Alt text" style= "width: 900px; height: 450px"/>
</p>

A properly designed database is the foundation for efficient and effective data management. It is a critical asset for any organization that relies on data to drive its operations. 
This project is going into details how I designed a **Booking System Database** for a Sports complex and how I automate activities in the database.

## 🟢 Project Overview
---

The aim of this project is to develop a comprehensive database system to manage the booking process of a sports complex, including facilities such as tennis courts, badminton courts, multi-purpose fields, and an archery range. Additionally, automate booking processes, including payments, updating member records, and providing a seamless experience for registered users.

### Key Features
The booking system should contain the following key features:
- The sports complex has the following facilities: 2 tennis courts, 2 badminton courts, 2 multi-purpose fields and 1 archery range.
- Each facility can be booked for a duration of one hour.
- Only registered users are authorized to make bookings.
- Only members who have made full payments are allowed to terminate their membership
- No two members can book the same facility on the same date and time. 
- Users can cancel their bookings. Cancellations are allowed up to the day prior to the booked date.


## 🟢 Project Breakdown
After thoroughly reviewing the Project overview and understanding what needs to be done, I broke down the project into the following stages highlighted below
- [Database Setup and Creation](#Database-Setup-and-Creation)
- [Table Creation, Altering Table Constraints and Inserting Data](#Table-Creation-Altering-Table-Constraints-and-Inserting-Data)
- [Creating Views and Setting up EER Diagram](#Creating-Views-and-Setting-up-EER-Diagram)
- [Automate Database Activity](#Automate-Database-Activity)
- [Query Optimization](#Query-Optimization)
- [User Management and Privileges](#User-Management-and-Privileges)
- [Backup and Recovery](#Backup-and-Recovery)
- [Database Security](#Database-Security)

**NB**: This booking system will be built on MySQL Database


## 🟢 Database Setup and Creation

<p align="center">
<img src="https://github.com/Ebuka456/Sport-Club-Booking-System/blob/main/Building%20a%20Sports%20Booking%20and%20Automation%20System/mysql-database-setup.png" alt="Alt text" style= "width: 900px; height: 450px"/>
</p>

Before setting up a database, here are a list of steps I take 
- Determined the purpose of the database
- Gathered all of the types of information I wanted to record in the database, such as members and facilities, bookings etc.
- Divided the information items into major entities or subjects, such as Membership or Bookings. Each subject then becomes a table.
- Decided what information I wanted to store in each table. Each item becomes a field, and is displayed as a column in the table.
- Chose each table's primary key. The primary key is a column that is used to uniquely identify each row.
- Looked at each table and decided how the data in one table is related to the data in other tables. Added fields to tables or create new tables to clarify the relationships, as necessary.

After coming up with a blueprint for my Database System, I proceeded to Creating my Database.

``` sql
-- DROP DATABASE IF EXISTS
DROP DATABASE IF EXISTS Sports_DB;

-- CREATE A DATABASE FOR SPORT COMPLEX
CREATE DATABASE Sports_DB 
DEFAULT CHARACTER SET utf8mb4;
```

## 🟢 Table Creation, Altering Table Constraints and Inserting Data
After coming up with a blueprint for the database, the next step was to create the tables, add table constraints and establish a relationship between the tables. The tables to be included in the database are as follows

- `Membership` 
- `Pending_Terminations`
- `Facilities`
- `Bookings`
- `Facilitator`
- `Payments`

The script below contains the SQL scripts used to build the `membership` and `bookings` table only. The full scripts can be found in my [SQL file](https://github.com/Ebuka456/Sport-Club-Booking-System/blob/main/Building%20a%20Sports%20Booking%20and%20Automation%20System/Sport%20Complex%20Database%20SQL%20Scripts.sql).

``` sql
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
```

Following the creation of the tables, a series of crucial steps were meticulously executed on the database:

- **Data Insertion**: Populating the tables with relevant data to ensure comprehensive information storage.

- **Table Refinement**: The tables underwent meticulous alteration to incorporate Foreign Keys and Referential Constraints, fortifying the relational structure of the database.

- **Security Enhancement**: As a security measure, sensitive information within the membership table was subjected to encryption or hashing mechanisms, bolstering the safeguarding of confidential data.

- **Database Integrity Testing**: Rigorous testing procedures were employed to ascertain the successful implementation of all changes and to validate the database's integrity. This process was executed with precision to detect and rectify any potential errors.

The scripts to carry out these steps can be found [here](https://github.com/Ebuka456/Sport-Club-Booking-System/blob/main/Building%20a%20Sports%20Booking%20and%20Automation%20System/Sport%20Complex%20Database%20SQL%20Scripts.sql)


## 🟢 Creating View & ER Diagram

The next step taken was to create an Entity Relationship Diagram (ERD) as a strategic initiative to visually articulate the database's architecture. This diagram serves to delineate the composition of the database, encompassing its entities (tables), inter-entity relationships, and the distinctive attributes affiliated with each entity. 

The ER diagram, dedicated to the booking system, is presented below for reference and comprehensive understanding.

<p align="center">
<img src="https://github.com/Ebuka456/Sport-Club-Booking-System/blob/main/Building%20a%20Sports%20Booking%20and%20Automation%20System/EER%20Diagram%20Image.png" alt="Alt text" style= "width: 900px; height: 450px"/>
</p>

To understand the diagram even more, Read my article where I explained my working process. Check it out [Here]()

### Creating Views

Now that I have created the tables and inserted some data, next step was to create views.

Specifically, I created views that shows all the booking details of each booking and all booking details in the current week. This would give the management and admin an easy view to all the historical booking details and booking details in the current week so that proper preparations can be made

You can find the script [Here](https://github.com/Ebuka456/Sport-Club-Booking-System/blob/main/Building%20a%20Sports%20Booking%20and%20Automation%20System/Sport%20Complex%20Database%20SQL%20Scripts.sql).


## 🟢 Automating Database Activity

The goal of automating database activity is to streamline, optimize, and schedule routine or repetitive tasks, improving efficiency, accuracy, and overall management of the database environment.

To begin this, I initially studied all repetitive booking and payment activities that would be done on the database and automated them to save time and improve efficiency. These automations were done using Stored Procedures and Database Triggers in MySQL. Here are the list of activities I automated;

- inserting new members into the `membership` table
- Deleting members from the `membership` table
- Updating data in the members and Facilitators credentials on the `membership` and `facilitator` table. Credentials such as `name`, `email`, `password` etc.
- Making a booking and inserting it on the `bookings` table (you must be a confirmed member and you have to pick an facility at a time it is not booked)
- Checking for available slots before making a booking
- Canceling a booking based on the condition that you have not paid for the booking and the booking cannot be cancelled on the day of the booking
- Moving records with cancelled memberships to the `pending_terminations` table when they still owe the sports complex
- Updating `payment_status` and `payment_due` for members after payments have been made to the `payments` table

These are most of the automations I implemented on the database and the scripts used to create the automation can be found [here](https://github.com/Ebuka456/Sport-Club-Booking-System/blob/main/Building%20a%20Sports%20Booking%20and%20Automation%20System/Sport%20Complex%20Database%20SQL%20Scripts.sql).

## 🟢 Query Optimization

To improve query performance, Indexes will be set up so as to improve the performance of database when querying the database. 
The Query Optimization techniques used for the database was Indexes and below are the scripts used to create the indexes on selected columns

``` sql
-- To create an index on the listed columns
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

```

## 🟢 User Management & Privileges

User management is important because they play a vital role in ensuring the security, integrity, and efficiency of a database system. They enforce access control, limiting database interactions to authorized individuals and preventing unauthorized access.

For this database, I would be creating 3 users, the details are below
- **Admin**: The user should be able to perform all actions on the database from creating, querying, changing and deleting instructors, members, bookings, facilities etc.
- **Facilitator**: The facilitator should be able to check and query the facilitator and facilities tables and should be able to update their personal details on the facilitator table. They should also be able to view bookings details and bookings for the week
- **Member**: Members should be able to check and update their details on the membership table. Members should be able to view available  bookings, should be able to make bookings and can view their own weekly bookings.


## 🟢 Backup and Recovery

We use Backups to make sure our database is protected and recoverable in the event of loss. There are different types of backup but the backup I performed is a **Logical backup**.

In a logical backup, you are able to store the SQL statements needed to recreate the database and populate it. In MySQL, this is done using mysqldump. Another way of backing up your database is by Database Replication but this project does not cover data replication. The backed up file is also present in my GitHub Repository. So you can recreate the database on your local device.


## 🟢 Database Security

Securing a database for a sports complex is essential to protect sensitive information, ensure data integrity, and maintain the overall reliability of the system. 

There are several security threats that database are prone to. To understand more about the security threats that face database, check [here](https://medium.com/r/?url=https%3A%2F%2Fwww.tripwire.com%2Fstate-of-security%2Fmajor-database-security-threats-prevent). 

Here are some security best practices the team can adopt

- If changes are made in the database, try not to store sensitive information, and if you have to, encrypt it
- Ensure you limit access to the data. Very few employee will need access to the data and for the ones that have access, really consider who you are giving write/edit access to. Have an active plan for removing facilitators and member access when they resign or quit.
- Take Authentication seriously. Ensure that members are encouraged to use strong passwords rather than a weak one. Also ensure that they change their passwords regularly, at least once every 30 days.
- Consistently backup your database and make sure it is up-to-date just incase of a breach or malfunction. The data and database wont be lost.
- Educate database administrators, developers, and other personnel about security best practices. Regular training sessions help create a security-aware culture and reduce the likelihood of human errors. Database Security is everyone's priority.


Link to Medium Article and Scripts

