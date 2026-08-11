-- Question 126 Solution: SUBQUERY (Presidents Born After Washington's Inauguration Subquery (Textbook Ex 11.15))
SELECT pres_name, birth_yr, party FROM president WHERE birth_yr > (SELECT MIN(year_inaug) FROM administration WHERE pres_name = 'Washington G') ORDER BY birth_yr ASC;
