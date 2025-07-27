WITH
  source AS (
  SELECT
      customers.customer_id
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

    , products.product_id AS product_id
    , products.product_code AS product_code
    , products.product_name AS product_name
    , products.description AS product_description
    , products.supplier_company AS product_supplier_company
    , products.standard_cost AS product_standard_cost
    , products.list_price AS product_list_price
    , products.reorder_level AS product_reorder_level
    , products.target_level AS product_target_level
    , products.quantity_per_unit AS product_quantity_per_unit
    , products.discontinued AS product_discontinued
    , products.minimum_reorder_quantity AS product_minimum_reorder_quantity
    , products.category AS product_category

    , sales.order_id
    , sales.shipper_id
    , sales.quantity
    , sales.unit_price
    , sales.discount
    , sales.status_id
    , sales.date_allocated
    , sales.purchase_order_id
    , sales.inventory_id
    , sales.order_date
    , sales.shipped_date
    , sales.paid_date

    , CURRENT_TIMESTAMP() AS insert_timestamp
  FROM {{ ref('fact_sales') }} AS sales
  LEFT JOIN {{ ref('dim_customer') }} AS customers
    ON sales.customer_id = customers.customer_id
  LEFT JOIN {{ ref('dim_employee') }} AS employees
    ON sales.employee_id = employees.employee_id
  LEFT JOIN {{ ref('dim_product') }} AS products
    ON sales.product_id = products.product_id
)

SELECT 
    *
FROM source