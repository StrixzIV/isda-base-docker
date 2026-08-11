-- Question 09 Solution: SELECT (Distinct Product Categories & Prices)
SELECT DISTINCT category, unit_price FROM order_items ORDER BY category ASC, unit_price DESC;
