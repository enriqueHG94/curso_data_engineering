with 

source as (

    select * from {{ source('sql_server_dbo', 'order_items') }}

),

renamed_order_items as (

    select
        order_id,
        product_id,
        quantity,
        _fivetran_deleted AS date_deleted,
        _fivetran_synced AS date_load

    from source

)

select * from renamed_order_items