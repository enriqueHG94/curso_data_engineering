{{
  config(
    materialized='table'
  )
}}

with 

source as (

    select * from {{ source('sql_server_dbo', 'order_items') }}

),

order_items_table as (

    select
        order_id,
        product_id,
        quantity,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from order_items_table
