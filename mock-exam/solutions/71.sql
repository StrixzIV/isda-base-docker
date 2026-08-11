-- Question 71 Solution: SELECT (Employee Seniority Projection)
SELECT employee_id, first_name || ' ' || last_name AS full_name, hire_date, EXTRACT(YEAR FROM hire_date) AS hire_year FROM employees ORDER BY hire_date ASC;
