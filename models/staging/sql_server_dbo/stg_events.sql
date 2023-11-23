with 

src_events as (

    select * from {{ source('sql_server_dbo', 'events') }}

),

renamed_events as (

    select
        cast(event_id as varchar(75)) as id_event,
        cast(user_id as varchar(75)) as id_user,
        cast(session_id as varchar(75)) as id_session,
        decode(product_id, null, 'pagado_o_enviado', '', 'pagado_o_enviado', product_id) as id_product,
        decode(order_id, null, 'visto_o_en_carro', '', 'visto_o_en_carro', order_id) as id_order,
        cast(event_type as varchar(75)) as event_type ,
        cast(page_url as varchar(100)) as page_url,
        created_at,
        _fivetran_synced AS date_load

    from src_events

)

select * from renamed_events