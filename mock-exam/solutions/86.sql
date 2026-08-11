-- Question 86 Solution: GROUP BY (Account Registrations by Year)
SELECT EXTRACT(YEAR FROM registration_date) AS reg_year, COUNT(*) AS account_count FROM customers GROUP BY EXTRACT(YEAR FROM registration_date) ORDER BY reg_year ASC;
