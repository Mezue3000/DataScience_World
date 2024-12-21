-- Vectorize the product names with alieus 'vector store'

USE sales_hub;
SELECT 
    product_id,
    name,
    price,
    status,
    CASE
       WHEN name = 'shirt' THEN 0
       WHEN name = 'necklace' THEN 1
       WHEN name = 'cap' THEN 2
       WHEN name = 'trouser' THEN 3
       WHEN name = 'singlet' THEN 4
       WHEN name = 'shoe' THEN 5
       ELSE 6
	END AS vector_store  
FROM products;    