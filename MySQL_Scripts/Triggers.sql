-- Create trigger than executes after we insert a record

USE sales_hub;
DELIMITER $$
CREATE TRIGGER generate_after_insert
     AFTER INSERT ON invoices
     FOR EACH ROW
BEGIN
   UPDATE products
   SET  price = price + NEW.amount
   WHERE product_id = NEW.product_id;
END$$
DELIMITER ;     


INSERT INTO invoices(amount, quantity, date, customer_id, product_id, order_id)
VALUES(100, 3, '2024-12-18', 2, 4, 1);
