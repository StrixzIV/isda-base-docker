-- Question 38 Solution: GROUP BY (Customer Order Placements)
SELECT customer_id, COUNT(*) AS total_orders, SUM(total_amount) AS total_spent FROM orders GROUP BY customer_id ORDER BY total_orders DESC, total_spent DESC;
