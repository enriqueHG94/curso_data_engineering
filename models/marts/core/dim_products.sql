{{ config(materialized='incremental') }}

with 

stg_products as (

    select * from {{ ref('stg_products') }}

),

final_products as (
    select
        id_product,
        name,
        price,
        inventory
    from stg_products
)

select * from final_products

{% if is_incremental() %}

    where not exists (
        select 1
        from {{ this }}
        where {{ this }}.id_product = final_products.id_product
    )

{% endif %}