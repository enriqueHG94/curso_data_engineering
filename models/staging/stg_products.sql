{{
  config(
    materialized='table'
  )
}}

with 

source as (

    select * from {{ source('sql_server_dbo', 'products') }}

),

products_table as (

    select
        product_id,
        price,
        name,
        inventory,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from products_table
