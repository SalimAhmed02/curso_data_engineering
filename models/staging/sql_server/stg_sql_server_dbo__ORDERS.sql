{{
  config(
    materialized='view'
  )
}}

WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'ORDERS') }}
    ),

renamed_casted AS (
    SELECT
        ADDRESS_ID
        , CREATED_AT
        , DELIVERED_AT
        , ESTIMATED_DELIVERY_AT
        , ORDER_COST
        , ORDER_ID
        , ORDER_TOTAL
        , PROMO_ID
        , SHIPPING_COST
        , SHIPPING_SERVICE
        , STATUS
        , TRACKING_ID
        , USER_ID
        , _FIVETRAN_DELETED AS date_delete
        , _FIVETRAN_SYNCED AS date_load
    FROM src_orders
    )

SELECT * FROM renamed_casted
