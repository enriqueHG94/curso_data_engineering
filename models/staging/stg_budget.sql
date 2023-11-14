{{
  config(
    materialized='table'
  )
}}

with 

source as (

    select * from {{ source('google_sheets', 'budget') }}

),

budget_table as (

    select
        _row,
        quantity,
        month,
        product_id,
        _fivetran_synced

    from source

)

select * from budget_table
