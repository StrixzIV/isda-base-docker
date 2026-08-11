-- Question 72 Solution: SELECT (Product Discount Price Projection)
SELECT product_name, unit_price, unit_price * 0.85 AS discounted_price FROM order_items ORDER BY discounted_price DESC;
