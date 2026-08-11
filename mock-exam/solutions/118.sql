-- Question 118 Solution: JOIN (Presidential Marriage Details Join (Textbook Ex 10.01))
SELECT p.pres_name, m.pr_age, m.spouse_name, m.sp_age FROM president p JOIN pres_marriage m ON p.pres_name = m.pres_name ORDER BY p.pres_name ASC, m.spouse_name ASC;
