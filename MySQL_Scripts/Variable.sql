SET @target_gender = (
    SELECT gender
    FROM customers
    WHERE first_name = 'obiora'
);

UPDATE customers
SET age = age + 10
WHERE gender = @target_gender;