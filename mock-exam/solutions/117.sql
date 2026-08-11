-- Question 117 Solution: GROUP BY (Average Children per Presidential Marriage (Textbook Ex 9.05))
SELECT pres_name, AVG(nr_children) AS avg_children FROM pres_marriage GROUP BY pres_name ORDER BY avg_children DESC, pres_name ASC;
