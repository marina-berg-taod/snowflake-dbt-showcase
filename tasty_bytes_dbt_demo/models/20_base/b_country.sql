WITH source AS (
    SELECT *
    FROM {{ ref('hl_tb_101_country') }}
    WHERE dbt_valid_to IS NULL
)

SELECT
    country_id
    , country            AS country_name
    , iso_currency
    , iso_country
    , city_id
    , city               AS city_name
    , city_population
    , updated_at         AS load_timestamp
    , {{ add_meta_columns(source_name='tb_101') }}

FROM source
