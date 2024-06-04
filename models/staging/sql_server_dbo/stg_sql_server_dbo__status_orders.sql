with 

source as (

    select STATUS_ORDERS from {{ ref('base_sql_server_dbo__orders') }}

),

renamed as (

    select
        distinct(md5(STATUS_ORDERS)) as status_orders_id
        , STATUS_ORDERS as status_orders_name
    from source

)

select * from renamed
