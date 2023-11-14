{{
  config(
    materialized='table'
  )
}}

with 

source as (

    select * from {{ source('sql_server_dbo', 'addresses') }}

),

addresses_table as (

    select
        address_id,
        zipcode,
        country,
        address,
        state,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from addresses_table
