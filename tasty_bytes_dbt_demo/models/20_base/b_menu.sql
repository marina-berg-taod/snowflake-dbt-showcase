WITH source AS (
    SELECT *
    FROM {{ ref('hl_tb_101_menu') }}
    WHERE dbt_valid_to IS NULL
)

SELECT
    menu_id
    , menu_type_id
    , menu_type
    , truck_brand_name
    , menu_item_id
    , menu_item_name
    , item_category
    , cost_of_goods_usd
    , updated_at         AS load_timestamp
    , {{ add_meta_columns(source_name='tb_101') }}
FROM source
