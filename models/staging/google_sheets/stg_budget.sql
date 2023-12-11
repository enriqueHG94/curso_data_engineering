with src_budget_products as (

    select * from {{ source('google_sheets', 'budget') }}
    
),

renamed_casted as (
    select
        cast(_row as number(10, 0)) as _row,
        cast(product_id as varchar(75)) as id_product,
        cast(quantity as integer) as quantity,
        month,
        _fivetran_synced as date_load
    from src_budget_products
)

select * from renamed_casted
