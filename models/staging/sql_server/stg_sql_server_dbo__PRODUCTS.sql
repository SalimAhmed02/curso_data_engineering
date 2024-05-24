{{
  config(
    materialized='view'
  )
}}

WITH src_products AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'PRODUCTS') }}
    ),

renamed_casted AS (
    SELECT
        INVENTORY
        , NAME
        , PRICE
        , PRODUCT_ID
        , _FIVETRAN_DELETED AS date_delete
        , _FIVETRAN_SYNCED AS date_load
    FROM src_products
    )

SELECT * FROM renamed_casted
