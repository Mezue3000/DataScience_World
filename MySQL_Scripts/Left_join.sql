-- Display customer names and emails who has not place order

USE sales_hub;
SELECT c.first_name, c.last_name, c.email, o.order_id
FROM customers c
LEFT JOIN orders o
USING(customer_id)
WHERE order_id IS NULL;
