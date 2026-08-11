-- Question 51 Solution: HAVING (Departments with Multiple Employees)
SELECT department_id, COUNT(*) AS emp_count FROM employees GROUP BY department_id HAVING COUNT(*) >= 3 ORDER BY emp_count DESC;
