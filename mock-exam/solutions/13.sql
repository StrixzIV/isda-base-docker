-- Question 13 Solution: WHERE (High Value Completed Orders)
SELECT order_id, customer_id, order_date, total_amount FROM orders WHERE status = 'Completed' AND total_amount >= 3000.00 ORDER BY total_amount DESC;
