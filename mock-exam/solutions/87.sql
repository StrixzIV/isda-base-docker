-- Question 87 Solution: GROUP BY (Category Line Items & Revenue Breakdown)
SELECT category, COUNT(*) AS item_count, SUM(quantity) AS total_units, SUM(unit_price * quantity) AS total_revenue FROM order_items GROUP BY category ORDER BY total_revenue DESC;
