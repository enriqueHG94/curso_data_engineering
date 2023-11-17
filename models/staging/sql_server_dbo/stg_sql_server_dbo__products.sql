with 

source as (

    select * from {{ source('sql_server_dbo', 'products') }}

),

renamed_products as (

    select
        product_id,
        name,
        price,
        inventory,
        _fivetran_deleted AS date_deleted,
        _fivetran_synced AS date_load

    from source

)

select * from renamed_products
