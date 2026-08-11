-- Question 46 Solution: JOIN (All Customers Order Placement)
SELECT c.customer_id, c.customer_name, o.order_id FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id ORDER BY c.customer_id ASC, o.order_id ASC;
