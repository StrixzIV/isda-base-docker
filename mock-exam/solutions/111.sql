-- Question 111 Solution: WHERE (Presidents Age Ratio at Marriage (Textbook Ex 8.05))
SELECT pres_name, pr_age, spouse_name, sp_age FROM pres_marriage WHERE CAST(pr_age AS DECIMAL) / sp_age BETWEEN 1.0 AND 1.10 ORDER BY pres_name ASC, spouse_name ASC;
