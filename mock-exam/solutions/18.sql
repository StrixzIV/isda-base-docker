-- Question 18 Solution: WHERE (Unfulfilled Orders Filter)
SELECT order_id, customer_id, status, total_amount FROM orders WHERE status IN ('Pending', 'Cancelled') ORDER BY order_id ASC;
