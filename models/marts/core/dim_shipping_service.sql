{{
  config(
    materialized='table'
  )
}}

with 

source as (

    select SHIPPING_SERVICE from {{ ref('stg_sql_server_dbo__orders') }}

),

renamed as (

    select
        SHIPPING_SERVICE_ID
        , SHIPPING_SERVICE_NAME
    from source
)

select * from renamed
