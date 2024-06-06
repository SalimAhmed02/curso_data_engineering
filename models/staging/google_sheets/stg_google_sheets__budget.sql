{{
  config(
    materialized='view'
  )
}}

WITH src_budget as (

    SELECT * 
    FROM {{ ref('base_google_sheets__budget_') }}

    ),

renamed as (

    select
        _row,
        quantity,
        month,
        product_id,
        utc_date_load

    from src_budget

)

select * from renamed
