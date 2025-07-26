WITH source AS (
    SELECT * FROM {{ source('northwind', 'employees') }}
)
SELECT 
    *,
    CURRENT_TIMESTAMP() AS insertion_timestamp
FROM source 