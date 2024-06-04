{{
  config(
    materialized='view'
  )
}}

WITH src_addresses AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'addresses') }}
    ),

renamed_casted AS (
    SELECT
          ADDRESS
        , ADDRESS_ID
        , COUNTRY
        , STATE
        , ZIPCODE
        , {{ convert_to_utc('_FIVETRAN_SYNCED') }} as utc_date_load
    FROM src_addresses
    )

SELECT * FROM renamed_casted