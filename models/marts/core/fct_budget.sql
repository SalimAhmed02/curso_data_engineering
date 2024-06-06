{{
  config(
    materialized='table'
  )
}}

with 

source as (

    select * from {{ ref('stg_google_sheets__budget') }}

),

renamed as (

    select
        _row,
        quantity,
        month,
        product_id,
        utc_date_load

    from source

)

select * from renamed
