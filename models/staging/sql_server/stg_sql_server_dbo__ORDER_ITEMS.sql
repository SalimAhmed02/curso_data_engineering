{{
  config(
    materialized='view'
  )
}}

WITH src_order_items AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'ORDER_ITEMS') }}
    ),

renamed_casted AS (
    SELECT
        ORDER_ID
        , PRODUCT_ID
        , QUANTITY
        , _FIVETRAN_DELETED AS date_delete
        , _FIVETRAN_SYNCED AS date_load
    FROM src_order_items
    )

SELECT * FROM renamed_casted
