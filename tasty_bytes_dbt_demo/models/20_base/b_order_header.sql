WITH source AS (
    SELECT *
    FROM {{ ref('hl_tb_101_order_header') }}
    WHERE dbt_valid_to IS NULL
)

SELECT
    order_id
    , truck_id
    , location_id
    , customer_id
    , discount_id
    , shift_id
    , shift_start_time
    , shift_end_time
    , order_channel
    , order_ts
    , served_ts
    , order_amount
    , order_tax_amount
    , order_discount_amount
    , order_total
    , updated_at         AS load_timestamp
    , {{ add_meta_columns(source_name='tb_101') }}
FROM source
