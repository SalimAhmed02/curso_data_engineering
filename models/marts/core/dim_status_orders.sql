{{
  config(
    materialized='table'
  )
}}

with 

src_status_orders as (

    select * from {{ ref('stg_sql_server_dbo__status_orders') }}

),

renamed as (

    select
        status_orders_id
        , status_orders_name
    from src_status_orders

)

select * from renamed
