WITH source AS (
    SELECT * FROM {{ source('northwind', 'orders') }}
)
SELECT 
    *,
    CURRENT_TIMESTAMP() AS insertion_timestamp
FROM source 