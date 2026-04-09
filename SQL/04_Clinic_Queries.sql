
-- Q1: Find the revenue we got from each sales channel in a given year (e.g., 2021)

-- Approach: Simple GROUP BY on sales_channel with SUM(amount).

SELECT sales_channel,
       SUM(amount)   AS total_revenue,
       COUNT(oid)    AS total_orders
FROM   clinic_sales
WHERE  YEAR(datetime) = 2021
GROUP BY sales_channel
ORDER BY total_revenue DESC;

-- For PostgreSQL: EXTRACT(YEAR FROM datetime) = 2021


 -- Q2: Find top 10 the most valuable customers for a given year (e.g., 2021)

 -- Approach: Sum all customer spending and rank by total.

SELECT c.uid,
       c.name,
       SUM(cs.amount)  AS total_spent,
       COUNT(cs.oid)   AS total_orders
FROM   customer c
JOIN   clinic_sales cs ON c.uid = cs.uid
WHERE  YEAR(cs.datetime) = 2021
GROUP BY c.uid, c.name
ORDER BY total_spent DESC
LIMIT 10;

-- For SQL Server: Use TOP 10 instead of LIMIT 10


 -- Q3: Find month-wise revenue, expense, profit, status (profitable / not-profitable) for a given year (2021)
 
 -- Approach: Aggregate revenue and expenses separately by month then join them to compute profit.

WITH MonthlyRevenue AS (
    SELECT MONTH(datetime) AS month_num,
           SUM(amount)     AS total_revenue
    FROM   clinic_sales
    WHERE  YEAR(datetime) = 2021
    GROUP BY MONTH(datetime)
),
MonthlyExpense AS (
    SELECT MONTH(datetime) AS month_num,
           SUM(amount)     AS total_expense
    FROM   expenses
    WHERE  YEAR(datetime) = 2021
    GROUP BY MONTH(datetime)
)
SELECT r.month_num,
       r.total_revenue,
       COALESCE(e.total_expense, 0) AS total_expense,
       (r.total_revenue - COALESCE(e.total_expense, 0)) AS profit,
       CASE
           WHEN (r.total_revenue - COALESCE(e.total_expense, 0)) > 0
               THEN 'Profitable'
           ELSE 'Not Profitable'
       END AS status
FROM   MonthlyRevenue r
LEFT JOIN MonthlyExpense e ON r.month_num = e.month_num
ORDER BY r.month_num;


 -- Q4: For each city, find the most profitable clinic for a given month (e.g., September 2021)
 
 -- Approach: Calculate profit per clinic = revenue - expenses.
 -- Use RANK() partitioned by city, ordered by profit DESC.

WITH ClinicRevenue AS (
    SELECT cs.cid,
           SUM(cs.amount) AS total_revenue
    FROM   clinic_sales cs
    WHERE  YEAR(cs.datetime) = 2021
      AND  MONTH(cs.datetime) = 9
    GROUP BY cs.cid
),
ClinicExpense AS (
    SELECT e.cid,
           SUM(e.amount) AS total_expense
    FROM   expenses e
    WHERE  YEAR(e.datetime) = 2021
      AND  MONTH(e.datetime) = 9
    GROUP BY e.cid
),
ClinicProfit AS (
    SELECT cl.cid,
           cl.clinic_name,
           cl.city,
           cl.state,
           COALESCE(cr.total_revenue, 0) AS revenue,
           COALESCE(ce.total_expense, 0) AS expense,
           (COALESCE(cr.total_revenue, 0) - COALESCE(ce.total_expense, 0)) AS profit
    FROM   clinics cl
    LEFT JOIN ClinicRevenue cr ON cl.cid = cr.cid
    LEFT JOIN ClinicExpense ce ON cl.cid = ce.cid
),
RankedClinics AS (
    SELECT *,
           RANK() OVER (PARTITION BY city ORDER BY profit DESC) AS rank_num
    FROM   ClinicProfit
)
SELECT cid,
       clinic_name,
       city,
       state,
       revenue,
       expense,
       profit
FROM   RankedClinics
WHERE  rank_num = 1
ORDER BY city;


 -- Q5: For each state, find the second least profitable clinic for a given month (e.g., September 2021)
 
 -- Approach: Similar to Q4 but rank by profit ASC (least profitable first) and pick rank = 2.

WITH ClinicRevenue AS (
    SELECT cs.cid,
           SUM(cs.amount) AS total_revenue
    FROM   clinic_sales cs
    WHERE  YEAR(cs.datetime) = 2021
      AND  MONTH(cs.datetime) = 9
    GROUP BY cs.cid
),
ClinicExpense AS (
    SELECT e.cid,
           SUM(e.amount) AS total_expense
    FROM   expenses e
    WHERE  YEAR(e.datetime) = 2021
      AND  MONTH(e.datetime) = 9
    GROUP BY e.cid
),
ClinicProfit AS (
    SELECT cl.cid,
           cl.clinic_name,
           cl.city,
           cl.state,
           COALESCE(cr.total_revenue, 0) AS revenue,
           COALESCE(ce.total_expense, 0) AS expense,
           (COALESCE(cr.total_revenue, 0) - COALESCE(ce.total_expense, 0)) AS profit
    FROM   clinics cl
    LEFT JOIN ClinicRevenue cr ON cl.cid = cr.cid
    LEFT JOIN ClinicExpense ce ON cl.cid = ce.cid
),
RankedClinics AS (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY state ORDER BY profit ASC) AS rank_num
    FROM   ClinicProfit
)
SELECT cid,
       clinic_name,
       city,
       state,
       revenue,
       expense,
       profit
FROM   RankedClinics
WHERE  rank_num = 2
ORDER BY state;
