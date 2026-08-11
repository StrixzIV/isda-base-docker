-- Question 78 Solution: WHERE (Second Half Hire Date Filter)
SELECT employee_id, first_name, last_name, hire_date FROM employees WHERE EXTRACT(MONTH FROM hire_date) >= 7 ORDER BY hire_date ASC;
