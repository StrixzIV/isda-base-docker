-- Question 59 Solution: HAVING (Cities with Multiple Customers)
SELECT city, COUNT(customer_id) AS customer_count FROM customers GROUP BY city HAVING COUNT(customer_id) >= 2 ORDER BY customer_count DESC;
