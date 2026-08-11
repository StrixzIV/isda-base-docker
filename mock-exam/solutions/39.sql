-- Question 39 Solution: GROUP BY (Job Title Compensation Breakdown)
SELECT job_title, COUNT(*) AS title_count, AVG(salary) AS avg_title_salary FROM employees GROUP BY job_title ORDER BY avg_title_salary DESC;
