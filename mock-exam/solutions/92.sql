-- Question 92 Solution: JOIN (Order Line Item Customer Context)
SELECT o.order_id, c.customer_name, oi.product_name, oi.unit_price * oi.quantity AS line_cost FROM orders o JOIN customers c ON o.customer_id = c.customer_id JOIN order_items oi ON o.order_id = oi.order_id ORDER BY o.order_id ASC, oi.product_name ASC;
