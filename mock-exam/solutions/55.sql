-- Question 55 Solution: HAVING (High Revenue Order Statuses)
SELECT status, SUM(total_amount) AS status_revenue FROM orders GROUP BY status HAVING SUM(total_amount) > 5000.00 ORDER BY status_revenue DESC;
