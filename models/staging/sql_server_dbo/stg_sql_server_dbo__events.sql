{{
  config(
    materialized='view'
  )
}}

WITH src_events AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'events') }}
    WHERE _FIVETRAN_DELETED IS NULL
    ),

renamed_casted AS (
    SELECT
        CREATED_AT
        , EVENT_ID
        , EVENT_TYPE
        , ORDER_ID
        , PAGE_URL
        , PRODUCT_ID
        , SESSION_ID
        , USER_ID
        , CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(_FIVETRAN_SYNCED)) AS utc_date_load
    FROM src_events
    )

SELECT * FROM renamed_casted