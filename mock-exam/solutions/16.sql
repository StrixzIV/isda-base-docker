-- Question 16 Solution: WHERE (Bulk Low-Cost Items Filter)
SELECT item_id, product_name, unit_price, quantity FROM order_items WHERE quantity >= 5 AND unit_price < 200.00 ORDER BY quantity DESC;
