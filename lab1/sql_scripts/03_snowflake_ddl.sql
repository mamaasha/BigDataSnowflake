CREATE TABLE dim_color (
    color_id SERIAL PRIMARY KEY,
    color_name TEXT UNIQUE
);

CREATE TABLE dim_size (
    size_id SERIAL PRIMARY KEY,
    size_name TEXT UNIQUE
);

CREATE TABLE dim_brand (
    brand_id SERIAL PRIMARY KEY,
    brand_name TEXT UNIQUE
);

CREATE TABLE dim_category (
    category_id SERIAL PRIMARY KEY,
    category_name TEXT UNIQUE
);

CREATE TABLE dim_product (
    product_id SERIAL PRIMARY KEY,
    product_name TEXT,
    brand_id INTEGER REFERENCES dim_brand(brand_id),
    color_id INTEGER REFERENCES dim_color(color_id),
    size_id INTEGER REFERENCES dim_size(size_id),
    category_id INTEGER REFERENCES dim_category(category_id),
    product_description TEXT,
    product_rating NUMERIC,
    product_reviews INTEGER,
    product_price NUMERIC,
    product_weight NUMERIC,
    product_material TEXT,
    product_release_date TEXT,
    product_expiry_date TEXT
);

CREATE TABLE dim_customer (
    customer_id SERIAL PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    age INTEGER,
    email TEXT UNIQUE,
    country TEXT,
    postal_code TEXT,
    pet_type TEXT,
    pet_name TEXT,
    pet_breed TEXT
);

CREATE TABLE dim_seller (
    seller_id SERIAL PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email TEXT UNIQUE,
    country TEXT,
    postal_code TEXT
);

CREATE TABLE dim_supplier (
    supplier_id SERIAL PRIMARY KEY,
    name TEXT,
    contact TEXT,
    email TEXT UNIQUE,
    phone TEXT,
    address TEXT,
    city TEXT,
    country TEXT
);

CREATE TABLE dim_store (
    store_id SERIAL PRIMARY KEY,
    name TEXT,
    location TEXT,
    city TEXT,
    state TEXT,
    country TEXT,
    phone TEXT,
    email TEXT
);

CREATE TABLE fact_sales (
    sale_id SERIAL PRIMARY KEY,
    sale_date TEXT,
    customer_id INTEGER REFERENCES dim_customer(customer_id),
    seller_id INTEGER REFERENCES dim_seller(seller_id),
    product_id INTEGER REFERENCES dim_product(product_id),
    store_id INTEGER REFERENCES dim_store(store_id),
    supplier_id INTEGER REFERENCES dim_supplier(supplier_id),
    sale_quantity INTEGER,
    sale_total_price NUMERIC
);
