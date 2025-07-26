WITH source AS (
    SELECT * FROM {{ source('northwind', 'invoices') }}
)
SELECT 
    *,
    CURRENT_TIMESTAMP() AS insertion_timestamp
FROM source 