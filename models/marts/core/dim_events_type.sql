{{
  config(
    materialized='table'
  )
}}

with 

source as (

    select EVENT_TYPE from {{ ref('stg_sql_server_dbo__events_type') }}

),

renamed as (

    select
        event_type_id
        , event_type_name
    from source
)

select * from renamed
