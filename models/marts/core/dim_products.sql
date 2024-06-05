{{
  config(
    materialized='table'
  )
}}

WITH src_products AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__products') }}
    ),

renamed_casted AS (
    SELECT
        PRODUCT_ID
        , NAME
        , PRICE
        , INVENTORY
        , utc_date_load
    FROM src_products
    )

SELECT * FROM renamed_casted
