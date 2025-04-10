CREATE TABLE public.products (
  product_id           INTEGER PRIMARY KEY,
  product_type         TEXT,
  brand                TEXT,
  weight               TEXT,
  price                NUMERIC,
  average_units_sold   INTEGER,
  year_added           INTEGER,
  stock_location       TEXT
);
ALTER TABLE public.products OWNER TO postgres;