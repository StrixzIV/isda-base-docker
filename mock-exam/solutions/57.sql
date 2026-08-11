-- Question 57 Solution: HAVING (Premium Product Categories)
SELECT category, AVG(unit_price) AS avg_price FROM order_items GROUP BY category HAVING AVG(unit_price) >= 100.00 ORDER BY avg_price DESC;
