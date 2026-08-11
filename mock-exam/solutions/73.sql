-- Question 73 Solution: SELECT (Customer Directory Tier Projection)
SELECT customer_id, customer_name, city, country, 'Standard' AS tier FROM customers ORDER BY customer_id ASC;
