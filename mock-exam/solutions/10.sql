-- Question 10 Solution: SELECT (Product Pricing with Tax)
SELECT product_name, unit_price, unit_price * 1.10 AS price_with_tax FROM order_items ORDER BY price_with_tax DESC;
