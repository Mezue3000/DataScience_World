DROP DATABASE IF EXISTS sales_hub;
CREATE DATABASE IF NOT EXISTS sales_hub;
USE sales_hub;

DROP TABLE IF EXISTS invoces;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

DROP TABLE IF EXISTS products;
CREATE TABLE IF NOT EXISTS products(
     product_id  INT PRIMARY KEY AUTO_INCREMENT,
     name        VARCHAR(25) NOT NULL,
     image       BLOB,
     price       DECIMAL(9,2) NOT NULL,
     status      VARCHAR(15) NOT NULL
);


CREATE TABLE IF NOT EXISTS customers(
     customer_id  INT PRIMARY KEY AUTO_INCREMENT,
     first_name   VARCHAR(25) NOT NULL,
     last_name    VARCHAR(25) NOT NULL,
     email        VARCHAR(50) NOT NULL UNIQUE,
     age          TINYINT NOT NULL,
                  CHECK(age>=18),
     address      VARCHAR(125) NOT NULL,
     gender       CHAR(1) NOT NULL
);

CREATE TABLE IF NOT EXISTS orders(
     order_id    INT PRIMARY KEY AUTO_INCREMENT,
     date        DATE NOT NULL DEFAULT NOW(),
     customer_id INT NOT NULL,
     product_id  INT NOT NULL,
     FOREIGN KEY fk_orders_customers(customer_id)
     REFERENCES customers(customer_id)
     ON UPDATE CASCADE
     ON DELETE NO ACTION,
     
     FOREIGN KEY fk_orders_products(product_id)
     REFERENCES products(product_id)
     ON UPDATE CASCADE
     ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS invoices(
     invoice_id   INT PRIMARY KEY AUTO_INCREMENT,
     amount       DECIMAL(9,2) NOT NULL,
     quantity     INT NOT NULL,
     date         DATE,
     customer_id  INT NOT NULL,
     product_id   INT NOT NULL,
     order_id     INT NOT NULL,
     FOREIGN KEY  fk_invoices_customers(customer_id)
     REFERENCES customers(customer_id)
     ON UPDATE CASCADE
     ON DELETE NO ACTION,
     
     FOREIGN KEY  fk_invoices_products(product_id)
     REFERENCES products(product_id)
     ON UPDATE CASCADE
     ON DELETE NO ACTION,
     
     FOREIGN KEY  fk_invoices_orders(order_id)
     REFERENCES orders(order_id)
     ON UPDATE CASCADE
     ON DELETE CASCADE
);

INSERT INTO products(name, price, status)
VALUES('singlet', 350.55, 'available'),
      ('shirt', 400, 'available'),
      ('trouser', 1000.95, 'unavailable'),
      ('shoe', 1500.35, 'available'),
      ('watch', 2500, 'unavailable'),
      ('necklace', 750.95, 'available'),
      ('cap', 300.95, 'unavailable');
      
INSERT INTO customers(first_name, last_name, email, age, address, gender)
VALUES('linda', 'grenny', 'linda@gmail.com', 21, 'house 15 quebec', 'f'),
       ('james', 'paul', 'james@yahoo.com', 30, 'no 4 seha toronto', 'm'),
       ('jennifer', 'okono', 'okono@gmail.com', 18, 'km_19 vancouver', 'f'),
       ('christy', 'fema', 'fema@yahoo.com', 24, 'no 8 johnson utah', 'f'),
       ('john', 'penny', 'penny@yahoo.com', 50, 'house 15 golwat ohio', 'm'),
       ('joshua', 'maggy', 'joshua@gmail.com', 68, 'no 55 godson quebec', 'm'),
       ('magreth', 'hope', 'hope@yahoo.com', 45, 'km_21 gomson texas', 'f');
       
INSERT INTO orders(date, customer_id, product_id)
VALUES('2022-04-28', 2, 1),
       ('2022-08-14', 3, 4),
       ('2022-01-30', 5, 6),
       ('2022-05-18', 7, 7),
       ('2022-12-04', 6, 3),
       ('2022-01-05', 1, 5),
       ('2023-09-10', 2, 4);
 
 INSERT INTO invoices(amount, quantity, date, customer_id, product_id, order_id)
 VALUES(360, 2, '2022-04-30', 2, 1, 1),
       (1500, 1, '2022-08-18', 3, 4, 2),
       (1500, 3, '2022-02-05', 2, 4, 3),
       (300.95, 4, '2022-05-21', 7, 7, 1),
       (1000.95, 5, '2022-12-07', 6, 3, 5),
       (360, 1, '2022-01-06', 6, 1, 5),
       (400, 4, '2022-09-12', 7, 2, 4);
 
 
