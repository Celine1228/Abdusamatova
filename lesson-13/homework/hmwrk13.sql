--easy tasks
--1
select concat(employee_id, '-', first_name, '', last_name) as output from employees where employee_id=100
--2
select*from employees
update employees
set phone_number=replace(phone_number, '124', '999')
where phone_number like'%124%'
--3
select first_name, len(first_name) AS lenght from employees where first_name like 
'A%' OR first_name like 'J%' or first_name like 'M%' order by first_name
--4
select manager_id, sum(salary) as 'total salary' from employees group by manager_id
--5
select year1, GREATEST(Max1, Max2, Max3) as highestvalue from TestMax
--6
select id, movie from cinema where id%2=1 and description !='boring'
--7
SELECT *
FROM SingleOrder
order by
case when id=0 then 2
else 1 end, ID
--8
SELECT ID, COALESCE (SSN, PASSPORTID, ITIN) AS NULLCHECK FROM PERSON
--Medium level tasks
--1
select fullname, left(fullname, CHARINDEX(' ',fullname)-1) as firstname, 
SUBSTRING(
    FullName,
    CHARINDEX(' ', FullName) + 1,
    CHARINDEX(' ', FullName, CHARINDEX(' ', FullName) + 1) - CHARINDEX(' ', FullName) - 1
  ) AS MiddleName,
  RIGHT(
    FullName,
    LEN(FullName) - CHARINDEX(' ', FullName, CHARINDEX(' ', FullName) + 1)
  ) AS LastName
  from students
--2
select* from orders where deliverystate='TX'
AND CUSTOMERID IN(SELECT CUSTOMERID FROM ORDERS WHERE DeliveryState='CA')
--3
--DID NOT GET IT
--4
SELECT *FROM Employees
WHERE LEN(LOWER(first_name + last_name)) - LEN(REPLACE(LOWER(first_name + last_name), 'a', '')) >= 3;
--DIFFICULT TASKS
--2
SELECT
    StudentID,
    FULLName,
    GRADE,
    SUM(GRADE) OVER (ORDER BY StudentID) CUMTotal
FROM Students
--4
SELECT 
    DATEPART(DAY, BIRTHDAY) AS Day,
    DATEPART(MONTH, BIRTHDAY) AS Month,
    COUNT(*) AS CountOfStudents
FROM Student
GROUP BY DATEPART(MONTH, BIRTHDAY), DATEPART(DAY, BIRTHDAY)
HAVING COUNT(*) > 1;

