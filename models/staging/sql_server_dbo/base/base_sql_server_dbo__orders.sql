{{
  config(
    materialized='view'
  )
}}

WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'orders') }}
    ),

renamed_casted AS (
    SELECT
        ADDRESS_ID
        , {{ convert_to_utc('CREATED_AT') }} as utc_created_at
        , utc_created_at::DATE as month
        , {{ convert_to_utc('DELIVERED_AT') }} as utc_delivered_at
        , {{ convert_to_utc('ESTIMATED_DELIVERY_AT') }} as utc_estimated_delivered_at
        , ORDER_COST
        , ORDER_ID
        , ORDER_TOTAL
        , PROMO_ID
        , SHIPPING_COST
        , SHIPPING_SERVICE
        , STATUS as STATUS_ORDERS
        , TRACKING_ID
        , USER_ID
        , _FIVETRAN_DELETED as date_delete
        , {{ convert_to_utc('_FIVETRAN_SYNCED') }} as utc_date_load
    FROM src_orders
    )

SELECT * FROM renamed_casted
