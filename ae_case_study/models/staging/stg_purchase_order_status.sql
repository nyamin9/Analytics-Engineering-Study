WITH source AS (
    SELECT * FROM {{ source('northwind', 'purchase_order_status') }}
)
SELECT 
    *,
    CURRENT_TIMESTAMP() AS insertion_timestamp
FROM source 