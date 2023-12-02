with

src_orders as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

renamed_orders as (

    select
        order_id as id_order,
        cast(user_id as varchar(75)) as id_user,
        cast(address_id as varchar(75)) as id_address,
        {{ dbt_utils.generate_surrogate_key(['promo_id']) }} as id_promo,
        tracking_id as id_tracking,
        created_at as created_at_utc,
        decode(promo_id, null, 'With Promo', '', 'With Promo', promo_id) as desc_promo,
        initcap(cast(status as varchar(25))) as status,
        estimated_delivery_at as estimated_delivery_at_utc,
        delivered_at as delivered_at_utc,
        decode(shipping_service, null, 'Preparing', '', 'Preparing', shipping_service) as shipping_service,
        cast(shipping_cost as decimal(10,2)) as shipping_cost_usd,
        cast(order_cost as decimal(10,2)) as item_order_cost_usd,
        cast(order_total as decimal(10,2)) as order_total_usd,
        _fivetran_synced as raw_timestamp_load

    from src_orders

)

select * from renamed_orders

