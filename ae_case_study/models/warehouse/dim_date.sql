SELECT
	FORMAT_DATE('%F', date_array) AS id
  , date_array AS full_date
  , EXTRACT(YEAR FROM date_array) AS year
  , EXTRACT(MONTH FROM date_array) AS month
  , EXTRACT(WEEK FROM date_array) AS year_week
  , EXTRACT(YEAR FROM date_array) AS fiscal_year
  , FORMAT_DATE('%Q', date_array) AS fiscal_qtr
  , FORMAT_DATE('%B', date_array) AS month_name
  , FORMAT_DATE('%w', date_array) AS week_day
  , FORMAT_DATE('%A', date_array) AS day_name
  , CASE WHEN FORMAT_DATE('%w', date_array) IN ('Sunday', 'Saturday') THEN 0 ELSE 1 END AS is_weekday
FROM (SELECT * FROM UNNEST(GENERATE_DATE_ARRAY('2024-01-01', '2050-01-01', INTERVAL 1 DAY)) AS date_array)