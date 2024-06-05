{{
  config(
    materialized='table'
  )
}}

WITH src_addresses AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__addresses') }}
    ),

renamed_casted AS (
    SELECT
          ADDRESS
        , ADDRESS_ID
        , COUNTRY
        , STATE
        , ZIPCODE
        , utc_date_load
    FROM src_addresses
    )

SELECT * FROM renamed_casted