with 

source as (

    select * from {{ source('sql_server_dbo', 'addresses') }}

),

renamed_addresses as (

    select
        address_id,
        address,
        zipcode,
        state,
        country,
        _fivetran_deleted AS date_deleted,
        _fivetran_synced AS date_load

    from source

)

select * from renamed_addresses
