with 

src_shipping_service as (

    select SHIPPING_SERVICE from {{ ref('base_sql_server_dbo__orders') }}

),

renamed as (

    select
        distinct(md5(SHIPPING_SERVICE)) as SHIPPING_SERVICE_ID
        , CASE WHEN SHIPPING_SERVICE = '' then 'sin_shipping_service'
               ELSE SHIPPING_SERVICE
          END AS SHIPPING_SERVICE_NAME
    from src_shipping_service
)

select * from renamed
