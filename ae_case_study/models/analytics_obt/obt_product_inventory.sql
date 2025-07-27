WITH
  source AS (
  SELECT
      inventory.inventory_id
    , inventory.transaction_type
    , inventory.transaction_created_date
    , inventory.transaction_modified_date
    , inventory.product_id AS product_id_in_inventory
    , inventory.quantity
    , inventory.purchase_order_id
    , inventory.customer_order_id
    
    , products.product_id
    , products.product_code
    , products.product_name
    , products.description
    , products.supplier_company
    , products.standard_cost
    , products.list_price
    , products.reorder_level
    , products.target_level
    , products.quantity_per_unit
    , products.discontinued
    , products.minimum_reorder_quantity
    , products.category
    
    , CURRENT_TIMESTAMP() AS insertion_timestamp
  FROM {{ ref('fact_inventory') }} AS inventory
  LEFT JOIN {{ ref('dim_product') }} AS products
    ON inventory.product_id = products.product_id 
)

SELECT
    *
FROM source