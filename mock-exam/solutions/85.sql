-- Question 85 Solution: AGGREGATION (Staff Compensation Spread Metric)
SELECT MAX(salary) AS max_salary, MIN(salary) AS min_salary, MAX(salary) - MIN(salary) AS salary_gap FROM employees;
