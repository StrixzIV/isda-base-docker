-- Question 75 Solution: SELECT (Formal Employee Name Formatting)
SELECT employee_id, last_name || ', ' || first_name AS formal_name FROM employees ORDER BY formal_name ASC;
