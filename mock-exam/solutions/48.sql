-- Question 48 Solution: JOIN (Orders Handled by Department)
SELECT o.order_id, e.last_name, d.department_name, o.total_amount FROM orders o JOIN employees e ON o.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id ORDER BY o.order_id ASC;
