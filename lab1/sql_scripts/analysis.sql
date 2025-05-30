SELECT COUNT(*) FROM mock_data;

SELECT DISTINCT customer_country FROM mock_data;

SELECT DISTINCT product_category FROM mock_data;

SELECT COUNT(*) FROM mock_data WHERE product_price > 5;

SELECT COUNT(DISTINCT customer_email) FROM mock_data;

SELECT COUNT(DISTINCT product_name) FROM mock_data;

SELECT COUNT(DISTINCT store_name) FROM mock_data;

SELECT DISTINCT customer_country FROM mock_data;
SELECT DISTINCT seller_country FROM mock_data;
SELECT DISTINCT store_country FROM mock_data;
SELECT DISTINCT supplier_country FROM mock_data;


SELECT customer_email, product_name, sale_date, COUNT(*)
FROM mock_data
GROUP BY customer_email, product_name, sale_date
HAVING COUNT(*) > 1;

SELECT COUNT(DISTINCT seller_email) FROM mock_data;

SELECT COUNT(DISTINCT supplier_email) FROM mock_data;

SELECT DISTINCT product_size FROM mock_data;
SELECT DISTINCT product_color FROM mock_data;
SELECT DISTINCT product_brand FROM mock_data;


SELECT COUNT(DISTINCT customer_pet_name) FROM mock_data;

