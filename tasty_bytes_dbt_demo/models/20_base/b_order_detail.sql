WITH source AS (
    SELECT *
    FROM {{ ref('hl_tb_101_order_detail') }}
    WHERE dbt_valid_to IS NULL
)

SELECT
    order_detail_id
    , order_id
    , menu_item_id
    , quantity
    , unit_price
   -- , price
    , order_item_discount_amount
    , updated_at         AS load_timestamp
    , {{ add_meta_columns(source_name='tb_101') }}
FROM source
