WITH date_spine AS (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="to_date('2020-01-01')",
        end_date="to_date('2030-12-31')"
    ) }}
)

SELECT
    date_day                                    AS calendar_date
    , YEAR(date_day)                            AS calendar_year
    , MONTH(date_day)                           AS calendar_month
    , DAY(date_day)                             AS calendar_day
    , QUARTER(date_day)                         AS calendar_quarter
    , DAYOFWEEK(date_day)                       AS day_of_week
    , DAYOFYEAR(date_day)                       AS day_of_year
    , WEEKOFYEAR(date_day)                      AS week_of_year
    , DAYNAME(date_day)                         AS day_name
    , MONTHNAME(date_day)                       AS month_name
FROM date_spine
