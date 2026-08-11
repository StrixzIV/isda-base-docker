-- Question 74 Solution: SELECT (Distinct Customer Registration Years)
SELECT DISTINCT EXTRACT(YEAR FROM registration_date) AS reg_year FROM customers ORDER BY reg_year ASC;
