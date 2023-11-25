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
