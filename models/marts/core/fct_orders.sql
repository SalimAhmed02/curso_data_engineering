{{
  config(
    materialized='table'
  )
}}

WITH src_orders AS (
    SELECT *
    FROM {{ ref('int_orders') }}
    ),

renamed_casted AS (
    SELECT
        ORDER_ID
        , product_id
        , quantity
        , total_price_product
        , SHIPPING_COST_ORDER
        , final_price
        , ORDER_TOTAL
        , SHIPPING_SERVICE_ID
        , ADDRESS_ID
        , utc_created_at
        , month
        , utc_delivered_at
        , utc_estimated_delivered_at
        , USER_ID
        , promo_id
        , status_orders_id
        , TRACKING_ID
        , utc_date_load
    FROM 
        src_orders
    ORDER BY ORDER_ID
    )

SELECT * FROM renamed_casted
