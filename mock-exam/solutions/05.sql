-- Question 05 Solution: SELECT (Monthly Salary Calculation)
SELECT first_name, last_name, salary, salary / 12 AS monthly_salary FROM employees ORDER BY monthly_salary DESC;
