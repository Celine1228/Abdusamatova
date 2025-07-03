--1
select saledate, row_number() over(order by saledate) as rows from ProductSales
--2

SELECT PRODUCTNAME, TOTAL, DENSE_RANK() OVER(ORDER BY TOTAL DESC) AS RANK FROM
(SELECT PRODUCTNAME,SUM(QUANTITY) TOTAL FROM ProductSales
GROUP BY ProductName) AS TOTALGROUPED

--3

SELECT * 
FROM(SELECT CUSTOMERID,SALEAMOUNT, RANK() OVER (PARTITION BY CUSTOMERID ORDER BY SALEAMOUNT DESC) RN FROM PRODUCTSALES) AS RANKED
WHERE RN=1

--4
SELECT SALEDATE, SALEAMOUNT, LEAD(SALEAMOUNT) OVER (ORDER BY SALEDATE) AS NEXTSALEAMOUNT FROM PRODUCTSALES

--5
SELECT SALEDATE, SALEAMOUNT, LAG(SALEAMOUNT) OVER (ORDER BY SALEDATE) AS PREVSALEAMOUNT FROM PRODUCTSALES
--6
SELECT * 
FROM (SELECT SALEAMOUNT, LAG(SALEAMOUNT) OVER (ORDER BY SALEDATE) AS PREVSALEAMOUNT FROM PRODUCTSALES) PREVIOUSSALES

WHERE SALEAMOUNT>PREVSALEAMOUNT

--7

SELECT SALEAMOUNT, PRODUCTNAME, SALEAMOUNT-LAG(SALEAMOUNT) OVER (PARTITION BY PRODUCTNAME ORDER BY SALEDATE) 
AS PREVSALEAMOUNTDIF FROM PRODUCTSALES

--8
SELECT 
  SALEAMOUNT, 
  PRODUCTNAME, 
  LEAD(SALEAMOUNT) OVER (PARTITION BY PRODUCTNAME ORDER BY SALEDATE) AS NEXTSALEAMOUNT,
  CONCAT(
    CAST(
      ROUND(
        (LEAD(SALEAMOUNT) OVER (PARTITION BY PRODUCTNAME ORDER BY SALEDATE) - SALEAMOUNT) 
        / SALEAMOUNT * 100, 
      2) AS DECIMAL(10,2)
    ),
    '%'
  ) AS PERCENTAGECHANGE
FROM PRODUCTSALES;

--9

SELECT 
  PRODUCTNAME, 
  SALEDATE,
  SALEAMOUNT,
  LAG(SALEAMOUNT) OVER (PARTITION BY PRODUCTNAME ORDER BY SALEDATE) AS PREVSALEAMOUNT,
  CASE 
    WHEN LAG(SALEAMOUNT) OVER (PARTITION BY PRODUCTNAME ORDER BY SALEDATE) = 0 THEN NULL
    ELSE ROUND(
      SALEAMOUNT * 1.0 / LAG(SALEAMOUNT) OVER (PARTITION BY PRODUCTNAME ORDER BY SALEDATE), 
      2
    )
  END AS RATIO_TO_PREV
FROM PRODUCTSALES;

--10
SELECT 
    
    ProductID,
    SaleDate,
    SaleAmount,
    FirstSaleAmount,
    SaleAmount - FirstSaleAmount AS DifferenceFromFirst
FROM (
    SELECT 
      
        ProductID,
        SaleDate,
        SaleAmount,
        FIRST_VALUE(SaleAmount) OVER (
            PARTITION BY ProductID 
            ORDER BY SaleDate
        ) AS FirstSaleAmount
    FROM Sales
) AS SaleWithFirst
ORDER BY ProductID, SaleDate;

--11
SELECT *
FROM (
  SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PrevSaleAmount
  FROM ProductSales
) AS SalesWithPrev
WHERE SaleAmount > PrevSaleAmount;

--12
SELECT 
  SaleID,
  ProductName,
  SaleDate,
  SaleAmount,
  SUM(SaleAmount) OVER (
    PARTITION BY ProductName 
    ORDER BY SaleDate
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS ClosingBalance
FROM ProductSales;

--13
SELECT 
  SaleID,
  ProductName,
  SaleDate,
  SaleAmount,
  ROUND(
    AVG(SaleAmount) OVER (
      PARTITION BY ProductName 
      ORDER BY SaleDate 
      ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ),
    2
  ) AS MovingAvg_3Sales
FROM ProductSales;

--14
SELECT 
  SaleID,
  ProductName,
  SaleDate,
  SaleAmount,
  ROUND(
    SaleAmount - AVG(SaleAmount) OVER (), 
    2
  ) AS DifferenceFromAvg
FROM ProductSales;

--15

WITH RankedEmployees AS (
  SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
  FROM Employees1
)
SELECT *
FROM RankedEmployees
WHERE SalaryRank IN (
  SELECT SalaryRank
  FROM RankedEmployees
  GROUP BY SalaryRank
  HAVING COUNT(*) > 1
)
ORDER BY SalaryRank, Salary DESC;

--16
SELECT 
  EmployeeID,
  Name,
  Department,
  Salary,
  DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS SalaryRank
FROM Employees1
WHERE DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) <= 2
ORDER BY Department, Salary DESC;
--17
WITH RankedSalaries AS (
  SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    RANK() OVER (PARTITION BY Department ORDER BY Salary ASC) AS SalaryRank
  FROM Employees1
)
SELECT 
  EmployeeID,
  Name,
  Department,
  Salary
FROM RankedSalaries
WHERE SalaryRank = 1
ORDER BY Department;
--18
SELECT 
  EmployeeID,
  Name,
  Department,
  Salary,
  SUM(Salary) OVER (
    PARTITION BY Department 
    ORDER BY Salary
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS RunningTotalSalary
FROM Employees1
ORDER BY Department, Salary;
--19
SELECT 
  EmployeeID,
  Name,
  Department,
  Salary,
  SUM(Salary) OVER (PARTITION BY Department) AS TotalDepartmentSalary
FROM Employees1
ORDER BY Department, Name;
--20

SELECT 
  EmployeeID,
  Name,
  Department,
  Salary,
  ROUND(AVG(Salary) OVER (PARTITION BY Department), 2) AS AvgDepartmentSalary
FROM Employees1
ORDER BY Department, Name;
--21
SELECT 
  EmployeeID,
  Name,
  Department,
  Salary,
  ROUND(
    Salary - AVG(Salary) OVER (PARTITION BY Department), 
    2
  ) AS SalaryDiffFromDeptAvg
FROM Employees1
ORDER BY Department, Name;

--22

SELECT 
  EmployeeID,
  Name,
  Department,
  Salary,
  ROUND(
    AVG(Salary) OVER (
      ORDER BY Salary
      ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ),
    2
  ) AS MovingAvgSalary
FROM Employees1
ORDER BY Salary;
--23

WITH RankedHires AS (
  SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    HireDate,
    ROW_NUMBER() OVER (ORDER BY HireDate DESC) AS HireRank
  FROM Employees1
)
SELECT 
  SUM(Salary) AS SumLast3Hired
FROM RankedHires
WHERE HireRank <= 3;
