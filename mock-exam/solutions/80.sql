-- Question 80 Solution: WHERE (Excluding Non-Product Categories)
SELECT item_id, product_name, category, unit_price FROM order_items WHERE category <> 'Services' ORDER BY unit_price DESC;
