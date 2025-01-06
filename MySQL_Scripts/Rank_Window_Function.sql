USE sales_hub;
SELECT 
   name,
   status,
   RANK() OVER(ORDER BY name) AS position
FROM products;   
     