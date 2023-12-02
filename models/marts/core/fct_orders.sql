with stg_orders as (
    select * 
    from {{ ref('stg_orders') }}
),


final_orders AS (
    SELECT
        id_order, 
        id_user,
        id_address,
        id_promo,
        id_tracking,
        created_at_utc,
        DATEDIFF(day, created_at_utc, delivered_at_utc) AS days_to_deliver,
        status,
        estimated_delivery_at_utc,
        delivered_at_utc,
        shipping_service,
        shipping_cost_usd,
        item_order_cost_usd,
        order_total_usd
    FROM stg_orders
    )

SELECT * FROM final_orders