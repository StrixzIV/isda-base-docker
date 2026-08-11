-- Question 34 Solution: GROUP BY (Category Sales & Price Metrics)
SELECT category, SUM(quantity) AS total_quantity, AVG(unit_price) AS avg_price FROM order_items GROUP BY category ORDER BY total_quantity DESC;
