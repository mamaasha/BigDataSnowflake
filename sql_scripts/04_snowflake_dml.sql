
INSERT INTO dim_color (color_name)
SELECT DISTINCT product_color
FROM mock_data
WHERE product_color IS NOT NULL
ON CONFLICT (color_name) DO NOTHING;

INSERT INTO dim_size (size_name)
SELECT DISTINCT product_size
FROM mock_data
WHERE product_size IS NOT NULL
ON CONFLICT (size_name) DO NOTHING;

INSERT INTO dim_brand (brand_name)
SELECT DISTINCT product_brand
FROM mock_data
WHERE product_brand IS NOT NULL
ON CONFLICT (brand_name) DO NOTHING;

INSERT INTO dim_category (category_name)
SELECT DISTINCT product_category
FROM mock_data
WHERE product_category IS NOT NULL
ON CONFLICT (category_name) DO NOTHING;


INSERT INTO dim_customer (first_name, last_name, age, email, country, postal_code, pet_type, pet_name, pet_breed)
SELECT DISTINCT
    customer_first_name,
    customer_last_name,
    customer_age,
    customer_email,
    customer_country,
    customer_postal_code,
    customer_pet_type,
    customer_pet_name,
    customer_pet_breed
FROM mock_data
WHERE customer_email IS NOT NULL 
ON CONFLICT (email) DO NOTHING;


INSERT INTO dim_seller (first_name, last_name, email, country, postal_code)
SELECT DISTINCT
    seller_first_name,
    seller_last_name,
    seller_email,
    seller_country,
    seller_postal_code
FROM mock_data
WHERE seller_email IS NOT NULL 
ON CONFLICT (email) DO NOTHING;


INSERT INTO dim_supplier (name, contact, email, phone, address, city, country)
SELECT DISTINCT
    supplier_name,
    supplier_contact,
    supplier_email,
    supplier_phone,
    supplier_address,
    supplier_city,
    supplier_country
FROM mock_data
WHERE supplier_email IS NOT NULL 
ON CONFLICT (email) DO NOTHING;


INSERT INTO dim_store (name, location, city, state, country, phone, email)
SELECT DISTINCT
    store_name,
    store_location,
    store_city,
    store_state,
    store_country,
    store_phone,
    store_email
FROM mock_data
WHERE store_name IS NOT NULL AND store_email IS NOT NULL; 


INSERT INTO dim_product (
    product_name,
    brand_id,
    color_id,
    size_id,
    category_id,
    product_description,
    product_rating,
    product_reviews,
    product_price,
    product_weight,
    product_material,
    product_release_date,
    product_expiry_date
)
SELECT DISTINCT
    md.product_name,
    db.brand_id,
    dco.color_id,
    ds.size_id,
    dca.category_id,
    md.product_description,
    md.product_rating,
    md.product_reviews,
    md.product_price,
    md.product_weight,
    md.product_material,
    md.product_release_date, 
    md.product_expiry_date   
FROM mock_data md
LEFT JOIN dim_brand db ON md.product_brand = db.brand_name
LEFT JOIN dim_color dco ON md.product_color = dco.color_name
LEFT JOIN dim_size ds ON md.product_size = ds.size_name
LEFT JOIN dim_category dca ON md.product_category = dca.category_name
WHERE md.product_name IS NOT NULL;


INSERT INTO fact_sales (
    sale_date,
    customer_id,
    seller_id,
    product_id,
    store_id,
    supplier_id,
    sale_quantity,
    sale_total_price
)
SELECT
    md.sale_date, 
    dc.customer_id,
    dsl.seller_id,
    dp.product_id,
    dst.store_id,
    dsp.supplier_id,
    md.sale_quantity,
    md.sale_total_price
FROM mock_data md

JOIN dim_customer dc ON md.customer_email = dc.email
JOIN dim_seller dsl ON md.seller_email = dsl.email
JOIN dim_store dst ON md.store_email = dst.email 
JOIN dim_supplier dsp ON md.supplier_email = dsp.email
JOIN dim_category dcat_lookup ON md.product_category = dcat_lookup.category_name
JOIN dim_brand dbr_lookup ON md.product_brand = dbr_lookup.brand_name
JOIN dim_color dcol_lookup ON md.product_color = dcol_lookup.color_name
JOIN dim_size dsiz_lookup ON md.product_size = dsiz_lookup.size_name
JOIN dim_product dp ON
    dp.product_name = md.product_name AND
    dp.category_id = dcat_lookup.category_id AND
    dp.brand_id = dbr_lookup.brand_id AND
    dp.color_id = dcol_lookup.color_id AND
    dp.size_id = dsiz_lookup.size_id AND
    dp.product_price = md.product_price AND
    dp.product_description = md.product_description AND
    dp.product_rating = md.product_rating AND
    dp.product_reviews = md.product_reviews AND
    dp.product_weight = md.product_weight AND
    dp.product_material = md.product_material AND
    dp.product_release_date = md.product_release_date AND
    dp.product_expiry_date = md.product_expiry_date
WHERE
    md.id IS NOT NULL; 