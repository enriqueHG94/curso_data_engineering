with 

source as (

    select * from {{ source('sql_server_dbo', 'products') }}

),

renamed_products as (

    select
        cast(product_id as varchar(75)) as id_product,
        name,
        cast(price as decimal(10,2)) as price,
        cast(inventory as integer) as inventory,
        _fivetran_synced AS date_load

    from source

)

select * from renamed_products
