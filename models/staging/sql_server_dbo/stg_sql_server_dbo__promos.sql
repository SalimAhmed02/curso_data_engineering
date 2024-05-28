{{
  config(
    materialized='view'
  )
}}

WITH src_promos AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'promos') }}
    WHERE _FIVETRAN_DELETED IS NULL
    ),

renamed_casted AS (
    SELECT
        md5(PROMO_ID) as PROMO_ID 
        , PROMO_ID as PROMO_NAME 
        , DISCOUNT as discount_dollar
        , IFF(status = 'active', '1', '0') as status_promos_id
        , CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(_FIVETRAN_SYNCED)) AS utc_date_load
    FROM src_promos

    UNION ALL

    SELECT
        md5('Desconocido'),
        'Desconocido',
        0,
        0,
        null,
        null
    )

SELECT * FROM renamed_casted
