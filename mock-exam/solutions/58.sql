-- Question 58 Solution: HAVING (Top Sales Representatives by Handled Volume)
SELECT e.employee_id, e.first_name, e.last_name, SUM(o.total_amount) AS handled_revenue FROM employees e JOIN orders o ON e.employee_id = o.employee_id GROUP BY e.employee_id, e.first_name, e.last_name HAVING SUM(o.total_amount) >= 4000.00 ORDER BY handled_revenue DESC;
