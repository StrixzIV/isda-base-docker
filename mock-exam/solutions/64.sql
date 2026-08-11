-- Question 64 Solution: SUBQUERY (Customers Placed High-Value Orders)
SELECT customer_id, customer_name, city, country FROM customers WHERE customer_id IN (SELECT customer_id FROM orders WHERE total_amount >= 4000.00) ORDER BY customer_id ASC;
