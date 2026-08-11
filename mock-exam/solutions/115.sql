-- Question 115 Solution: GROUP BY (Presidents Count Born per State (Textbook Ex 9.02))
SELECT state_born, COUNT(*) AS pres_count FROM president GROUP BY state_born ORDER BY pres_count DESC, state_born ASC;
