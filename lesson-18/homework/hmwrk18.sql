--1
create table #monthlysales(productid int, quantitysold int, totalrevenue decimal(10,2))

insert into #monthlysales
select products.productid, sum(quantity) quantitysold, sum(price*quantity) totalrevenue from products
join sales on products.productid=sales.productid 
where DATEPART(MONTH, SaleDate) = DATEPART(MONTH, GETDATE())
AND DATEPART(YEAR, SaleDate) = DATEPART(YEAR, GETDATE()) 
group by products.ProductID 
--2
create view vw_ProductSalesSummary as
SELECT 
    p.ProductID,
    p.ProductName,
    p.Category,
    SUM(s.Quantity) AS TotalQuantitySold
FROM Products p
INNER JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY 
    p.ProductID,
    p.ProductName,
    p.Category

sp_helptext vw_ProductSalesSummary
mary
--3

create function fn_GetTotalRevenueForProduct(@ProductID INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
DECLARE @TotalRevenue DECIMAL(18,2)
SELECT @TotalRevenue = SUM(s.Quantity * p.Price)
    FROM Sales s
    INNER JOIN Products p ON s.ProductID = p.ProductID
    WHERE s.ProductID = @ProductID;
    RETURN ISNULL(@TotalRevenue, 0);
END;

--4
CREATE FUNCTION fn_GetSalesByCategory (@Category VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantity,
        SUM(s.Quantity * p.Price) AS TotalRevenue
    FROM Products p
    INNER JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.Category = @Category
    GROUP BY p.ProductName, p.Price
);
--5
CREATE FUNCTION fn_IsPrime (@Num INT)
RETURNS VARCHAR(3)
AS
BEGIN
DECLARE @i INT = 2;
DECLARE @IsPrime BIT = 1; -- Assume prime unless proven otherwise

IF @Num <= 1 
SET @IsPrime = 0; -- 0 and 1 are not prime
ELSE
BEGIN
WHILE @i <= SQRT(@Num)
BEGIN
IF @Num % @i = 0
BEGIN
SET @IsPrime = 0;
BREAK;
END
SET @i = @i + 1;
END
END

    RETURN CASE WHEN @IsPrime = 1 THEN 'YES' ELSE 'No' END;
END;

--7
WITH RankedSalaries AS (
    SELECT DISTINCT Salary,
           DENSE_RANK() OVER (ORDER BY Salary DESC) AS Rank
    FROM Employees
)
SELECT 
    (SELECT Salary 
     FROM RankedSalaries
     WHERE Rank = 4) AS NthHighestSalary;

--8
WITH AllFriends AS (
    SELECT requester_id AS user_id
    FROM Friendships
    UNION ALL
    SELECT accepter_id AS user_id
    FROM Friendships
),
FriendCounts AS (
    SELECT user_id, COUNT(*) AS total_friends
    FROM AllFriends
    GROUP BY user_id
)
SELECT user_id AS id, total_friends
FROM FriendCounts
WHERE total_friends = (
    SELECT MAX(total_friends) FROM FriendCounts
);
--9
create view vw_CustomerOrderSummary as
select [name] fullname, c.customer_id, count(order_id) total_orders, ISNULL(SUM(o.amount), 0) AS total_amount,
    MAX(o.order_date) AS last_order_date
FROM Customers c
left JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id,
    c.name;
