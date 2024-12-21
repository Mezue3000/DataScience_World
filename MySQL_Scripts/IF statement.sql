-- Create a new column 'status' where order date of current month will be 'active, the rest archived'
USE sales_hub;
SELECT order_id,
	   product_id,
       date,
       IF(MONTH(date) = MONTH(NOW()), 'Active', 'Archived') AS status
FROM orders;
-- WHERE IF(MONTH(date) = MONTH(NOW()), 'Active', 'Archived') = 'Active';