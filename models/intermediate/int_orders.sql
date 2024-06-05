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

src_products AS (
    SELECT *
    FROM {{ ref('stg_sql_server_dbo__products') }}
    ),

src_promos AS (
    SELECT *
    FROM {{ ref('stg_sql_server_dbo__promos') }}
    ),

renamed_casted AS (
    SELECT
        A.ORDER_ID
        , B.product_id
        , B.quantity
        , C.PRICE
        , (B.QUANTITY * C.PRICE) as total_price
        , D.DISCOUNT_DOLLAR
        , (total_price + ORDER_COST + SHIPPING_COST - DISCOUNT_DOLLAR) as total_price_product
        , ORDER_COST
        , ORDER_TOTAL
        , SHIPPING_COST
        , SHIPPING_SERVICE_ID
        , ADDRESS_ID
        , utc_created_at
        , month
        , utc_delivered_at
        , utc_estimated_delivered_at
        , USER_ID
        , A.promo_id
        , status_orders_id
        , TRACKING_ID
        , A.utc_date_load
    FROM 
        src_orders A
    INNER JOIN
        src_order_items B
    ON 
        B.ORDER_ID = A.ORDER_ID
    INNER JOIN
        src_products C
    ON
        C.PRODUCT_ID =  B.PRODUCT_ID
    INNER JOIN
        src_promos D
    ON  D.PROMO_ID = A.PROMO_ID
    ORDER BY A.ORDER_ID
    )

SELECT * FROM renamed_casted
