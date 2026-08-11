-- Question 124 Solution: SUBQUERY (Hobbies of Long-Serving Presidents Subquery (Textbook Ex 11.06))
SELECT pres_name, hobby FROM pres_hobby WHERE pres_name IN (SELECT pres_name FROM president WHERE yrs_serv >= 8) ORDER BY pres_name ASC, hobby ASC;
