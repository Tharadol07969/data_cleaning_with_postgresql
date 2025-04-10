  SELECT COUNT(*)
  FROM (
    SELECT * FROM cleaned_products
  ) t
  WHERE product_type IS NULL
    OR brand IS NULL
    OR weight IS NULL
    OR price IS NULL
    OR stock_location IS NULL;