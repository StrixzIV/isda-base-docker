-- Question 36 Solution: GROUP BY (Customer Distribution by Country & City)
SELECT country, city, COUNT(*) AS city_customer_count FROM customers GROUP BY country, city ORDER BY country ASC, city ASC;
