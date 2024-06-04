{{
  config(
    materialized='view'
  )
}}

WITH src_promos AS (
    SELECT * 
    FROM {{ ref('base_sql_server_dbo__promos') }}
    ),

renamed_casted AS (
    SELECT
        md5(PROMO_ID) as PROMO_ID 
        , PROMO_ID as PROMO_NAME 
        , DISCOUNT_DOLLAR
        , IFF(STATUS_PROMOS = 'active', '1', '0') as status_promos_id
        , utc_date_load
    FROM src_promos

    UNION ALL

    SELECT
        md5('sin_promo'),
        'sin_promo',
        0,
        0,
        null
    )

SELECT * FROM renamed_casted
