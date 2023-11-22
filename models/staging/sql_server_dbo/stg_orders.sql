with

source as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

renamed_orders as (

    select
        order_id as id_order,
        cast(user_id as varchar(75)) as id_user,
        cast(address_id as varchar(75)) as id_address,
        decode(promo_id, null, 'Sin promo', '', 'Sin promo', promo_id) as id_promo,
        tracking_id as id_tracking,
        created_at as created_at_utc,
        initcap(cast(status as varchar(25))) as status,
        estimated_delivery_at as estimated_delivery_at_utc,
        delivered_at as delivered_at_utc,
        decode(shipping_service, null, 'Preparing', '', 'Preparing', shipping_service) as shipping_service,
        cast(shipping_cost as decimal(10,2)) as shipping_cost_usd,
        cast(order_cost as decimal(10,2)) as order_cost_usd,
        cast(order_total as decimal(10,2)) as order_total_usd,
        _fivetran_synced as date_load

    from source

)

select * from renamed_orders

