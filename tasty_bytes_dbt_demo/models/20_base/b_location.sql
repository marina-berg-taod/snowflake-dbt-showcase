WITH source AS (
    SELECT *
    FROM {{ ref('hl_tb_101_location') }}
    WHERE dbt_valid_to IS NULL
)

SELECT
    location_id
    , placekey
    , location           AS location_name
    , city               AS city_name
    , region
    , iso_country_code
    , country            AS country_name
    , updated_at         AS load_timestamp
    , {{ add_meta_columns(source_name='tb_101') }}
FROM source
