WITH base AS (
    SELECT *
    FROM {{ ref('b_customer_loyalty') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['customer_id']) }} AS customer_key
    , customer_id
    , first_name
    , last_name
    , city_name
    , country_name
    , email_address
    , phone_number
    , load_timestamp
FROM base
