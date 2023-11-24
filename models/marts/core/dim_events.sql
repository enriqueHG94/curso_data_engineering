with 

stg_events as (

    select * from {{ ref('stg_events') }}

),

final_events as (

    select
        id_event,
        id_user,
        id_session,
        id_product,
        id_order,
        event_type,
        page_url,
        created_event
    from stg_events

)

select * from final_events
