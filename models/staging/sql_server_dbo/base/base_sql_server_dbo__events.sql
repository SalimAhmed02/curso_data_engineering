{{
  config(
    materialized='view'
  )
}}

WITH src_events AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'events') }}
    ),

renamed_casted AS (
    SELECT
        {{ convert_to_utc('CREATED_AT') }} as utc_created_at
        , EVENT_ID
        , EVENT_TYPE
        , ORDER_ID
        , PAGE_URL
        , PRODUCT_ID
        , SESSION_ID
        , USER_ID
        , _FIVETRAN_DELETED as date_delete
        , {{ convert_to_utc('_FIVETRAN_SYNCED') }} as utc_date_load
    FROM src_events
    )

SELECT * FROM renamed_casted