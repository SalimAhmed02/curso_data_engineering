with 

source as (

    select status from {{ source('sql_server_dbo', 'promos') }}

),

renamed as (

    select
        distinct(status) as status_promos_name,
        IFF(status = 'active', '1', '0') as status_promos_id
    from source

)

select * from renamed
