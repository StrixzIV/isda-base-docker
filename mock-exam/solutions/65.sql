-- Question 65 Solution: SUBQUERY (Employees Processed Completed Orders)
SELECT e.employee_id, e.first_name, e.last_name, e.job_title FROM employees e WHERE EXISTS (SELECT 1 FROM orders o WHERE o.employee_id = e.employee_id AND o.status = 'Completed') ORDER BY e.employee_id ASC;
