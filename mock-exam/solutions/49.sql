-- Question 49 Solution: JOIN (Full Order Item Audit Trail (4-Table Join))
SELECT oi.item_id, oi.product_name, c.customer_name, e.first_name, o.status FROM order_items oi JOIN orders o ON oi.order_id = o.order_id JOIN customers c ON o.customer_id = c.customer_id JOIN employees e ON o.employee_id = e.employee_id ORDER BY oi.item_id ASC;
