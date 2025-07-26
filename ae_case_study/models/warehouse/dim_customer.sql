-- staging layer vs. data warehouse layer
-- 왜 원천을 따로 정의하지 않는가?

-- source() 함수
-- 외부 데이터 소스를 참조할 때 사용
-- source.yml에 정의된 테이블만 참조 가능
-- dbt가 "이 테이블이 어디에 있는지" 알아야 함

-- ref() 함수
-- dbt 프로젝트 내의 다른 모델을 참조할 때 사용
-- dbt가 자동으로 생성한 테이블이므로 위치를 알고 있음
-- 별도 정의 불필요

WITH 
  source AS (
  SELECT
      id AS customer_id
    , company
    , last_name
    , first_name
    , email_address
    , job_title
    , business_phone
    , home_phone
    , mobile_phone
    , fax_number
    , address
    , city
    , state_province
    , zip_postal_code
    , country_region
    , web_page
    , notes
    , attachments
    , CURRENT_TIMESTAMP() AS insertion_timestamp
FROM {{ ref('stg_customer') }}
)

-- 중복 데이터 제거
, unique_source AS ( 
  SELECT 
      *
    , ROW_NUMBER() OVER(PARTITION BY customer_id) AS row_number
  FROM source
)

SELECT
    * EXCEPT(row_number)
FROM unique_source
WHERE 1=1
  AND row_number = 1