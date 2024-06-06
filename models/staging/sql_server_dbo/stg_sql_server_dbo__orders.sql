{{
  config(
    materialized='view'
  )
}}

WITH src_orders AS (
    SELECT * 
    FROM {{ ref('base_sql_server_dbo__orders') }}
    ),

renamed_casted AS (
    SELECT
        IFF(ADDRESS_ID = '', md5('sin_address_id'), ADDRESS_ID) as ADDRESS_ID
        , utc_created_at
        , month
        , utc_delivered_at
        , utc_estimated_delivered_at
        , ORDER_COST
        , ORDER_ID
        , ORDER_TOTAL
        , IFF(promo_id = '', md5('sin_promo_id'), md5(promo_id)) as promo_id
        , SHIPPING_COST
        , md5(SHIPPING_SERVICE) as SHIPPING_SERVICE_ID
        , md5(STATUS_ORDERS) as status_orders_id
        , IFF(TRACKING_ID = '', 'sin_tracking_id', TRACKING_ID) as TRACKING_ID
        , IFF(USER_ID = '', md5('sin_user_id'), USER_ID) as USER_ID
        , utc_date_load
    FROM src_orders

    UNION ALL

    SELECT
        md5('sin_address_id')
        , null
        , null
        , null
        , null
        , 0
        , md5('sin_order_id')
        , 0
        , md5('sin_promo_id')
        , 0
        , md5('sin_shipping_service')
        , md5('sin_status_id')
        , md5('sin_tracking_id')
        , md5('sin_user_id')
        , null
    )

SELECT * FROM renamed_casted
