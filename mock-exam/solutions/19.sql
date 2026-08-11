-- Question 19 Solution: WHERE (Hardware Price Range Filter)
SELECT item_id, product_name, unit_price FROM order_items WHERE category = 'Hardware' AND unit_price BETWEEN 50.00 AND 300.00 ORDER BY unit_price ASC;
