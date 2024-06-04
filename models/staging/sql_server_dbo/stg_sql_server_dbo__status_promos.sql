with 

source as (

    select STATUS_PROMOS from {{ ref('base_sql_server_dbo__promos') }}

),

renamed as (

    select
        distinct(STATUS_PROMOS) as status_promos_name,
        IFF(STATUS_PROMOS = 'active', '1', '0') as status_promos_id
    from source

)

select * from renamed
