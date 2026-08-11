-- Question 123 Solution: HAVING (Parties with High Average Years Served (Textbook Ex 11.12))
SELECT party, AVG(yrs_serv) AS avg_yrs_serv FROM president GROUP BY party HAVING AVG(yrs_serv) >= 5.0 ORDER BY avg_yrs_serv DESC;
