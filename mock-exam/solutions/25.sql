-- Question 25 Solution: AGGREGATION (Total Revenue from Completed Orders)
SELECT SUM(total_amount) AS completed_revenue FROM orders WHERE status = 'Completed';
