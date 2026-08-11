-- Question 96 Solution: HAVING (High Average Order Value Cities)
SELECT c.city, AVG(o.total_amount) AS avg_order_value FROM customers c JOIN orders o ON c.customer_id = o.customer_id GROUP BY c.city HAVING AVG(o.total_amount) > 2500.00 ORDER BY avg_order_value DESC;
