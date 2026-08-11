-- Question 90 Solution: GROUP BY (City Customer & Country Geographic Summary)
SELECT city, COUNT(*) AS customer_count, COUNT(DISTINCT country) AS country_count FROM customers GROUP BY city ORDER BY city ASC;
