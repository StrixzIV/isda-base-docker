-- Question 54 Solution: HAVING (High Average Salary Departments)
SELECT department_id, AVG(salary) AS avg_salary FROM employees GROUP BY department_id HAVING AVG(salary) > 75000.00 ORDER BY avg_salary DESC;
