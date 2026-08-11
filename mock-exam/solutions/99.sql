-- Question 99 Solution: HAVING (Reps Handling Multiple Completed Orders)
SELECT employee_id, COUNT(*) AS completed_count FROM orders WHERE status = 'Completed' GROUP BY employee_id HAVING COUNT(*) >= 2 ORDER BY completed_count DESC;
