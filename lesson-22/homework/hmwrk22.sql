--1
select CUSTOMER_ID, order_date, sum(total_amount) over(partition by customer_id order by order_date) runningtotalpercust from sales_data
--2
SELECT PRODUCT_CATEGORY, COUNT(SALE_ID) OVER(PARTITION BY PRODUCT_CATEGORY) SALEPERCTGR FROM sales_data
--3
SELECT 
  product_category,
  TOTALCAT,
  MAX(TOTALCAT) OVER () AS MAXTOTAL
FROM (
  SELECT 
    product_category,
    SUM(TOTAL_AMOUNT) AS TOTALCAT
  FROM SALES_DATA
  GROUP BY product_category
) sub;
--4
SELECT PRODUCT_CATEGORY, min(unit_price) OVER(PARTITION BY PRODUCT_CATEGORY) mintotal FROM sales_data
--5
select ORDER_DATE, AVG(TOTAL_AMOUNT) OVER( ORDER BY ORDER_DATE ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) MOVINGAVG FROM sales_data
--6
SELECT REGION, SUM(TOTAL_AMOUNT) OVER(PARTITION BY REGION) TOTALBYREGION FROM sales_data
--7
SELECT
  customer_id,
  total_sales,
  RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM (
  SELECT
    customer_id,
    SUM(total_amount) AS total_sales
  FROM sales_DATA
  GROUP BY customer_id
) sub;

--8
SELECT
  sale_id,
  customer_id,
  customer_name,
  order_date,
  total_amount,
  
  COALESCE(LAG(total_amount) OVER (
    PARTITION BY customer_id
    ORDER BY order_date
  ), 0) AS prev_amount,

  total_amount - COALESCE(LAG(total_amount) OVER (
    PARTITION BY customer_id
    ORDER BY order_date
  ), 0) AS amount_difference

FROM sales_data
ORDER BY customer_id, order_date;
--9
WITH ranked_products AS (
  SELECT
    product_category,
    product_name,
    unit_price,
    RANK() OVER (
      PARTITION BY product_category
      ORDER BY unit_price DESC
    ) AS price_rank
  FROM sales_data
)
SELECT *
FROM ranked_products
WHERE price_rank <= 3;
--10
SELECT
  region,
  order_date,
  total_amount,
  SUM(total_amount) OVER (
    PARTITION BY region
    ORDER BY order_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS cumulative_sales
FROM sales_data
ORDER BY region, order_date;
--11
SELECT SUM(TOTAL_AMOUNT) OVER(PARTITION BY PRODUCT_CATEGORY ORDER BY ORDER_DATE) AS CUMULATIVE FROM sales_data
--12
CREATE TABLE NUMBS (VALUESS INT)
INSERT INTO NUMBS VALUES(1),(2),(3),(4),(5)
SELECT VALUESS, SUM(VALUESS) OVER(ORDER BY VALUESS ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS PREVADD FROM NUMBS
--13
SELECT VALUE, SUM(VALUE) OVER(ORDER BY VALUE ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS PREVCUR FROM OneColumn
--15
WITH customer_category_counts AS (
  SELECT
    customer_id,
    customer_name,
    COUNT(DISTINCT product_category) AS category_count
  FROM sales_data
  GROUP BY customer_id, customer_name
)
SELECT *
FROM customer_category_counts
WHERE category_count > 1;
--16
WITH customer_spending AS (
  SELECT
    customer_id,
    customer_name,
    region,
    SUM(total_amount) AS customer_total,
    AVG(SUM(total_amount)) OVER (PARTITION BY region) AS region_avg
  FROM sales_data
  GROUP BY customer_id, customer_name, region
)
SELECT *
FROM customer_spending
WHERE customer_total > region_avg;
--17
WITH customer_totals AS (
  SELECT
    customer_id,
    customer_name,
    region,
    SUM(total_amount) AS total_spending
  FROM sales_data
  GROUP BY customer_id, customer_name, region
)
SELECT
  customer_id,
  customer_name,
  region,
  total_spending,
  RANK() OVER (
    PARTITION BY region
    ORDER BY total_spending DESC
  ) AS spending_rank
FROM customer_totals
ORDER BY region, spending_rank;
--18
select
  customer_id,
  customer_name,
  order_date,
  total_amount,
  sum(total_amount) over (
    partition by customer_id
    order by order_date
    rows between unbounded preceding and current row
  ) as cumulative_sales
from sales_data
order by customer_id, order_date;
--19
with monthly_sales as (
  select
    year(order_date) as sales_year,
    month(order_date) as sales_month,
    sum(total_amount) as monthly_total
  from sales_data
  group by year(order_date), month(order_date)
)
select
  sales_year,
  sales_month,
  monthly_total,
  lag(monthly_total) over (order by sales_year, sales_month) as previous_month_total,
  case
    when lag(monthly_total) over (order by sales_year, sales_month) is null then null
    when lag(monthly_total) over (order by sales_year, sales_month) = 0 then null
    else round(
      (monthly_total - lag(monthly_total) over (order by sales_year, sales_month)) * 100.0
      / lag(monthly_total) over (order by sales_year, sales_month), 2
    )
  end as growth_rate
from monthly_sales
order by sales_year, sales_month
--20
with sales_with_lag as (
  select
    customer_id,
    customer_name,
    order_date,
    total_amount,
    lag(total_amount) over (
      partition by customer_id
      order by order_date
    ) as previous_order_amount
  from sales_data
)
select *
from sales_with_lag
where total_amount > isnull(previous_order_amount, 0)
order by customer_id, order_date;
--21
select
  product_name,
  product_category,
  unit_price
from sales_data
where unit_price > (
  select avg(unit_price) from sales_data
);
--22
SELECT 
  Id, 
  Grp, 
  Val1, 
  Val2,
  CASE 
    WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1
    THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp)
    ELSE NULL
  END AS GroupSum
FROM MyData;
--23
SELECT 
  ID,
  SUM(Cost) AS TotalCost,
  SUM(DISTINCT Quantity) AS TotalQuantity
FROM TheSumPuzzle
GROUP BY ID
