-- Question 98 Solution: HAVING (High Gross Revenue Product Categories)
SELECT category, SUM(unit_price * quantity) AS gross_revenue FROM order_items GROUP BY category HAVING SUM(unit_price * quantity) > 3000.00 ORDER BY gross_revenue DESC;
