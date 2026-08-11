-- Question 30 Solution: AGGREGATION (Recent Hires Average Salary)
SELECT AVG(salary) AS recent_hire_avg_salary FROM employees WHERE hire_date >= '2020-01-01';
