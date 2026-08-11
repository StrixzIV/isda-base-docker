-- Question 70 Solution: SUBQUERY (Master Challenge: Products Above Category Average Price)
SELECT oi1.item_id, oi1.product_name, oi1.category, oi1.unit_price FROM order_items oi1 WHERE oi1.unit_price > (SELECT AVG(oi2.unit_price) FROM order_items oi2 WHERE oi2.category = oi1.category) ORDER BY oi1.category ASC, oi1.unit_price DESC;
