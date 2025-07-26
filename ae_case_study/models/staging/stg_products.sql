WITH source AS (
    SELECT * FROM {{ source('northwind', 'products') }}
)
SELECT 
    *,
    CURRENT_TIMESTAMP() AS insertion_timestamp
FROM source 