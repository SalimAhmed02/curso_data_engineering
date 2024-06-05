{{
  config(
    materialized='table'
  )
}}

WITH src_orders AS (
    SELECT *
    FROM {{ ref('stg_sql_server_dbo__orders') }}
    ),

src_order_items AS (
    SELECT *
    FROM {{ ref('stg_sql_server_dbo__order_items') }}
    ),

renamed_casted AS (
    SELECT
        ROW_NUMBER() over (PARTITION BY A.ORDER_ID ORDER BY A.ORDER_ID) as num_products
        , ADDRESS_ID
        , utc_created_at
        , month
        , utc_delivered_at
        , utc_estimated_delivered_at
        , ORDER_COST
        , A.ORDER_ID
        , ORDER_TOTAL
        , promo_id
        , SHIPPING_COST
        , SHIPPING_SERVICE_ID
        , status_orders_id
        , TRACKING_ID
        , USER_ID
        , B.product_id
        , B.quantity
        , A.utc_date_load
    FROM 
        src_orders A
    INNER JOIN
        src_order_items B
    ON 
        B.ORDER_ID = A.ORDER_ID
    )

SELECT * FROM renamed_casted
