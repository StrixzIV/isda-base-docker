-- Question 81 Solution: AGGREGATION (Average Item Quantity & Unit Price)
SELECT AVG(quantity) AS avg_quantity, AVG(unit_price) AS avg_unit_price FROM order_items;
