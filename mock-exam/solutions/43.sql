-- Question 43 Solution: JOIN (All Departments & Assigned Employees)
SELECT d.department_id, d.department_name, e.first_name FROM departments d LEFT JOIN employees e ON d.department_id = e.department_id ORDER BY d.department_id ASC, e.first_name ASC;
