-- Question 121 Solution: HAVING (States Providing Multiple Presidents (Textbook Ex 11.07))
SELECT state_born, COUNT(*) AS pres_count FROM president GROUP BY state_born HAVING COUNT(*) >= 3 ORDER BY pres_count DESC, state_born ASC;
