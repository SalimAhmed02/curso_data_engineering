{{
  config(
    materialized='table'
  )
}}

with 

src_events_type as (

    select * from {{ ref('stg_sql_server_dbo__events_type') }}

),

renamed as (

    select
        event_type_id
        , event_type_name
    from src_events_type
)

select * from renamed
