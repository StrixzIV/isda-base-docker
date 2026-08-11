-- Question 79 Solution: WHERE (Pending High Value or Cancelled Orders)
SELECT order_id, customer_id, status, total_amount FROM orders WHERE (status = 'Pending' AND total_amount > 1000.00) OR status = 'Cancelled' ORDER BY order_id ASC;
