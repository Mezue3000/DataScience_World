-- Calculate the total price for each products, order by product name in descending order
USE sales_hub;
SELECT 
   name,
   product_id,
   status,
   SUM(price) OVER(PARTITION BY status ORDER BY name DESC) AS total_price
FROM products;
