-- Question 66 Solution: SUBQUERY (Highest Priced Product Details)
SELECT item_id, product_name, category, unit_price FROM order_items WHERE unit_price = (SELECT MAX(unit_price) FROM order_items) ORDER BY item_id ASC;
