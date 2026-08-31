WITH order_header AS (
    SELECT *
    FROM {{ ref('b_order_header') }}
)

, order_detail AS (
    SELECT *
    FROM {{ ref('b_order_detail') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['oh.order_id', 'od.order_detail_id']) }} AS order_key
    , oh.order_id
    , od.order_detail_id
    , {{ dbt_utils.generate_surrogate_key(['oh.customer_id']) }}                  AS customer_key
    , {{ dbt_utils.generate_surrogate_key(['oh.location_id']) }}                  AS location_key
    , {{ dbt_utils.generate_surrogate_key(['oh.truck_id']) }}                     AS truck_key
    , {{ dbt_utils.generate_surrogate_key(['od.menu_item_id']) }}                 AS menu_key
    , oh.order_ts
    , DATE(oh.order_ts)                                                           AS order_date
    , oh.order_channel
    , od.quantity
    , od.unit_price
    , od.price
    , od.order_item_discount_amount
    , oh.order_amount
    , oh.order_tax_amount
    , oh.order_discount_amount
    , oh.order_total
    , oh.load_timestamp
FROM order_header oh
LEFT JOIN order_detail od
    ON oh.order_id = od.order_id
