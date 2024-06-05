{{
  config(
    materialized='table'
  )
}}

with 

source as (

    select STATUS_PROMOS from {{ ref('stg_sql_server_dbo__status_promos') }}

),

renamed as (

    select
        status_promos_name,
        status_promos_id
    from source

)

select * from renamed
