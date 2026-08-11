-- Question 04 Solution: SELECT (Employee Full Name Projection)
SELECT employee_id, first_name || ' ' || last_name AS full_name, job_title FROM employees ORDER BY full_name ASC;
