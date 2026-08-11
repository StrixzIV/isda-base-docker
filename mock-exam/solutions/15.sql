-- Question 15 Solution: WHERE (Excluding Specific Cities)
SELECT customer_id, customer_name, city, country FROM customers WHERE city NOT IN ('New York', 'London') ORDER BY city ASC;
