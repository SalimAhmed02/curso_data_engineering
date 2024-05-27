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
        DISCOUNT
        , PROMO_ID
        , STATUS
        , _FIVETRAN_DELETED AS date_delete
        , _FIVETRAN_SYNCED AS date_load
    FROM src_promos
    )

SELECT * FROM renamed_casted
