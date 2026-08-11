-- Question 101 Solution: SUBQUERY (Employees Hired After Average Hire Date)
SELECT employee_id, first_name, last_name, hire_date FROM employees WHERE hire_date > (SELECT AVG(hire_date) FROM employees) ORDER BY hire_date ASC;
