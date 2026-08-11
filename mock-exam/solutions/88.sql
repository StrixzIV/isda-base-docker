-- Question 88 Solution: GROUP BY (Department Compensation by Hire Year)
SELECT department_id, EXTRACT(YEAR FROM hire_date) AS hire_year, COUNT(*) AS emp_count, AVG(salary) AS avg_salary FROM employees GROUP BY department_id, EXTRACT(YEAR FROM hire_date) ORDER BY department_id ASC, hire_year ASC;
