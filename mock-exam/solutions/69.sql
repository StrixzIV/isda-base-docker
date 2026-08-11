-- Question 69 Solution: SUBQUERY (Average Customer Total Expenditure)
SELECT AVG(customer_totals.total_spent) AS avg_customer_spending FROM (SELECT customer_id, SUM(total_amount) AS total_spent FROM orders WHERE status = 'Completed' GROUP BY customer_id) AS customer_totals;
