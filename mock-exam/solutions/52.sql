-- Question 52 Solution: HAVING (High Volume Categories)
SELECT category, SUM(quantity) AS total_quantity FROM order_items GROUP BY category HAVING SUM(quantity) > 5 ORDER BY total_quantity DESC;
