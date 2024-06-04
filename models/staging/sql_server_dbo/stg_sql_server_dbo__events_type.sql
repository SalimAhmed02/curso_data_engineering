with 

source as (

    select EVENT_TYPE from {{ ref('base_sql_server_dbo__events') }}

),

renamed as (

    select
        distinct(md5(EVENT_TYPE)) as event_type_id
        , EVENT_TYPE as event_type_name
    from source
)

select * from renamed
