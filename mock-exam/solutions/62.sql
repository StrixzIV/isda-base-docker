-- Question 62 Solution: SUBQUERY (Customers Without Completed Purchases)
SELECT customer_id, customer_name, city, country FROM customers WHERE customer_id NOT IN (SELECT customer_id FROM orders WHERE status = 'Completed') ORDER BY customer_id ASC;
