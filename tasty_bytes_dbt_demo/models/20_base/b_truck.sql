WITH source AS (
    SELECT *
    FROM {{ ref('hl_tb_101_truck') }}
    WHERE dbt_valid_to IS NULL
)

SELECT
    *
    , updated_at AS load_timestamp
    , {{ add_meta_columns(source_name='tb_101') }}
FROM source
