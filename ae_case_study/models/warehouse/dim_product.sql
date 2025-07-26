WITH 
  source AS (
  SELECT
      products.id AS product_id
    , products.product_code
    , products.product_name
    , products.description
    , suppliers.company AS supplier_company
    , products.standard_cost
    , products.list_price
    , products.reorder_level
    , products.target_level
    , products.quantity_per_unit
    , products.discontinued
    , products.minimum_reorder_quantity
    , products.category
    , CURRENT_TIMESTAMP() AS insertion_timestamp
FROM {{ ref('stg_products') }} AS products
LEFT JOIN {{ ref('stg_suppliers') }} AS suppliers
  ON products.supplier_id = suppliers.id
)

-- 중복 데이터 제거
, unique_source AS ( 
  SELECT 
      *
    , ROW_NUMBER() OVER(PARTITION BY product_id) AS row_number
  FROM source
)

SELECT
    * EXCEPT(row_number)
FROM unique_source
WHERE 1=1
  AND row_number = 1