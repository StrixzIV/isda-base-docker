-- Question 103 Solution: SUBQUERY (Customers Placed Orders with Engineering Staff)
SELECT customer_id, customer_name, city, country FROM customers WHERE customer_id IN (SELECT o.customer_id FROM orders o JOIN employees e ON o.employee_id = e.employee_id WHERE e.department_id = 102) ORDER BY customer_id ASC;
