WITH source AS (
    SELECT * FROM {{ source('northwind', 'shippers') }}
)
SELECT 
    *,
    CURRENT_TIMESTAMP() AS insertion_timestamp
FROM source 