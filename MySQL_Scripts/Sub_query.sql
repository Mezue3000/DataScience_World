-- Get prices of products greater than product price with id of 2
USE sales_hub;
SELECT *
FROM products 
WHERE price > (
     SELECT price
     FROM products
     WHERE product_id = 2
);