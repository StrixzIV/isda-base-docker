-- Question 89 Solution: GROUP BY (Representative Order Status Breakdown)
SELECT employee_id, status, COUNT(*) AS status_count FROM orders GROUP BY employee_id, status ORDER BY employee_id ASC, status ASC;
