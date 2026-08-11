-- Question 61 Solution: SUBQUERY (Employees Earning Above Average Salary)
SELECT employee_id, first_name, last_name, salary FROM employees WHERE salary > (SELECT AVG(salary) FROM employees) ORDER BY salary DESC;
