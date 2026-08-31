{#
  Macro: add_meta_columns
  Fügt einem SELECT-Statement zusätzliche meta-Spalten hinzu:
    - dbt_load_timestamp: aktueller Timestamp
    - source: Name der Quelle (wird als Argument übergeben)

  Verwendung:
    {{
      config(
        materialized='view'
      )
    }}

    select
        {{ add_meta_columns('meine_source_name') }},
        id,
        name
    from {{ source('raw', 'meine_tabelle') }}
#}

{% macro add_meta_columns(source_name) %}
    current_timestamp() as dbt_load_timestamp,
    '{{ source_name }}' as record_source
{% endmacro %}
