--Question 1:
--Data can be anything that contains raw information from names to numbers. From analyzing data information can be taken.
--Database: Place where all datasets are kept so that it will be convenient to manage and work with it
--Relational database where data is stored in tables and they are connected with each other
--Table: Collection of data in coloumns and raws

--Question 2: Data storage in tables, security features, backup and restore, stored procedures and Integration with other apllications

--Question 3: Windows authentication, SQL server authentication

--Question 4:
CREATE DATABASE SchoolDB

--Question 5:
CREATE TABLE Students (StudentID INT PRIMARY KEY, Name VARCHAR(50), Age INT)
--Question 6 SQL SERVER: Place where data is run and controlled. SSMS: Dashboard that lets to work with SQL Server engine. SQL: The language to give instructions to Server via SSMS
--Question 7:Data Query Language(DQL) -SELECT. Helps to derive specific data from database
--DML (Data Manipulation Language)-INSERT, UPDATE, DELETE. Helps to modify data in the database
--DDL(Data Definition Language)-CREATE, ALTER, DROP, TRUNCATE. Helps to define/change structure of database objects
--DCL(Data control language)-GRANT REVOKE. Helps to control access to data
--TCL(Transaction control language)-COMMIT, ROLLBACK, SAVEPOINT. Helps to To manage transactions
--Question 8
INSERT INTO Students (StudentID, Name, Age)
VALUES 
(1, 'Muattar Ishmuxamedova',62 ),
(2, 'Rashod Ishmuxamedov', 65),
(3, 'Oybek Ismoilov', 19);


--QUESTION 9. AdventureWorksDW2022.bak file is restored. 1. Rightclicked Database 2. Selected restore database 3. Chose device 4. Added file

