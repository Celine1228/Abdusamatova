--Level 1: Basic Subqueries
--1--
select name, salary from employees
where salary=(select min(salary) from employees)
--2--
select price, product_name from products
where price>(select avg(price) from products) 
--3--
select employees.[name], departments. department_name from employees inner join
departments on employees.department_id=departments.id where department_name='Sales'
--4--
select customers.[name], order_id from orders right join customers on orders.customer_id=customers.customer_id
where order_id is null
--5--
select * from products as p1
join
(select category_id, max(price) as maxprice from products group by category_id) as maxprices
on p1.category_id = maxprices.category_id
AND p1.price = maxprices.maxprice
--6--
SELECT e.*
FROM employees e
JOIN (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    HAVING AVG(salary) = (
        SELECT MAX(avg_salary)
        FROM (
            SELECT AVG(salary) AS avg_salary
            FROM employees
            GROUP BY department_id
        ) AS dept_avg)) AS max_dept ON e.department_id = max_dept.department_id
--7
select * from employees where 
salary>(select avg(salary) from employees)

--8
SELECT s.student_id, s.name, g.course_id, g.grade
FROM grades g
JOIN students s ON g.student_id = s.student_id
WHERE g.grade = (
    SELECT MAX(g2.grade)
    FROM grades g2
    WHERE g2.course_id = g.course_id)
--9
SELECT *
FROM products p1
WHERE 2 = (
    SELECT COUNT(DISTINCT price)
    FROM products p2
    WHERE p2.category_id = p1.category_id
      AND p2.price > p1.price)
--10
SELECT *
FROM employees e
WHERE salary > (SELECT AVG(salary) FROM employees)
  AND salary < (
      SELECT MAX(salary)
      FROM employees e2
      WHERE e2.department_id = e.department_id)
