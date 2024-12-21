-- Display customer names and emails who has not place order
-- Using sub-query to compute it
USE sales_hub;
SELECT first_name, last_name, email
FROM customers
WHERE customer_id NOT IN (
      SELECT customer_id
      FROM orders
);
