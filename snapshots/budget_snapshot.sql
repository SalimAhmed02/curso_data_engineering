{% snapshot budget_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='_row',

      strategy='timestamp',
      updated_at='_fivetran_synced',
      invalidate_hard_deletes=True,
    )
}}

select * from {{ source('google_sheets', 'budget') }}

{% if is_incremental() %}

    WHERE _fivetran_synced > (SELECT MAX(_fivetran_synced) FROM {{ this }} )
    
{% endif %}

{% endsnapshot %}