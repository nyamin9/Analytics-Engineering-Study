{{ config(
    partition_by = {
        "field": "creation_date",
        "data_type": "date"
    }
)}}

/*
customer_id를 가져오기 위해서, orders 테이블을 사용해야 함
하지만 orders 테이블은 purchase_orders, purchase_order_details과 직접적 관계가 없음
따라서 purchase_order_details과 products, order_details 테이블을 사용해서 간접적으로 연결함
*/
WITH
  source AS (
  SELECT
      customers.id AS customer_id
    , employees.id AS employee_id
    , purchase_order_details.purchase_order_id
    , products.id AS product_id
    , purchase_order_details.quantity
    , purchase_order_details.unit_cost
    , purchase_order_details.date_received
    , purchase_order_details.posted_to_inventory
    , purchase_order_details.inventory_id
    , purchase_orders.supplier_id
    , purchase_orders.created_by
    , purchase_orders.submitted_date
    , DATE(purchase_orders.creation_date) AS creation_date
    , purchase_orders.status_id
    , purchase_orders.expected_date
    , purchase_orders.shipping_fee
    , purchase_orders.taxes
    , purchase_orders.payment_date
    , purchase_orders.payment_amount
    , purchase_orders.payment_method
    , purchase_orders.notes
    , purchase_orders.approved_by
    , purchase_orders.approved_date
    , CURRENT_TIMESTAMP() AS insertion_timestamp
  FROM {{ ref('stg_purchase_orders') }} AS purchase_orders
  LEFT JOIN {{ ref('stg_purchase_order_details') }} AS purchase_order_details
    ON purchase_orders.id = purchase_order_details.purchase_order_id
  LEFT JOIN {{ ref('stg_products') }} AS products
    ON purchase_order_details.product_id = products.id
  LEFT JOIN {{ ref('stg_order_details') }} AS order_details
    ON products.id = order_details.product_id
  LEFT JOIN {{ ref('stg_orders')}} AS orders
    ON order_details.order_id = orders.id
  LEFT JOIN {{ ref('stg_employees')}} AS employees
    ON purchase_orders.created_by = employees.id
  LEFT JOIN {{ ref('stg_customer')}} AS customers
    ON orders.customer_id = customers.id
)

, unique_source AS (
  SELECT
      *
    , ROW_NUMBER() OVER(PARTITION BY customer_id, employee_id, purchase_order_id, product_id, inventory_id, supplier_id, creation_date) AS row_number
  FROM source
)

SELECT
    * EXCEPT(row_number)
FROM unique_source
WHERE 1=1
  AND row_number = 1