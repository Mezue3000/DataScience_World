USE sales_hub;
SELECT
	 name,
     status,
     COUNT(name) 'no of products',
     MAX(price) maximum_price,
     MIN(price) minimum_price,
     COUNT(image),
     AVG(price) average_price,
     SUM(price) AS total_price
FROM products
GROUP BY name, status;