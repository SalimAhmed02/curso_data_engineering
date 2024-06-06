with

    src_status_promos as (

        select status_promos from {{ ref("base_sql_server_dbo__promos") }}

    ),

    renamed as (

        select distinct
            (status_promos) as status_promos_name,
            iff(status_promos = 'active', '1', '0') as status_promos_id
        from src_status_promos

    )

select *
from renamed
