{{
  config(
    materialized='view'
  )
}}

WITH src_users AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'users') }}
    ),

renamed_casted AS (
    SELECT
        ADDRESS_ID
        , {{ convert_to_utc('CREATED_AT') }} as utc_created_at
        , EMAIL
        , coalesce (regexp_like(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$')= true,false) as is_valid_email_address
        , FIRST_NAME
        , LAST_NAME
        , PHONE_NUMBER
        , TOTAL_ORDERS
        , {{ convert_to_utc('UPDATED_AT') }} as utc_updated_at
        , USER_ID
        , {{ convert_to_utc('_FIVETRAN_SYNCED') }} as utc_date_load
    FROM src_users
    )

SELECT * FROM renamed_casted
