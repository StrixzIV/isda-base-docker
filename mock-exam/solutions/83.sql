-- Question 83 Solution: AGGREGATION (Unfulfilled Revenue Tied Up in Pending Orders)
SELECT SUM(total_amount) AS pending_revenue FROM orders WHERE status = 'Pending';
