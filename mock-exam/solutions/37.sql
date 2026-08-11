-- Question 37 Solution: GROUP BY (Product Sales Volume Summary)
SELECT product_name, SUM(quantity) AS total_units, SUM(unit_price * quantity) AS product_revenue FROM order_items GROUP BY product_name ORDER BY product_revenue DESC;
