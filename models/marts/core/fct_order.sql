with 

stg_orders as (

    select * from {{ ref('stg_orders') }}

),

stg_order_items as (

    select * from {{ ref('stg_order_items') }}

),

stg_products as (

    select * from {{ ref('stg_products') }}

),

joined_orders as (

    select
        o.id_order as order_key,
        o.id_user,
        o.id_address,
        o.id_promo,
        o.id_tracking,
        o.created_at_utc,
        o.estimated_delivery_at_utc,
        o.delivered_at_utc,
        o.status,
        o.shipping_service,
        o.shipping_cost_usd,
        o.order_cost_usd,
        o.order_total_usd,
        o.order_total_usd - o.order_cost_usd - o.shipping_cost_usd as margin_usd,
        o.order_total_usd - o.order_cost_usd - o.shipping_cost_usd as profit_usd,
        i.id_product as product_key,
        i.quantity,
        count(distinct i.id_product) over (partition by o.id_order) as num_products,
        avg(p.price) over (partition by i.id_product) as avg_price,
        (o.order_total_usd - o.order_cost_usd) / o.order_total_usd * 100 as discount_pct
    from stg_orders as o
    left join stg_order_items as i
    on o.id_order = i.id_order
    left join stg_products as p
    on i.id_product = p.id_product

)

select * from joined_orders

