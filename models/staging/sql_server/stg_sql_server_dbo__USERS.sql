{{
  config(
    materialized='view'
  )
}}

WITH src_users AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'USERS') }}
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
        , _FIVETRAN_DELETED AS date_delete
        , _FIVETRAN_SYNCED AS date_load
    FROM src_users
    )

SELECT * FROM renamed_casted
