with 

source as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

renamed_orders as (

    select
        order_id,
        user_id,
        address_id,
        promo_id,
        tracking_id,
        created_at,
        estimated_delivery_at,
        status,
        delivered_at,
        shipping_service,
        shipping_cost,
        order_cost,
        order_total,
        _fivetran_deleted AS date_deleted,
        _fivetran_synced AS date_load

    from source

)

select * from renamed_orders
