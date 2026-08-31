WITH base AS (
    SELECT *
    FROM {{ ref('b_location') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['location_id']) }} AS location_key
    , location_id
    , placekey
    , location_name
    , city_name
    , region
    , iso_country_code
    , country_name
    , load_timestamp
FROM base
