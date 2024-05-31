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
        {{ convert_to_utc('CREATED_AT') }} as utc_created_at
        , EVENT_ID
        , EVENT_TYPE
        , IFF(ORDER_ID = '', 'sin_order_id', ORDER_ID) as ORDER_ID
        , PAGE_URL
        , IFF(PRODUCT_ID = '', 'sin_product_id', PRODUCT_ID) as PRODUCT_ID
        , SESSION_ID
        , USER_ID
        , {{ convert_to_utc('_FIVETRAN_SYNCED') }} as utc_date_load
    FROM src_events
    )

SELECT * FROM renamed_casted