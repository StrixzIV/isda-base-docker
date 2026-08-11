-- Question 29 Solution: AGGREGATION (Order Financial Metrics Summary)
SELECT COUNT(*) AS total_orders, SUM(total_amount) AS grand_total, AVG(total_amount) AS avg_amount, MIN(total_amount) AS min_amount, MAX(total_amount) AS max_amount FROM orders;
