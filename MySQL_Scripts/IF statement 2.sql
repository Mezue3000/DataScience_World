USE sales_hub;
SELECT
     first_name,
     last_name,
     email,
     age,
     gender,
     IF(gender = 'm', 1, 0) AS numeric_gender
FROM customers;
