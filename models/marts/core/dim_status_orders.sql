{{
  config(
    materialized='table'
  )
}}

with 

source as (

    select STATUS_ORDERS from {{ ref('stg_sql_server_dbo__status_orders') }}

),

renamed as (

    select
        status_orders_id
        , status_orders_name
    from source

)

select * from renamed
