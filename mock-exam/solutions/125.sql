-- Question 125 Solution: SUBQUERY (Presidents Born in Shared Birth Years (Textbook Ex 12.01a))
SELECT pres_name, birth_yr FROM president WHERE birth_yr IN (SELECT birth_yr FROM president GROUP BY birth_yr HAVING COUNT(*) > 1) ORDER BY birth_yr ASC, pres_name ASC;
