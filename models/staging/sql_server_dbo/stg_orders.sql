with

src_orders as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

renamed_orders as (

    select
        order_id as id_order,
        cast(user_id as varchar(75)) as id_user,
        cast(address_id as varchar(75)) as id_address,
        decode(tracking_id, null, 'Preparing','', 'Preparing', tracking_id) as id_tracking,
        initcap(decode(promo_id, null, 'Without Promotion', '', 'Without Promotion', promo_id)) as id_promo,
        initcap(cast(status as varchar(25))) as status,
        decode(shipping_service, null, 'Preparing','', 'Preparing', shipping_service) as shipping_service,
        created_at as created_at_utc,
        estimated_delivery_at as estimated_delivery_at_utc,
        delivered_at as delivered_at_utc,
        cast(shipping_cost as decimal(10,2)) as shipping_cost_usd,
        cast(order_cost as decimal(10,2)) as item_order_cost_usd,
        cast(order_total as decimal(10,2)) as order_total_usd,
        _fivetran_synced as raw_timestamp_load

    from src_orders

),

final_orders as (

    select
        id_order,
        id_user,
        id_address,
        id_tracking,
        {{ dbt_utils.generate_surrogate_key(['id_promo']) }} as id_promo,
        status,
        shipping_service,
        created_at_utc,
        estimated_delivery_at_utc,
        delivered_at_utc,
        shipping_cost_usd,
        item_order_cost_usd,
        order_total_usd,
        raw_timestamp_load
    from renamed_orders

)

select * from final_orders