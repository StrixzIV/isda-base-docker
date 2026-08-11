-- Question 110 Solution: WHERE (Republican Presidents Born in Texas (Textbook Ex 6.05))
SELECT pres_name, birth_yr, yrs_serv, death_age, party, state_born FROM recent_presidents WHERE party = 'Republican' AND state_born = 'Texas' ORDER BY pres_name ASC;
