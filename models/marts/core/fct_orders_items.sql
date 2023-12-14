with 

stg_orders as (

    select * from {{ ref('stg_orders') }}

),

stg_orderitems as (

    select * from {{ ref('stg_order_items') }}
    
),

stg_products as (

    select * from {{ ref('stg_products') }}
    
),

order_item_counts as (
    select
        id_order,
        sum(quantity) as total_quantity
    from {{ ref('stg_order_items') }}
    group by id_order
),

final_fct as (
    select
        o.id_order,
        oi.id_product,
        id_user,
        id_address,
        id_promo,
        id_tracking,
        status,
        p.name as product_name,
        p.price as product_price_usd,
        quantity,
        (p.price * oi.quantity) as total_product_cost_usd,
        cast((o.shipping_cost_usd * oi.quantity) / oc.total_quantity as decimal(7,2)) as shipping_cost_per_product_line,
        created_at_utc,
        DATEDIFF(day, created_at_utc, delivered_at_utc) AS days_to_deliver,
        estimated_delivery_at_utc,
        delivered_at_utc,
        shipping_service,
        shipping_cost_usd,
        item_order_cost_usd as order_cost_usd,
        order_total_usd
    from {{ ref('stg_order_items') }}  oi
    join {{ ref('stg_orders') }}  o
    on oi.id_order = o.id_order
    join {{ ref('stg_products') }} p
    on oi.id_product = p.id_product
    join order_item_counts oc on o.id_order = oc.id_order
)

select * from final_fct
