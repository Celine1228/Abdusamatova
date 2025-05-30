--easy level tasks
--1
select orders.orderid, customers.firstname+' '+customers.lastname as fullname, 
orders.OrderDate from orders join customers 
on orders.customerid=customers.customerid where orderdate>'2022-12-31'
--2
select employees.[name], departments.departmentname from employees
inner join departments on departments.departmentid=employees.departmentid
where departments.departmentname in ('Sales', 'Marketing')
--3
select departments.DepartmentName, max(employees.salary) as maxsalary from departments
inner join employees on departments.departmentid=employees.departmentid
group by DepartmentName
--4
select customers.FirstName+' '+customers.lastname as [name], orders.orderid,
orders.orderdate from customers join orders on customers.customerid=orders.customerid
where COUNTRY='USA' AND orders.OrderDate >= '2023-01-01'
AND orders.OrderDate < '2024-01-01'
--5
select customers.firstname+' '+customers.lastname as fullname, count(orderid) as totalorders
from customers join orders on customers.customerid=orders.customerid
group by customers.customerid, customers.firstname, customers.lastname
--6
select products.productname, suppliers.suppliername from products
join Suppliers on products.supplierid=suppliers.supplierid 
where suppliername in ('Gadget Supplies', 'Clothing Mart')
--7
select customers.firstname+' '+customers.lastname as fullname, 
max(orderdate) as mostrecentorderdate from customers left join orders
on orders.customerid=customers.customerid group by firstname, lastname
--Medium level tasks
--8
select customers.firstname, customers.lastname, orders.totalamount
from customers join orders on customers.customerid=orders.customerid
where orders.totalamount>500
--9
select products.productname, sales.saledate, sales.saleamount from products
join sales on products.productid=sales.productid
where (sales.saledate>='2022-01-01' and sales.saledate<'2023-01-01') or SaleAmount>400
--10
select products.productname, sum(saleamount) as totalsalesamount from products
join sales on products.productid=sales.productid group by ProductName
--11
select employees.[name], departments.departmentname, employees.Salary
from employees join Departments on Employees.DepartmentID=Departments.DepartmentID
where DepartmentName='Human Resources' AND Salary>60000
--12
select products.productname, sales.saledate, products.StockQuantity from products
join sales on products.productid=sales.productid 
where (sales.saledate>='2023-01-01' and sales.saledate<'2024-01-01')
and StockQuantity>100
--13
select Employees.[name], Departments.DepartmentName, Employees.HireDate from Employees
join Departments on Departments.DepartmentID=Employees.DepartmentID
where DepartmentName='Sales' or Hiredate>='2021-01-01'
--hard level tasks
--14
select customers.firstname, customers.lastname, orders.orderid, customers.address, orders.orderdate
from customers join orders on customers.customerid=orders.CustomerID
where country='USA' and address like'[0-9][0-9][0-9][0-9]%'
--15
select products.productname, products.category, sales.saleamount from products
join sales on products.productid=sales.productid where category='Electronics' or saleamount>350
--16
select count(products.Productname) as productcount, categories.categoryname from products
right join categories on products.Category=categories.categoryid
group by CategoryName
--17
select customers.FirstName+' '+customers.lastname as [name], orders.orderid,
orders.totalamount, customers.city from customers join orders on customers.customerid=orders.customerid
where City='Los Angeles' AND totalamount>300
--18
SELECT 
    Employees.[name] AS EmployeeName,
    Departments.DepartmentName FROM 
    Employees JOIN  Departments ON Employees.DepartmentID = Departments.DepartmentID
WHERE 
    Departments.DepartmentName IN ('HR', 'Finance')
    OR (
        LEN(Employees.[name]) 
        - LEN(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
          LOWER(Employees.[name]), 'a', ''), 'e', ''), 'i', ''), 'o', ''), 'u', ''))
        >= 4
    );
--19
SELECT 
    Employees.[name] AS EmployeeName,
    Departments.DepartmentName,
    Employees.salary FROM Employees
JOIN 
    Departments ON Employees.DepartmentID = Departments.DepartmentID
WHERE 
    Departments.DepartmentName IN ('Sales', 'Marketing')
    AND Employees.salary > 60000
