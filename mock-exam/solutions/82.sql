-- Question 82 Solution: AGGREGATION (Order Monetary Spread Metric)
SELECT MAX(total_amount) AS max_order, MIN(total_amount) AS min_order, MAX(total_amount) - MIN(total_amount) AS order_spread FROM orders;
