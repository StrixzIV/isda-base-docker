-- Question 67 Solution: SUBQUERY (Departments Employing Top Earners)
SELECT department_id, department_name, location FROM departments WHERE department_id IN (SELECT department_id FROM employees WHERE salary >= 110000.00) ORDER BY department_id ASC;
