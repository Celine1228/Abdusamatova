/*Basic level tasks
Question 1*/
CREATE TABLE EMPLOYEES (EmpID INT, Name VARCHAR(50), Salary DECIMAL(10,2))
--Question 2(1)
INSERT INTO EMPLOYEES(EmpID, Name, Salary) VALUES('1', 'Bobby', 10000000)
INSERT INTO EMPLOYEES(EmpID, Name, Salary) VALUES('2', 'Sarah', 40000000)
INSERT INTO EMPLOYEES(EmpID, Name, Salary) VALUES('3', 'Salim', 30000000)
--Question 2(2)
INSERT INTO EMPLOYEES(EmpID, Name, Salary) VALUES('4', 'Mohir', 12000000), ('5', 'Zarina', 5000000), ('6', 'Guzal', 2800000); 
SELECT* FROM EMPLOYEES
--QUESTION 3
UPDATE EMPLOYEES SET Salary=7000 WHERE EmpID=1
--QUESTION 4 
DELETE FROM EMPLOYEES WHERE EmpID=2
SELECT* FROM EMPLOYEES
--QUESTION 5
/*
Drop-fastest way to remove entire structure+data
Truncate-faster than delete. Removes rows keeps the structure
Delete. Removes specfic rows using WHERE. Can be rolled back unlike TRUNCATE and DELETE
*/
--QUESTION 6
ALTER TABLE EMPLOYEES ALTER COLUMN Name VARCHAR(100)
--Question 7
ALTER TABLE EMPLOYEES ADD Department VARCHAR(50);
SELECT* FROM EMPLOYEES
--Question 8
ALTER TABLE EMPLOYEES ALTER COLUMN Salary FLOAT
--Question 9
CREATE TABLE Departments (DepartmentID INT PRIMARY KEY, DepartmentName VARCHAR(50));
--Quetion 10
DELETE FROM EMPLOYEES
SELECT* FROM EMPLOYEES

/*Intermediate-Level Tasks
Question 11*/
DELETE FROM Departments
ALTER TABLE Departments ADD SALARY VARCHAR(50)
INSERT INTO Departments
SELECT '1', 'MARKETING', 3000
UNION ALL
SELECT '2', 'FINANCE', 5920
UNION ALL
SELECT'3', 'LAW', 3000
UNION ALL
SELECT '4', 'ACCOUNTING', 6000
UNION ALL
SELECT '5', 'HR', 7000
SELECT * FROM Departments

--QUESTION 12
UPDATE Departments SET DepartmentName='MANAGEMENT' WHERE SALARY>5000
--QUESTION 13
DELETE FROM Departments
--Question 14
ALTER TABLE EMPLOYEES DROP COLUMN Department
SELECT* FROM EMPLOYEES
--QUESTION 15
EXEC sp_rename 'EMPLOYEES', 'StaffMembers';
--QUESTION 16
DROP TABLE Departments

/*Advanced Level Tasks
Question 17*/

CREATE TABLE PRODUCTS (ProductID INT Primary Key, ProductName VARCHAR (100), Category VARCHAR(50), Price DECIMAL (10,2), Column5 VARCHAR(100))
SELECT * FROM PRODUCTS
--QUESTION 18
ALTER TABLE PRODUCTS ADD CONSTRAINT chk_price_positive CHECK (PRICE>0)
--QUESTION 19
EXEC sp_rename 'PRODUCTS.Column5', 'StockQuantity', 'COLUMN';
ALTER TABLE PRODUCTS ADD CONSTRAINT df_StockQuantity DEFAULT 50 FOR StockQuantity;
--QUESTION 20
EXEC sp_rename 'PRODUCTS.Category', 'ProductCategory', 'COLUMN';
--QUESTION 21
INSERT INTO PRODUCTS (ProductID, ProductName, ProductCategory, Price)  VALUES ('1', 'shoes', 'footwear', 90000), ('2', 'hat', 'headwear', 15000), ('3', 'dress', 'clothes', 95000), ('4', 'shirt', 'clothes', 30000), ('5', 'trousers', 'clothes', 60000)
--QUESTION 22
SELECT * INTO [Products_Backup] FROM PRODUCTS
--QUESTION 23
EXEC sp_rename 'PRODUCTS', 'INVENTORY';
--QUESTION 24
ALTER TABLE INVENTORY DROP CONSTRAINT chk_price_positive;
ALTER TABLE INVENTORY ALTER COLUMN PRICE FLOAT
--QUESTION 25
ALTER TABLE INVENTORY ADD ProductCode INT IDENTITY (1000,5)
SELECT* FROM INVENTORY