-- Question 14 Solution: WHERE (Hire Date Range Filter)
SELECT employee_id, first_name, last_name, hire_date FROM employees WHERE hire_date BETWEEN '2020-01-01' AND '2022-12-31' ORDER BY hire_date ASC;
