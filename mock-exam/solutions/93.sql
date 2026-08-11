-- Question 93 Solution: JOIN (Unassigned Departments Audit (LEFT JOIN Filter))
SELECT d.department_id, d.department_name, d.location FROM departments d LEFT JOIN employees e ON d.department_id = e.department_id WHERE e.employee_id IS NULL ORDER BY d.department_id ASC;
