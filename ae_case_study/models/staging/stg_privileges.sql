WITH source AS (
    SELECT * FROM {{ source('northwind', 'privileges') }}
)
SELECT 
    *,
    CURRENT_TIMESTAMP() AS insertion_timestamp
FROM source 