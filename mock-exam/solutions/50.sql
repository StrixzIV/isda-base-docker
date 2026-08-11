-- Question 50 Solution: JOIN (High Salary Rep Completed Orders)
SELECT o.order_id, e.first_name, e.salary, o.total_amount FROM orders o JOIN employees e ON o.employee_id = e.employee_id WHERE o.status = 'Completed' AND e.salary > 70000.00 ORDER BY o.total_amount DESC;
