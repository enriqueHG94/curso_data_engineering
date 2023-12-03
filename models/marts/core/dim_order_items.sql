with

stg_order_items as (

    select * from {{ ref('stg_order_items') }}

),

final_order_items as (

    select
        id_order,
        id_product,
        quantity
    from stg_order_items
)

select * from final_order_items
