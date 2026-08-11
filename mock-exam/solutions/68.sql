-- Question 68 Solution: SUBQUERY (Order Items from Completed US Orders)
SELECT item_id, product_name, category, unit_price FROM order_items WHERE order_id IN (SELECT order_id FROM orders WHERE status = 'Completed' AND customer_id IN (SELECT customer_id FROM customers WHERE country = 'USA')) ORDER BY item_id ASC;
