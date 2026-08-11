-- Question 76 Solution: WHERE (Corporate Client Keyword Search)
SELECT customer_id, customer_name, city, country FROM customers WHERE customer_name LIKE '%Corp%' OR customer_name LIKE '%Inc%' ORDER BY customer_id ASC;
