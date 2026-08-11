-- Question 122 Solution: HAVING (Presidents with Multiple Marriages (Textbook Ex 11.09))
SELECT pres_name, COUNT(*) AS marriage_count FROM pres_marriage GROUP BY pres_name HAVING COUNT(*) >= 2 ORDER BY marriage_count DESC, pres_name ASC;
