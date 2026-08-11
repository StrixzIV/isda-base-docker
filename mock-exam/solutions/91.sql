-- Question 91 Solution: JOIN (Employee Department & Office Location)
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS employee_name, d.department_name, d.location FROM employees e JOIN departments d ON e.department_id = d.department_id ORDER BY e.employee_id ASC;
