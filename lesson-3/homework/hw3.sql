--QUESTION 1. Bulk insert is used to insert excel, text and other type of files from computer to SQL server and use.
--QUESTION 2. Examples of data file types that can be imported to SQL server. .CSV, .TXT, .XLC, .ZIP
--QUESTION 3
create table Products (ProductID INT PRIMARY KEY, ProductName VARCHAR(50), Price DECIMAL(10,2))
--QUESTION 4
insert into Products (ProductID, ProductName, Price) values (1, 'cheese', 10000), (2, 'coffee', 12000), (3, 'buns', 4000);
--Question 5. Null means the space given for value is empty or not filled with information. Not null is used when giving command to not leave data emppty so that it makes sure in given space there is always information given
--Question 6
alter table Products add unique (ProductName)
--Question 7 I love who l am becoming a lot or
/* -These type of commentings help query writer to be understood by other users, or highlight important information*/
--Question 8
Alter table Products add CategoryID int
--Question 9 
Create table Categories (CategoryID varchar(100) PRIMARY KEY, CategoryName varchar(50) unique)
--Question 10. Identity column helps to automatically numerate columns keeping them unique.Incrementation can also be applied
--Question 11.
select * from Products
BULK INSERT Products
FROM 'C:\Users\Robiya Abdusamadova\Downloads\New Text Document.txt'
WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n');
--Question 12
Alter table products
Add constraint FK_Products_Categories
FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID);
--Question 13
/*The main difference between a primary key vs unique key is that a primary key is a key that uniquely identifies each record in a table but cannot store NULL values. In contrast, a unique key prevents duplicate values in a column and can store NULL values*/
--question 14
alter table Products add constraint chk_price_positive check (price>0);
--question 15
alter table Products add Stock INT NOT NULL default 0
--Question 16
update Products
SET Price=0 where price IS NULL
--Question 17. The purpose of a foreign key in a relational database is to link two tables together, ensuring data integrity and consistency. A FOREIGN KEY is a field in one table, that refers to the PRIMARY KEY in another table.
--Question 18/19
create table customers
(ID INT IDENTITY(100, 10), Age int check (age>=18))
--Question 20
Create table orderdetails(orderid int, custid int, primary key(orderid, custid))
--Question 21 coalesce-Returns the first non-NULL value from a list of arguments. isnull Replaces NULL with a specified replacement value.
--question 22
create table employees (employeeid int primary key, email varchar(50) unique)
--question 23
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    PaymentDate DATE)

CREATE TABLE PaymentDetails (
    DetailID INT PRIMARY KEY,
    PaymentID INT,
    FOREIGN KEY (PaymentID)
        REFERENCES Payments(PaymentID)
        ON DELETE CASCADE
        ON UPDATE CASCADE)
