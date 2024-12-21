-- Create a stored procedures to get all the male customers

DELIMITER $$
CREATE PROCEDURE get_customers()
BEGIN
   SELECT *
   FROM customers
   WHERE gender = 'm';
END$$
DELIMITER ;

CALL get_customers();