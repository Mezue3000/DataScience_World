-- Create and query view orders list to show all customers that have ordered
USE sales_hub;

CREATE OR REPLACE VIEW orders_list AS
SELECT cus.first_name, cus.address, ord.order_id, ord.date
FROM customers cus
JOIN orders ord
USING(customer_id);

-- Query the created view
SELECT *
FROM orders_list
WHERE first_name = 'john';
