-- Display customers name whose order date is beyound 2022/05/19
USE sales_hub;
SELECT c.first_name, c.last_name, o.date AS order_date
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.date > '2022-05-19';