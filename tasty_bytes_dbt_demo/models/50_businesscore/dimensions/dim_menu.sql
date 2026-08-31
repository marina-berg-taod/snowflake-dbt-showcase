WITH base AS (
    SELECT *
    FROM {{ ref('b_menu') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['menu_id']) }} AS menu_key
    , menu_id
    , menu_type_id
    , menu_type
    , truck_brand_name
    , menu_item_id
    , menu_item_name
    , item_category
    , cost_of_goods_usd
    , load_timestamp
FROM base
