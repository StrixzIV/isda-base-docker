-- Question 27 Solution: AGGREGATION (Active Department Count)
SELECT COUNT(DISTINCT department_id) AS active_departments FROM employees;
