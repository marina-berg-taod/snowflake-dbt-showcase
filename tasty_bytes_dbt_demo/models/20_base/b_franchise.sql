WITH source AS (
    SELECT *
    FROM {{ ref('hl_tb_101_franchise') }}
    WHERE dbt_valid_to IS NULL
)

SELECT
    franchise_id
    , first_name
    , last_name
    , city               AS city_name
    , country            AS country_name
    , e_mail             AS email_address
    , phone_number
    , updated_at         AS load_timestamp
    , {{ add_meta_columns(source_name='tb_101') }}
FROM source
