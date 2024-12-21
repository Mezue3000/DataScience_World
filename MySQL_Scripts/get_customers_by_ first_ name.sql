-- Create a procedure with parameter of first name

USE sales_hub;
DELIMITER $$
CREATE PROCEDURE get_customer_by_first_name(first_name  varchar(25))
BEGIN
    SELECT * FROM customers c
    WHERE c.first_name = first_name ;
END$$
DELIMITER ;

CALL get_customer_by_first_name('linda');