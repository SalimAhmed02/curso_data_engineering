{{
  config(
    materialized='view'
  )
}}

WITH src_promos AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'promos') }}
    ),

renamed_casted AS (
    SELECT
        PROMO_ID 
        , DISCOUNT as DISCOUNT_DOLLAR
        , STATUS as STATUS_PROMOS
        , _FIVETRAN_DELETED as date_delete
        , {{ convert_to_utc('_FIVETRAN_SYNCED') }} as utc_date_load
    FROM src_promos
    )

SELECT * FROM renamed_casted
