-- Question 33 Solution: GROUP BY (Customer Count per Country)
SELECT country, COUNT(*) AS customer_count FROM customers GROUP BY country ORDER BY customer_count DESC;
