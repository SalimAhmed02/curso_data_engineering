{{
  config(
    materialized='table'
  )
}}

WITH src_users AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__users') }}
    ),

src_orders AS (
    SELECT *
    FROM {{ ref('stg_sql_server_dbo__orders') }}
    ),

renamed_casted AS (
    SELECT
        A.USER_ID
        , A.ADDRESS_ID
        , A.utc_created_at
        , EMAIL
        , FIRST_NAME
        , LAST_NAME
        , PHONE_NUMBER
        , COUNT(B.USER_ID) as TOTAL_ORDERS
        , utc_updated_at
        , A.utc_date_load
    FROM 
        src_users A
    LEFT JOIN
        src_orders B
    ON 
        B.USER_ID = A.USER_ID
    GROUP BY A.USER_ID
    , A.ADDRESS_ID
    , FIRST_NAME
    , LAST_NAME
    , EMAIL
    , PHONE_NUMBER
    , utc_updated_at
    , A.utc_created_at
    , A.utc_date_load
    ORDER BY A.USER_ID
    )

SELECT * FROM renamed_casted
