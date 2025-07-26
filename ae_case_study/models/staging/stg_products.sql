WITH source AS (
    SELECT
        SAFE_CAST(supplier_ids AS INT64) AS supplier_id
      , * EXCEPT(supplier_ids)
    FROM {{ source('northwind', 'products') }}
    WHERE 1=1
      AND supplier_ids NOT LIKE '%;%'
)
SELECT 
    *,
    CURRENT_TIMESTAMP() AS insertion_timestamp
FROM source 