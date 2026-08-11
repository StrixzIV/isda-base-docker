-- Question 107 Solution: SELECT (Presidential Age at Death Projection (Textbook Ex 3.05))
SELECT pres_name, party, death_age FROM president WHERE death_age IS NOT NULL ORDER BY death_age DESC, pres_name ASC;
