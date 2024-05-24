{{
  config(
    materialized='view'
  )
}}

WITH src_events AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'EVENTS') }}
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
        , _FIVETRAN_DELETED AS date_delete
        , _FIVETRAN_SYNCED AS date_load
    FROM src_events
    )

SELECT * FROM renamed_casted