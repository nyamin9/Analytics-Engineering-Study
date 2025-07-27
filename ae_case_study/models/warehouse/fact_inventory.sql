{{ config(
    partition_by = {
        "field": "transaction_created_date",
        "data_type": "date"
    }
)}}

WITH
  source AS (
  SELECT
      trans.id AS inventory_id
    , trans.transaction_type
    , types.type_name
    , DATE(trans.transaction_created_date) AS transaction_created_date
    , trans.transaction_modified_date
    , trans.product_id
    , trans.quantity
    , trans.purchase_order_id
    , trans.customer_order_id
    , CURRENT_TIMESTAMP() AS insertion_timestamp
  FROM {{ ref('stg_inventory_transactions') }} AS trans
  LEFT JOIN {{ ref('stg_inventory_transaction_types') }} AS types
    ON trans.transaction_type = types.id
)

, unique_source AS (
  SELECT
      *
    , ROW_NUMBER() OVER(PARTITION BY inventory_id) AS row_number
  FROM source
)

SELECT
    * EXCEPT(row_number)
FROM unique_source
WHERE 1=1
  AND row_number = 1