-- Question 11 Solution: WHERE (High Salary Employees Filter)
SELECT employee_id, first_name, last_name, salary FROM employees WHERE salary > 80000.00 ORDER BY salary DESC;
