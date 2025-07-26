WITH source AS (
    SELECT * FROM {{ source('northwind', 'suppliers') }}
)
SELECT 
    *,
    CURRENT_TIMESTAMP() AS insertion_timestamp
FROM source 