DROP DATABASE IF EXISTS thrust_bank;
CREATE DATABASE IF NOT EXISTS thrust_bank;

USE thrust_bank;

DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS transfer_accounts;
DROP TABLE IF EXISTS cards;

DROP TABLE IF EXISTS customers;
CREATE TABLE IF NOT EXISTS customers(
      customer_id   INT PRIMARY KEY AUTO_INCREMENT,
      first_name    VARCHAR(50) NOT NULL,
      middle_name   VARCHAR(50),
      surname       VARCHAR(50) NOT NULL,
      birth_date    DATE NOT NULL,
      email         VARCHAR(50) NOT NULL UNIQUE,
      phone_number  VARCHAR(45) NOT NULL UNIQUE,
      address       VARCHAR(75) NOT NULL
);

CREATE TABLE IF NOT EXISTS accounts(
      account_id     INT PRIMARY KEY AUTO_INCREMENT,
      account_type   VARCHAR(15) NOT NULL CHECK(account_type IN ('savings', 'current', 'domicilary', 'salary')),
      account_number INT NOT NULL,
      balance        DECIMAL(12, 2) DEFAULT(0),
      customer_id    INT NOT NULL,
      FOREIGN KEY(customer_id)
      REFERENCES customers(customer_id)
      ON UPDATE CASCADE
      ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS transactions(
       transaction_id       INT PRIMARY KEY AUTO_INCREMENT,
       transaction_type     VARCHAR(15) NOT NULL CHECK(transaction_type IN ('deposite', 'withdrawal', 'transfer', 'payment', 'credit', 'foreign')),
       transaction_date     DATETIME NOT NULL DEFAULT NOW(),
       transaction_amount   DECIMAL(12, 2) CHECK(transaction_amount > 0),
       transation_reference VARCHAR(50),
       transaction_status   VARCHAR(30) NOT NULL,
       account_id           INT NOT NULL,
       FOREIGN KEY(account_id)
       REFERENCES accounts(account_id)
       ON UPDATE CASCADE
       ON DELETE NO ACTION
);

DROP TABLE IF EXISTS transfers;
CREATE TABLE IF NOT EXISTS transfers(
       transfer_id        INT PRIMARY KEY AUTO_INCREMENT,
       transfer_date      DATETIME NOT NULL DEFAULT NOW(),
       amount             DECIMAL(12, 2) NOT NULL CHECK(amount > 0),
       sender_name        VARCHAR(50) NOT NULL,
       beneficiary_name   VARCHAR(50) NOT NULL,
       description        VARCHAR(125)
       sender_transaction_id INT NOT NULL UNIQUE,
       receiver_transaction_id INT NOT NULL UNIQUE,
       FOREIGN KEY (sender_transaction_id) REFERENCES transaction(transaction_id) ON DELETE CASCADE,
       FOREIGN KEY (receiver_transaction_id) REFERENCES transaction(transaction_id) ON DELETE CASCADE
);



CREATE TABLE IF NOT EXISTS cards(
       card_id           INT PRIMARY KEY AUTO_INCREMENT,
       card_type         VARCHAR(15) NOT NULL CHECK(card_type IN('mastercard', 'visa', 'verve', 'gift card')),
       card_number       INT NOT NULL UNIQUE,
       expiration_date   DATE NOT NULL,
       is_active         BOOL DEFAULT True
       account_id        INT NOT NULL,
       FOREIGN KEY(account_id)
       REFERENCES accounts(account_id)
       ON UPDATE CASCADE
       ON DELETE NO ACTION
);

