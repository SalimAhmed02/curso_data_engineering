{{
  config(
    materialized='view'
  )
}}

WITH src_products AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'products') }}
    ),

renamed_casted AS (
    SELECT
        PRODUCT_ID
        , NAME
        , PRICE
        , INVENTORY
        , {{ convert_to_utc('_FIVETRAN_SYNCED') }} as utc_date_load
    FROM src_products

    UNION ALL

    SELECT 
        md5('sin_product_id')
        , null
        , 0
        , 0
        , null
    )

SELECT * FROM renamed_casted
