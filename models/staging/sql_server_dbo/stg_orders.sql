with

source as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

renamed_orders as (

    select
        {{ dbt_utils.generate_surrogate_key(['order_id']) }} as order_id,
        CAST(USER_ID AS VARCHAR(75)) as user_id,
        CAST(ADDRESS_ID AS VARCHAR(75)) as address_id,
        decode(promo_id, null, 'Sin promo', '', 'Sin promo', promo_id) as promo_id,
        decode(tracking_id, null, '999', '', '999', tracking_id) as tracking_id,
        created_at as created_at_utc,
        CAST(status AS VARCHAR(25)),
        COALESCE(estimated_delivery_at, '1900-01-01 00:00:00.000-0800') as estimated_delivery_at_utc,
        COALESCE(delivered_at, '1900-01-01 00:00:00.000-0800') as delivered_at_utc,
        decode(shipping_service, null, '999', '', '999', shipping_service) as shipping_service,
        CAST(SHIPPING_COST AS DECIMAL(10,2)) as shipping_cost_usd,
        CAST(ORDER_COST AS DECIMAL(10,2)) as order_cost_usd,
        CAST(ORDER_TOTAL AS DECIMAL(10,2)) as order_total_usd,
        _fivetran_deleted as date_deleted,
        _fivetran_synced as date_load

from source

)

select * from renamed_orders
