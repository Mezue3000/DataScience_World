-- join customers table with products table

USE sales_hub;
SELECT *
FROM customers c
CROSS JOIN products p
ORDER BY c.first_name;