{{
  config(
    materialized='view'
  )
}}

WITH src_addresses AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'addresses') }}
    WHERE _FIVETRAN_DELETED IS NULL
    ),

renamed_casted AS (
    SELECT
          ADDRESS
        , ADDRESS_ID
        , COUNTRY
        , STATE
        , ZIPCODE
        , CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(_FIVETRAN_SYNCED)) AS utc_date_load
    FROM src_addresses
    )

SELECT * FROM renamed_casted