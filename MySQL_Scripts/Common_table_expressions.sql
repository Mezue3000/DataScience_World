WITH total_prize AS(
   SELECT 
      name,
      MAX(price) AS total_price
  FROM products
  GROUP BY name
 -- HAVING product_id IN (2, 3, 7, 5, 6)
)
SELECT *
FROM total_prize;
