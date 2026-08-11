-- Question 40 Solution: GROUP BY (Daily Order Activity)
SELECT order_date, COUNT(*) AS daily_orders, SUM(total_amount) AS daily_revenue FROM orders GROUP BY order_date ORDER BY order_date ASC;
