{{
  config(
    materialized='view'
  )
}}

WITH src_users AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'users') }}
    WHERE _FIVETRAN_DELETED IS NULL
    ),

renamed_casted AS (
    SELECT
        ADDRESS_ID
        , CREATED_AT
        , EMAIL
        , FIRST_NAME
        , LAST_NAME
        , PHONE_NUMBER
        , TOTAL_ORDERS
        , UPDATED_AT
        , USER_ID
        , CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(_FIVETRAN_SYNCED)) AS utc_date_load
    FROM src_users
    )

SELECT * FROM renamed_casted