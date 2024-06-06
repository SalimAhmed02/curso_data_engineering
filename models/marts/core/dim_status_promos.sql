{{
  config(
    materialized='table'
  )
}}

with 

src_status_promos as (

    select * from {{ ref('stg_sql_server_dbo__status_promos') }}

),

renamed as (

    select
        status_promos_name,
        status_promos_id
    from src_status_promos

)

select * from renamed
