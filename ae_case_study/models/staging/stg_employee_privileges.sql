WITH source AS (
    SELECT * FROM {{ source('northwind', 'employee_privileges') }}
)
SELECT 
    *,
    CURRENT_TIMESTAMP() AS insertion_timestamp
FROM source