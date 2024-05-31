{{
  config(
    materialized='view'
  )
}}

WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'orders') }}
    WHERE _FIVETRAN_DELETED IS NULL
    ),

renamed_casted AS (
    SELECT
        ADDRESS_ID
        , {{ convert_to_utc('CREATED_AT') }} as utc_created_at
        , {{ convert_to_utc('DELIVERED_AT') }} as utc_delivered_at
        , {{ convert_to_utc('ESTIMATED_DELIVERY_AT') }} as utc_estimated_delivered_at
        , ORDER_COST
        , ORDER_ID
        , ORDER_TOTAL
        , IFF(promo_id = '', md5('sin_promo'), md5(promo_id)) as promo_id
        , SHIPPING_COST
        , md5(SHIPPING_SERVICE) as SHIPPING_SERVICE_ID
        , md5(STATUS) as status_orders_id
        , IFF(TRACKING_ID = '', 'sin_tracking_id', TRACKING_ID) as TRACKING_ID
        , USER_ID
        , {{ convert_to_utc('_FIVETRAN_SYNCED') }} as utc_date_load
    FROM src_orders
    )

SELECT * FROM renamed_casted
