-- Question 47 Solution: JOIN (Completed Order Items with Customer City)
SELECT oi.item_id, oi.product_name, c.customer_name, c.city FROM order_items oi JOIN orders o ON oi.order_id = o.order_id JOIN customers c ON o.customer_id = c.customer_id WHERE o.status = 'Completed' ORDER BY oi.item_id ASC;
