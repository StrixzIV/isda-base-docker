-- Question 31 Solution: GROUP BY (Department Employee Count & Average Salary)
SELECT department_id, COUNT(*) AS emp_count, AVG(salary) AS avg_salary FROM employees GROUP BY department_id ORDER BY department_id ASC;
