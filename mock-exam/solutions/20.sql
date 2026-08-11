-- Question 20 Solution: WHERE (Complex Department & Salary Filter)
SELECT employee_id, first_name, last_name, department_id, salary FROM employees WHERE department_id = 101 OR (department_id = 102 AND salary >= 120000.00) ORDER BY employee_id ASC;
