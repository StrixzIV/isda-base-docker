-- Question 119 Solution: JOIN (President Hobbies for Long-Serving Presidents (Textbook Ex 11.04))
SELECT p.pres_name, h.hobby FROM president p JOIN pres_hobby h ON p.pres_name = h.pres_name WHERE p.yrs_serv >= 8 ORDER BY h.hobby ASC, p.pres_name ASC;
