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

    UNION ALL

    SELECT
        null
        , md5('sin_address_id')
        , null
        , null
        , 0
        , null
    )

SELECT * FROM renamed_casted