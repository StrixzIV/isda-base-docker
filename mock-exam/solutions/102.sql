-- Question 102 Solution: SUBQUERY (Line Items Above Average Quantity)
SELECT item_id, product_name, quantity, unit_price FROM order_items WHERE quantity > (SELECT AVG(quantity) FROM order_items) ORDER BY quantity DESC, item_id ASC;
