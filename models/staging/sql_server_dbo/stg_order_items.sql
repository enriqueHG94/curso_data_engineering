with 

src_order_items as (

    select * from {{ source('sql_server_dbo', 'order_items') }}

),

renamed_order_items as (

    select
        cast(order_id as varchar(75)) as id_order ,
        cast(product_id as varchar(75)) as id_product ,
        cast(quantity as integer) as quantity,
        _fivetran_synced AS raw_timestamp_load

    from src_order_items

)

select * from renamed_order_items