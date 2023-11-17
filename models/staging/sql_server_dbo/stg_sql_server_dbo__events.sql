with 

source as (

    select * from {{ source('sql_server_dbo', 'events') }}

),

renamed_events as (

    select
        event_id,
        page_url,
        event_type,
        user_id,
        product_id,
        session_id,
        order_id,
        created_at,
        _fivetran_deleted AS date_deleted,
        _fivetran_synced AS date_load

    from source

)

select * from renamed_events
