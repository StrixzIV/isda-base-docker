-- Question 26 Solution: AGGREGATION (Hardware Unit Price Metrics)
SELECT AVG(unit_price) AS avg_hardware_price, MAX(unit_price) AS max_hardware_price FROM order_items WHERE category = 'Hardware';
