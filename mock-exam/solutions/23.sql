-- Question 23 Solution: AGGREGATION (Earliest and Latest Hire Dates)
SELECT MIN(hire_date) AS earliest_hire, MAX(hire_date) AS latest_hire FROM employees;
