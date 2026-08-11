-- Question 17 Solution: WHERE (Job Title Keyword Search)
SELECT employee_id, first_name, last_name, job_title FROM employees WHERE job_title LIKE '%Representative%' OR job_title LIKE '%Specialist%' ORDER BY employee_id ASC;
