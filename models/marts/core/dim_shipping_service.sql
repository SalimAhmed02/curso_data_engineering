{{
  config(
    materialized='table'
  )
}}

with 

src_shipping_service as (

    select * from {{ ref('stg_sql_server_dbo__shipping_service') }}

),

renamed as (

    select
        SHIPPING_SERVICE_ID
        , SHIPPING_SERVICE_NAME
    from src_shipping_service
)

select * from renamed
