with 

src_events as (

    select * from {{ source('sql_server_dbo', 'events') }}

),

renamed_events as (

    select
        cast(event_id as varchar(75)) as id_event,
        cast(user_id as varchar(75)) as id_user,
        cast(session_id as varchar(75)) as id_session,
        cast(product_id as varchar(75)) as id_product,
        cast(order_id as varchar(75)) as id_order,
        cast(event_type as varchar(75)) as event_type,
        cast(page_url as varchar(100)) as page_url,
        created_at as created_event,
        _fivetran_synced AS date_load

    from src_events

)

select * from renamed_events