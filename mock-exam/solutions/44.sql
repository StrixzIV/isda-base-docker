-- Question 44 Solution: JOIN (Order Items Order Context)
SELECT oi.item_id, oi.product_name, o.order_date, o.status FROM order_items oi JOIN orders o ON oi.order_id = o.order_id ORDER BY oi.item_id ASC;
