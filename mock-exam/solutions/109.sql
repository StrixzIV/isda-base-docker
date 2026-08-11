-- Question 109 Solution: WHERE (Presidents Born in Texas (Textbook Ex 6.02))
SELECT pres_name, birth_yr, yrs_serv, death_age, party, state_born FROM recent_presidents WHERE state_born = 'Texas' ORDER BY pres_name ASC;
