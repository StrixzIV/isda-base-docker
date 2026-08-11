-- Question 100 Solution: HAVING (Master Challenge: High Completed Revenue Countries)
SELECT c.country, COUNT(o.order_id) AS completed_orders, SUM(o.total_amount) AS country_revenue FROM customers c JOIN orders o ON c.customer_id = o.customer_id WHERE o.status = 'Completed' GROUP BY c.country HAVING SUM(o.total_amount) > 5000.00 ORDER BY country_revenue DESC;
