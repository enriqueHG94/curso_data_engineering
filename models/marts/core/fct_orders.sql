with stg_orders as (
    select * from {{ ref('stg_orders') }}
),

stg_orderitems as (
    select * from {{ ref('stg_order_items') }}
),


final_fct as (
    select
        o.id_order,
        oi.id_product,
        id_user,
        id_address,
        id_promo,
        id_tracking,
        created_at_utc,
        DATEDIFF(day, created_at_utc, delivered_at_utc) AS days_to_deliver,
        status,
        quantity,
        estimated_delivery_at_utc,
        delivered_at_utc,
        shipping_service,
        shipping_cost_usd,
        item_order_cost_usd,
        order_total_usd
    from {{ ref('stg_order_items') }}  oi
    join {{ ref('stg_orders') }}  o
    on oi.id_order = o.id_order
)

select * from final_fct
