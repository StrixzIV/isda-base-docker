-- Question 32 Solution: GROUP BY (Order Status Financial Summary)
SELECT status, COUNT(*) AS order_count, SUM(total_amount) AS total_revenue FROM orders GROUP BY status ORDER BY total_revenue DESC;
