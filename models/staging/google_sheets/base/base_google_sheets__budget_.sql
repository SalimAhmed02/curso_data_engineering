{{
  config(
    materialized='view'
  )
}}

WITH src_budget as (
    SELECT * 
    FROM {{ source('google_sheets', 'budget') }}
    ),

renamed as (

    select
        _row,
        quantity,
        month,
        product_id,
        {{ convert_to_utc('_FIVETRAN_SYNCED') }} as utc_date_load

    from src_budget

)

select * from renamed
