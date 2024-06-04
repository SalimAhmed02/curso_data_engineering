{{
  config(
    materialized='view'
  )
}}

WITH src_events AS (
    SELECT * 
    FROM {{ ref('base_sql_server_dbo__events') }}
    ),

renamed_casted AS (
    SELECT
        utc_created_at
        , EVENT_ID
        , md5(EVENT_TYPE) as event_type_id
        , IFF(ORDER_ID = '', 'sin_order_id', ORDER_ID) as ORDER_ID
        , PAGE_URL
        , IFF(PRODUCT_ID = '', 'sin_product_id', PRODUCT_ID) as PRODUCT_ID
        , SESSION_ID
        , USER_ID
        , utc_date_load
    FROM src_events
    )

SELECT * FROM renamed_casted