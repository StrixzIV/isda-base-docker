-- Question 45 Solution: JOIN (Orders with Customer and Employee Names)
SELECT o.order_id, c.customer_name, e.first_name || ' ' || e.last_name AS employee_name, o.total_amount FROM orders o JOIN customers c ON o.customer_id = c.customer_id JOIN employees e ON o.employee_id = e.employee_id ORDER BY o.order_id ASC;
