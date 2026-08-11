-- Question 12 Solution: WHERE (Specific Country Customers)
SELECT customer_id, customer_name, city, country FROM customers WHERE country IN ('USA', 'UK') ORDER BY customer_id ASC;
