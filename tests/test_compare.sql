SELECT *
FROM {{ ref('stg_sql_server_dbo__orders') }}
WHERE UTC_DELIVERED_AT < UTC_CREATED_AT
/* comprueba si hay algún caso en el que la fecha de entrega sea anterior a la fecha en que se realizó el pedido, lo que no tendría sentido lógico e indicaría algún tipo de problema con los datos */