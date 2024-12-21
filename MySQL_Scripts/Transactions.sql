USE sales_hub;
START TRANSACTION;
INSERT INTO orders(date, customer_id, product_id)
VALUES('2024-12-18', 3, 5);

INSERT INTO invoices(amount, quantity, date, customer_id, product_id, order_id)
VALUES(480, 3, '2024-12-18', 2, 3, LAST_INSERT_ID());
COMMIT;