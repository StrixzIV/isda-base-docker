-- Question 77 Solution: WHERE (Line Item Total Value Range)
SELECT item_id, product_name, unit_price, quantity, unit_price * quantity AS line_total FROM order_items WHERE unit_price * quantity BETWEEN 500.00 AND 2000.00 ORDER BY line_total DESC;
