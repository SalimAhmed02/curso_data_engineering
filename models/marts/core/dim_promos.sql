{{
  config(
    materialized='table'
  )
}}

WITH src_promos AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__promos') }}
    ),

renamed_casted AS (
    SELECT
        PROMO_ID 
        , PROMO_NAME 
        , DISCOUNT_DOLLAR
        , status_promos_id
        , utc_date_load
    FROM src_promos
    )

SELECT * FROM renamed_casted
