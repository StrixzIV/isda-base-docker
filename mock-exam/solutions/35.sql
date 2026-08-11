-- Question 35 Solution: GROUP BY (Employee Sales Volume)
SELECT employee_id, COUNT(*) AS orders_handled, SUM(total_amount) AS handled_revenue FROM orders GROUP BY employee_id ORDER BY handled_revenue DESC;
