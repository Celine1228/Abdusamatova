
--easy level tasks 
--1
select employees.[name], employees.salary, departments.DepartmentName from employees
inner join departments on employees.DepartmentID=departments.DepartmentID
where salary>50000
--2
select customers.firstname, customers.lastname, orders.orderdate from customers
inner join orders on orders.customerid=customers.CustomerID
where YEAR(orders.orderdate)=2023
--3
select employees.[name], departments.DepartmentName from employees
full join departments on employees.DepartmentID=departments.departmentid
--4
select suppliers.suppliername, products.productname from products
right join suppliers on products.supplierid=suppliers.supplierid
--5
select orders.orderid, orders.orderdate, payments.paymentdate, payments.amount
from orders full join payments on orders.orderid=payments.orderid
--6
SELECT 
    Employees.Name AS EmployeeName,
    Managers.Name AS ManagerName
FROM 
    Employees AS Employees
LEFT JOIN 
    Employees AS Managers ON Employees.ManagerID = Managers.EmployeeID;

--7
select students.[name], courses.coursename from students inner join
Enrollments on students.studentid=enrollments.StudentID inner join
courses on courses.courseid=enrollments.courseid
where CourseName='Math 101'
--8
select customers.FirstName, customers.LastName, orders.quantity from customers
inner join orders on customers.CustomerID=orders.CustomerID
where Quantity>3
--9
select employees.[name], departments.DepartmentName from employees
inner join departments on Employees.DepartmentID=Departments.DepartmentID
where DepartmentName='Human Resources'
--medium level tasks
--10
select count(EmployeeID), departments.Departmentname from employees
inner join departments on employees.departmentid=departments.DepartmentID 
group by DepartmentName
having count(employeeid)>5
--11
select sales.productid, products.productname, sales.saledate from sales 
right join products on sales.productid=products.productid where sales.productid is null
--12
SELECT DISTINCT 
    customers.FirstName, 
    customers.LastName, orders.totalamount
FROM 
    customers
INNER JOIN orders ON customers.CustomerID = orders.CustomerID
WHERE 
    orders.Quantity >= 1 order by firstname desc
--13
select Employees.employeeid, employees.[name], Departments.DepartmentName
from employees inner join Departments on employees.DepartmentID=Departments.DepartmentID
--14
SELECT 
    employee1.[name],
    employee2.[name], employee1.ManagerID
FROM 
    Employees AS employee1
JOIN 
    Employees as employee2 ON employee1.ManagerID = employee2.ManagerID
WHERE 
    employee1.EmployeeID < employee2.EmployeeID;
--15
select orders.orderid, orders.orderdate, customers.firstname, customers.lastname
from orders full join customers on orders.CustomerID=customers.customerid
where year(orders.orderdate)=2022
--16
select employees.[name], employees.salary, departments.departmentname from employees
inner join Departments on employees.departmentid=departments.departmentid
where departmentname='Sales'and salary>60000
--17
SELECT 
    Orders.OrderID, 
    Orders.OrderDate, 
    Payments.PaymentDate, 
    Payments.Amount
FROM 
    Orders
INNER JOIN 
    Payments ON Orders.OrderID = Payments.OrderID
--18
SELECT 
    Products.ProductID, 
    Products.ProductName
FROM 
    Products
right JOIN 
    Orders ON Products.ProductID = Orders.ProductID
WHERE 
    Orders.ProductID IS NULL
--19
select [Name] as employeename, salary, DEPARTMENTID FROM Employees
WHERE SALARY>(SELECT AVG(SALARY)FROM EMPLOYEES AS EMPLOYEES2
WHERE EMPLOYEES.DepartmentID=EMPLOYEES2.DepartmentID)
--20
select orders.orderid, orders.orderdate, payments.paymentid from orders
left join payments on payments.orderid=orders.orderid where orderdate<'2020-01-01'
and paymentid is null
--21
SELECT 
    Products.ProductID, 
    Products.ProductName
FROM 
    Products
LEFT JOIN 
    Categories ON Products.Category = Categories.CategoryID
WHERE 
    Categories.CategoryID IS NULL;
--22
select employee1.[name], employee2.[name], employee1.managerid, employee1.salary
FROM EMPLOYEES AS EMPLOYEE1 INNER JOIN EMPLOYEES AS EMPLOYEE2
ON EMPLOYEE1.ManagerID=EMPLOYEE2.ManagerID 
AND EMPLOYEE1.EmployeeID < EMPLOYEE2.EmployeeID
WHERE EMPLOYEE1.Salary > 60000 AND EMPLOYEE2.Salary > 60000;
--23
select employees.[name], departments.DepartmentName from employees inner join
departments on employees.DepartmentID=Departments.DepartmentID
where DepartmentName like 'M%'
--24
SELECT 
    s.SaleID,
    p.ProductName,
    s.SaleAmount
FROM 
    Sales s
INNER JOIN 
    Products p ON s.ProductID = p.ProductID
WHERE 
    s.SaleAmount > 500;
--25
SELECT 
    s.StudentID,
    s.Name
FROM 
    Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
LEFT JOIN Courses c ON e.CourseID = c.CourseID AND c.CourseName = 'Math 101'
WHERE 
    c.CourseID IS NULL;
--26
SELECT 
    o.OrderID,
    o.OrderDate,
	p.paymentid
FROM 
    Orders o
LEFT JOIN 
    Payments p ON o.OrderID = p.OrderID
WHERE 
    p.PaymentID IS NULL;
--27
SELECT 
    p.ProductID,
    p.ProductName,
    c.CategoryName
FROM 
    Products p
INNER JOIN 
    Categories c ON p.Category = c.CategoryID
WHERE 
    c.CategoryName IN ('Electronics', 'Furniture')
