WITH source AS (
    SELECT * FROM {{ source('northwind', 'orders_tax_status') }}
)
SELECT 
    *,
    CURRENT_TIMESTAMP() AS insertion_timestamp
FROM source 