-- Question 97 Solution: HAVING (High Total Payroll Job Titles)
SELECT job_title, SUM(salary) AS title_payroll FROM employees GROUP BY job_title HAVING SUM(salary) > 100000.00 ORDER BY title_payroll DESC;
