
--Task 1:
create procedure calculate_bonus
as
begin
create table #EmployeeBonus 
(employeeid int, fullname varchar(50), department varchar(50), salary decimal(10,2), bonus_amount decimal(10, 2))

insert into #EmployeeBonus
select employeeid, firstname+' '+lastname fullname, employees.department, salary, 
(employees.salary*departmentbonus.BonusPercentage)/100 'bonus amount' from employees join DepartmentBonus
on employees.Department=DepartmentBonus.Department

select*from #EmployeeBonus

end;
--Task 2
create procedure updatedsalary @departmentname varchar(50), @salaryincreasepercent decimal(10,2)
as 
begin
update employees
set salary=salary+(salary*@salaryincreasepercent/100)
where Department=@departmentname

SELECT *
    FROM Employees
    WHERE Department = @DepartmentName

	END;
exec updatedsalary 'sales', 15

--task3
merge products_current as t
using products_new as s on t.productid=s.productid
when matched then update set t.price=s.price, t.productname=s.productname

when not matched by target then insert values(s.productid, s.productname, s.price)

when not matched by source then delete;

select *from products_current

--task4
SELECT 
    t1.id,
    CASE 
        WHEN t1.p_id IS NULL THEN 'Root'
        WHEN NOT EXISTS (
            SELECT 1 FROM Tree t2 WHERE t2.p_id = t1.id
        ) THEN 'Leaf'
        ELSE 'Inner'
    END AS type
FROM Tree t1;
--task 6
select *from employees where salary=
(select min(salary) engkam from employees)
--task 7
create procedure GetProductSalesSummary @productID INT=1
AS
BEGIN
select productname, sum(quantity) as totalquant, sum(Quantity*Price) salesamount, max(saledate) lastdate, min(saledate) firstdate from products p
left join sales s on p.productid=s.productid where p.productid=@productid group by p.productid, ProductName
END;
getProductSalesSummary 
