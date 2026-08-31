WITH base AS (
    SELECT *
    FROM {{ ref('b_truck') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['truck_id']) }} AS truck_key
    , truck_id
    , menu_type_id
    , primary_city
    , region
    , iso_region
    , country
    , iso_country_code
    , franchise_id
    , year
    , make
    , model
    , ev_flag
    , franchise_flag
    , truck_opening_date
    , load_timestamp
FROM base
