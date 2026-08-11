-- Question 104 Solution: SUBQUERY (Department with Maximum Total Payroll)
SELECT department_id, SUM(salary) AS max_dept_payroll FROM employees GROUP BY department_id HAVING SUM(salary) = (SELECT MAX(dept_sum) FROM (SELECT SUM(salary) AS dept_sum FROM employees GROUP BY department_id) AS dept_totals);
