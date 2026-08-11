-- Question 56 Solution: HAVING (High Value Completed Customers)
SELECT c.customer_id, c.customer_name, SUM(o.total_amount) AS total_completed_spend FROM customers c JOIN orders o ON c.customer_id = o.customer_id WHERE o.status = 'Completed' GROUP BY c.customer_id, c.customer_name HAVING SUM(o.total_amount) >= 3000.00 ORDER BY total_completed_spend DESC;
