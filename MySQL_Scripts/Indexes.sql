-- Create index on customers table using first and last name
USE sales_hub;
CREATE INDEX idx_full_name ON customers(first_name, last_name); 