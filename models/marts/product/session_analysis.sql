with 

fct_events as (

    select * from {{ ref('fct_events') }}

),

dim_users as (

    select * from {{ ref('dim_users') }}
    
),

-- Crear una tabla temporal con los eventos agrupados por sesión
    session_events as (
        select
            id_session,
            id_user,
            id_product,
            id_order,
            event_type,
            created_event,
            row_number() over (partition by id_session order by created_event) as event_rank,
            count(*) over (partition by id_session) as total_events
        from fct_events
    ),

-- Crear una tabla temporal con la información de inicio y fin de sesión
    session_start_end as (
        select
            id_session,
            id_user,
            min(created_event) as session_start,
            max(created_event) as session_end,
            datediff(minute, min(created_event), max(created_event)) as session_duration
        from session_events
        group by id_session, id_user
    ),

-- Crear una tabla temporal con el número de páginas vistas por sesión
    session_page_views as (
        select
            id_session,
            count(distinct page_url) as page_views
        from fct_events
        group by id_session
    ),

-- Crear una tabla temporal con el número de eventos de cada tipo por sesión
    session_event_counts as (
        select
            id_session,
            count(case when event_type = 'add_to_cart' then 1 end) as add_to_cart_count,
            count(case when event_type = 'checkout' then 1 end) as checkout_count,
            count(case when event_type = 'package_shipped' then 1 end) as package_shipped_count
        from fct_events
        group by id_session
    )

-- Crear la tabla final con la información de cada sesión
select
    s.id_session,
    u.id_user,
    u.first_name,
    u.email,
    s.session_start,
    s.session_end,
    s.session_duration,
    p.page_views,
    e.add_to_cart_count,
    e.checkout_count,
    e.package_shipped_count
from session_start_end s
join dim_users u on s.id_user = u.id_user
join session_page_views p on s.id_session = p.id_session
join session_event_counts e on s.id_session = e.id_session
order by s.session_start