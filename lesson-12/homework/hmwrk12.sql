--1
SELECT 
    p.firstName,
    p.lastName,
    a.city,
    a.state
FROM Person p
LEFT JOIN Address a
    ON p.personId = a.personId;
--2
select*from employee as employee1 join employee as manager 
on employee1.managerid=manager.id where employee1.salary>manager.salary
--3
Create table Person (ID int, email varchar(255))
Truncate table Person insert into Person (id, email) values ('1', 'a@b.com') insert into Person (id, email) values ('2', 'c@d.com') insert into Person (id, email) values ('3', 'a@b.com')
select email, count(email) as cnt from person
group by email having count(email)>=2
--4
DELETE FROM Person
WHERE id NOT IN (
    SELECT MIN(id)
    FROM Person
    GROUP BY email
);

--5
select distinct girls.parentname from boys 
right join girls on girls.parentname=boys.parentname
where boys.[name] is null
--6
select * from Sales.Orders

select  
ord.custid,min(ord.freight) as min_weight, 
sum(case when freight>=50 then unitprice*qty
    else 0 end) as Total_Sale
from Sales.Orders as ord
JOIN
[Sales].[OrderDetails] as Orddetail
on ord.orderid=Orddetail.orderid
group by custid
order by custid
--7
select * from cart1
select* from cart2
select isnull(cart1.item, '') as item,
isnull(cart2.item, '') as item from cart1 full outer join cart2
on cart1.item=cart2.item 
--8
select customers.[name], orders.id from customers 
left join orders on customers.id=orders.customerid
where orders.customerid is null
--9
SELECT 
    s.student_id,
    s.student_name,
    sub.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM 
    Students s
CROSS JOIN 
    Subjects sub
LEFT JOIN 
    Examinations e
    ON s.student_id = e.student_id AND sub.subject_name = e.subject_name
GROUP BY 
    s.student_id, s.student_name, sub.subject_name
ORDER BY 
    s.student_id, sub.subject_name;

