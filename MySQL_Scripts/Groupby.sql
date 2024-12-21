USE sales_hub;
SELECT SUM(age) AS aged, gender, first_name
FROM customers
GROUP BY gender, first_name
HAVING first_name ='obiora';



