WITH
  source AS (
  SELECT
      purchase_order_id
    , quantity
    , unit_cost
    , date_received
    , posted_to_inventory
    , inventory_id
    , supplier_id
    , created_by
    , submitted_date
    , creation_date
    , status_id
    , expected_date
    , shipping_fee
    , taxes
    , payment_date
    , payment_amount
    , payment_method
    , purchase_orders.notes
    , approved_by
    , approved_date

    , customers.customer_id AS customer_id
    , customers.company AS customer_company
    , customers.last_name AS customer_last_name
    , customers.first_name AS customer_first_name
    , customers.email_address AS customer_email_address
    , customers.job_title AS customer_job_title
    , customers.business_phone AS customer_business_phone
    , customers.home_phone AS customer_home_phone
    , customers.mobile_phone AS customer_mobile_phone
    , customers.fax_number AS customer_fax_number
    , customers.address AS customer_address
    , customers.city AS customer_city
    , customers.state_province AS customer_state_province
    , customers.zip_postal_code AS customer_zip_postal_code
    , customers.country_region AS customer_country_region
    , customers.web_page AS customer_web_page
    , customers.notes AS customer_notes
    , customers.attachments AS customer_attachments

    , employees.employee_id
    , employees.company AS employee_company
    , employees.last_name AS employee_last_name
    , employees.first_name AS employee_first_name
    , employees.email_address AS employee_email_address
    , employees.job_title AS employee_job_title
    , employees.business_phone AS employee_business_phone
    , employees.home_phone AS employee_home_phone
    , employees.mobile_phone AS employee_mobile_phone
    , employees.fax_number AS employee_fax_number
    , employees.address AS employee_address
    , employees.city AS employee_city
    , employees.state_province AS employee_state_province
    , employees.zip_postal_code AS employee_zip_postal_code
    , employees.country_region AS employee_country_region
    , employees.web_page AS employee_web_page
    , employees.notes AS employee_notes
    , employees.attachments AS employee_attachments

    , products.product_id
    , products.product_code
    , products.product_name
    , products.description
    , products.supplier_company
    , products.standard_cost
    , products.list_price
    , products.reorder_level
    , products.target_level
    , products.quantity_per_unit
    , products.discontinued
    , products.minimum_reorder_quantity
    , products.category

    , CURRENT_TIMESTAMP() AS insertion_timestamp
  FROM {{ ref('fact_purchase_order') }} AS purchase_orders
  LEFT JOIN {{ ref('dim_customer') }} AS customers
    ON purchase_orders.customer_id = customers.customer_id
  LEFT JOIN {{ ref('dim_employee') }} AS employees
    ON purchase_orders.employee_id = employees.employee_id
  LEFT JOIN {{ ref('dim_product') }} AS products
    ON purchase_orders.product_id = products.product_id
)

SELECT
    *
FROM source