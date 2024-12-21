-- DISPLAY CUSTOMERS EMAIL WITH ORDER DATE WHOSE PRODUCT STATUS IS UNAVAILABLE
USE sales_hub;
SELECT c.email, o.date AS order_date, p.name AS product_name, p.status
FROM customers c
JOIN orders o
USING(customer_id)
JOIN products P
USING(product_id)
WHERE status = 'unavailable';