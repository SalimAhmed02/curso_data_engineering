with 

src_status_orders as (

    select STATUS_ORDERS from {{ ref('base_sql_server_dbo__orders') }}

),

renamed as (

    select
        distinct(md5(STATUS_ORDERS)) as status_orders_id
        , STATUS_ORDERS as status_orders_name
    from src_status_orders

    UNION ALL

    SELECT
        md5('sin_status_id')
        , 'sin_status'

)

select * from renamed
