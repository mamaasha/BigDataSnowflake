SELECT 'mock_data' as source_table, COUNT(*) as row_count FROM mock_data
UNION ALL
SELECT 'fact_sales', COUNT(*) FROM fact_sales
UNION ALL
SELECT 'dim_customer', COUNT(*) FROM dim_customer
UNION ALL
SELECT 'dim_seller', COUNT(*) FROM dim_seller
UNION ALL
SELECT 'dim_store', COUNT(*) FROM dim_store
UNION ALL
SELECT 'dim_supplier', COUNT(*) FROM dim_supplier
UNION ALL
SELECT 'dim_product', COUNT(*) FROM dim_product
UNION ALL
SELECT 'dim_brand', COUNT(*) FROM dim_brand
UNION ALL
SELECT 'dim_color', COUNT(*) FROM dim_color
UNION ALL
SELECT 'dim_size', COUNT(*) FROM dim_size
UNION ALL
SELECT 'dim_category', COUNT(*) FROM dim_category;

SELECT
    SUM(CASE WHEN brand_id IS NULL THEN 1 ELSE 0 END) as null_brand_ids,
    SUM(CASE WHEN color_id IS NULL THEN 1 ELSE 0 END) as null_color_ids,
    SUM(CASE WHEN size_id IS NULL THEN 1 ELSE 0 END) as null_size_ids,
    SUM(CASE WHEN category_id IS NULL THEN 1 ELSE 0 END) as null_category_ids
FROM dim_product;

SELECT SUM(sale_total_price) as total_revenue_mock_data FROM mock_data;
SELECT SUM(sale_total_price) as total_revenue_fact_sales FROM fact_sales;

SELECT SUM(sale_quantity) as total_quantity_mock_data FROM mock_data;
SELECT SUM(sale_quantity) as total_quantity_fact_sales FROM fact_sales;
