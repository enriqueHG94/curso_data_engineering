with 

src_addresses as (

    select * from {{ source('sql_server_dbo', 'addresses') }}

),

renamed_addresses as (

    select
        cast(address_id as varchar(75)) as id_address,
        cast(address as varchar(75)) as address,
        cast(zipcode as integer) as zipcode,
        cast(state as varchar(75)) as state,
        cast(country as varchar(75)) as country,
        _fivetran_synced AS raw_timestamp_load -- Para monitorear a partir de que día empieza a reproducirse cierta casuística.
    from src_addresses

)

select * from renamed_addresses
