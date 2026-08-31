WITH fct_orders AS (
    SELECT *
    FROM {{ ref('fct_orders') }}
)

, dim_location AS (
    SELECT *
    FROM {{ ref('dim_location') }}
)

, dim_date AS (
    SELECT *
    FROM {{ ref('dim_date') }}
)

SELECT
    d.calendar_year
    , d.calendar_month
    , d.month_name
    , l.country_name
    , l.region
    , l.city_name
    , l.location_name
    , COUNT(DISTINCT f.order_id)        AS number_of_orders
    , SUM(f.quantity)                   AS total_quantity_sold
    , SUM(f.price)                      AS total_revenue
    , SUM(f.order_item_discount_amount) AS total_discount_amount
    , AVG(f.price)                      AS avg_order_line_value
FROM fct_orders f
LEFT JOIN dim_location l
    ON f.location_key = l.location_key
LEFT JOIN dim_date d
    ON f.order_date = d.calendar_date
GROUP BY
    d.calendar_year
    , d.calendar_month
    , d.month_name
    , l.country_name
    , l.region
    , l.city_name
    , l.location_name
