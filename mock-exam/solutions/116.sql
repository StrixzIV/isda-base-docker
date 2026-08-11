-- Question 116 Solution: GROUP BY (Years Served & Headcount Summary per Party (Textbook Ex 9.03))
SELECT party, SUM(yrs_serv) AS total_yrs_serv, COUNT(*) AS pres_count, AVG(yrs_serv) AS avg_yrs_serv FROM president GROUP BY party ORDER BY total_yrs_serv DESC;
