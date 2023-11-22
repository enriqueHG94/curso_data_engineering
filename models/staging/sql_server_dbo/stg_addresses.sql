with 

source as (

    select * from {{ source('sql_server_dbo', 'addresses') }}

),

renamed_addresses as (

    select
        cast(address_id as varchar(75)) as id_address,
        cast(address as varchar(75)) as address,
        cast(zipcode as integer) as zipcode,
        cast(state as varchar(75)) as state,
        cast(country as varchar(75)) as country,
        _fivetran_synced AS date_load
    from source

)

select * from renamed_addresses
