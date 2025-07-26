-- 일반적인 작성 방법
/*
SELECT
    *
FROM `dl_northwind.customer`
*/

-- 하지만 dbt에서는 macro를 작성하여 jinja template으로 작성
-- 이 경우 지속적으로 사용되는 쿼리를 작성할 수 있음
WITH source AS (
    SELECT * FROM {{ source('northwind', 'customer') }}
)
SELECT 
    *,
    CURRENT_TIMESTAMP() AS insertion_timestamp
FROM source