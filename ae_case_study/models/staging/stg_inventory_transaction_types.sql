WITH source AS (
    SELECT * FROM {{ source('northwind', 'inventory_transaction_types') }}
)
SELECT 
    *,
    CURRENT_TIMESTAMP() AS insertion_timestamp
FROM source 