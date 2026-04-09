-- Hotel Management Queries

-- Q1: Get user_id and last booked room_no
SELECT u.user_id,
       u.name,
       b.room_no   AS last_booked_room_no,
       b.booking_date AS last_booking_date
FROM   users u
JOIN   bookings b ON u.user_id = b.user_id
WHERE  b.booking_date = (
           SELECT MAX(b2.booking_date)
           FROM   bookings b2
           WHERE  b2.user_id = u.user_id
       );

-- Q2: Get booking_id and total billing amount of every booking created in November, 2021
SELECT b.booking_id,
       SUM(bc.item_quantity * i.item_rate) AS total_billing_amount
FROM   bookings b
JOIN   booking_commercials bc ON b.booking_id = bc.booking_id
JOIN   items i                ON bc.item_id   = i.item_id
WHERE  YEAR(b.booking_date)  = 2021
  AND  MONTH(b.booking_date) = 11
GROUP BY b.booking_id;

-- Q3: Get bill_id and bill amount of all the bills raised in October, 2021 having bill amount > 1000
SELECT bc.bill_id,
       SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM   booking_commercials bc
JOIN   items i ON bc.item_id = i.item_id
WHERE  YEAR(bc.bill_date)  = 2021
  AND  MONTH(bc.bill_date) = 10
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate) > 1000;

-- Q4: Determine the most ordered and least ordered item of each month of year 2021
WITH MonthlyItemOrders AS (
    SELECT MONTH(bc.bill_date)             AS order_month,
           i.item_name,
           SUM(bc.item_quantity)           AS total_quantity
    FROM   booking_commercials bc
    JOIN   items i ON bc.item_id = i.item_id
    WHERE  YEAR(bc.bill_date) = 2021
    GROUP BY MONTH(bc.bill_date), i.item_name
),
RankedItems AS (
    SELECT order_month,
           item_name,
           total_quantity,
           RANK() OVER (PARTITION BY order_month ORDER BY total_quantity DESC) AS rank_most,
           RANK() OVER (PARTITION BY order_month ORDER BY total_quantity ASC)  AS rank_least
    FROM   MonthlyItemOrders
)
SELECT order_month,
       item_name,
       total_quantity,
       CASE
           WHEN rank_most  = 1 THEN 'Most Ordered'
           WHEN rank_least = 1 THEN 'Least Ordered'
       END AS order_status
FROM   RankedItems
WHERE  rank_most = 1 OR rank_least = 1
ORDER BY order_month, order_status;

-- Q5: Find the customers with the second highest bill value of each month of year 2021
WITH MonthlyCustomerBills AS (
    SELECT MONTH(bc.bill_date)             AS bill_month,
           b.user_id,
           u.name                          AS customer_name,
           bc.bill_id,
           SUM(bc.item_quantity * i.item_rate) AS bill_amount
    FROM   booking_commercials bc
    JOIN   bookings b ON bc.booking_id = b.booking_id
    JOIN   users u    ON b.user_id     = u.user_id
    JOIN   items i    ON bc.item_id    = i.item_id
    WHERE  YEAR(bc.bill_date) = 2021
    GROUP BY MONTH(bc.bill_date), b.user_id, u.name, bc.bill_id
),
RankedBills AS (
    SELECT bill_month,
           user_id,
           customer_name,
           bill_id,
           bill_amount,
           DENSE_RANK() OVER (PARTITION BY bill_month ORDER BY bill_amount DESC) AS bill_rank
    FROM   MonthlyCustomerBills
)
SELECT bill_month,
       user_id,
       customer_name,
       bill_id,
       bill_amount
FROM   RankedBills
WHERE  bill_rank = 2
ORDER BY bill_month;
