{{
  config(
    materialized='table'
  )
}}

WITH src_events AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__events') }}
    ),

renamed_casted AS (
    SELECT
        utc_created_at
        , EVENT_ID
        , event_type_id
        , ORDER_ID
        , PAGE_URL
        , PRODUCT_ID
        , SESSION_ID
        , USER_ID
        , utc_date_load
    FROM src_events
    )

SELECT * FROM renamed_casted