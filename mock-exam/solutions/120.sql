-- Question 120 Solution: JOIN (Administration Inauguration Details with State (Textbook Ex 10.05))
SELECT a.admin_nr, a.pres_name, a.year_inaug, p.state_born FROM administration a JOIN president p ON a.pres_name = p.pres_name ORDER BY a.admin_nr ASC;
