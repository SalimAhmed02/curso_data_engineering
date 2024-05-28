with 

source as (

    select status from {{ source('sql_server_dbo', 'orders') }}

),

renamed as (

    select
        distinct(md5(status)) as status_orders_id
        , status as status_orders_name
    from source

)

select * from renamed
