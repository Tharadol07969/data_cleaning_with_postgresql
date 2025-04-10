WITH clean AS (
  SELECT
    product_id,
    COALESCE(NULLIF(product_type, ''), 'Unknown')       AS product_type,
    COALESCE(NULLIF(brand, '-'), 'Unknown')            AS brand,
    NULLIF(SPLIT_PART(weight, ' ', 1), '')::NUMERIC    AS weight,
    price,
    COALESCE(average_units_sold, 0)                    AS average_units_sold,
    COALESCE(year_added, 2022)                         AS year_added,
    UPPER(COALESCE(stock_location, 'Unknown'))         AS stock_location
  FROM products
),
med AS (
  SELECT
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY weight) AS median_weight,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price)  AS median_price
  FROM clean
  WHERE weight IS NOT NULL AND price IS NOT NULL
)

SELECT
  c.product_id,
  c.product_type,
  c.brand,
  ROUND(COALESCE(c.weight, m.median_weight), 2) AS weight,
  ROUND(COALESCE(c.price,  m.median_price),  2) AS price,
  c.average_units_sold,
  c.year_added,
  c.stock_location
FROM clean c
CROSS JOIN med m;