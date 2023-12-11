{{ config(
    materialized='incremental'
    ) 
    }}

with

src_products as (

    select * from {{ source('sql_server_dbo', 'products') }}

),

renamed_products as (

    select
        cast(product_id as varchar(75)) as id_product,
        cast(name as varchar(75)) as name,
        cast(price as decimal(10, 2)) as price,
        cast(inventory as integer) as inventory,
        _fivetran_synced as date_load

    from src_products

),

new_products as (

    select * from {{ source('seed_data', 'new_products') }}

),

renamed_new_products as (

    select
        cast(product_id as varchar(75)) as id_product,
        cast(name as varchar(75)) as name,
        cast(price as decimal(10, 2)) as price,
        cast(inventory as integer) as inventory,
        _fivetran_synced as date_load

    from new_products
),

combined_products as (

    select * from renamed_products
    union all
    select * from renamed_new_products

)

{% if is_incremental() %}

select
    p.*
from combined_products p
left join {{ this }} t
    on p.id_product = t.id_product
where t.id_product is null

{% else %}

select * from combined_products

{% endif %}

