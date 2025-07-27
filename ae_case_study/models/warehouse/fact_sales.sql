{{ config(
    partition_by = {
        "field": "order_date",
        "data_type": "date"
    }
)}}

WITH
  source AS (
  SELECT
      details.order_id
    , details.product_id
    , orders.customer_id
    , orders.employee_id
    , orders.shipper_id
    , details.quantity
    , details.unit_price
    , details.discount
    , details.status_id
    , details.date_allocated
    , details.purchase_order_id
    , details.inventory_id
    , DATE(orders.order_date) AS order_date
    , orders.shipped_date
    , orders.paid_date
    , CURRENT_TIMESTAMP() AS insertion_timestamp
  FROM {{ ref('stg_orders') }} AS orders
  LEFT JOIN {{ ref('stg_order_details') }} AS details
    ON details.order_id = orders.id
  WHERE 1=1 
    AND details.order_id IS NOT NULL
)

, unique_source AS (
  SELECT
      *
    , ROW_NUMBER() OVER(PARTITION BY order_id, product_id, customer_id, employee_id, shipper_id, purchase_order_id, order_date) AS row_number
  FROM source
)

SELECT
    * EXCEPT(row_number)
FROM unique_source
WHERE 1=1
  AND row_number = 1