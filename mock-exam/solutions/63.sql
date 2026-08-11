-- Question 63 Solution: SUBQUERY (Employees Earning Above Department Average)
SELECT e1.employee_id, e1.first_name, e1.last_name, e1.department_id, e1.salary FROM employees e1 WHERE e1.salary > (SELECT AVG(e2.salary) FROM employees e2 WHERE e2.department_id = e1.department_id) ORDER BY e1.department_id ASC, e1.salary DESC;
