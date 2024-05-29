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
        , CREATED_AT
        , DELIVERED_AT
        , ESTIMATED_DELIVERY_AT
        , ORDER_COST
        , ORDER_ID
        , ORDER_TOTAL
        , CASE WHEN promo_id = '' then md5('Desconocido')
               ELSE md5(promo_id)
          END as promo_id
        , SHIPPING_COST
        , md5(SHIPPING_SERVICE) as SHIPPING_SERVICE_ID
        , md5(STATUS) as status_orders_id
        , TRACKING_ID
        , USER_ID
        , CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(_FIVETRAN_SYNCED)) AS utc_date_load
    FROM src_orders
    )

SELECT * FROM renamed_casted
