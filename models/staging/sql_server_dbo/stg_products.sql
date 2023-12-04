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
        _fivetran_synced as raw_timestamp_load

    from src_products

)

select * from renamed_products
