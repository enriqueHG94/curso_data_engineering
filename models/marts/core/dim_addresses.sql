with 

stg_addresses as (

    select * from {{ ref('stg_addresses') }}

),

final_addresses as (

    select
        id_address,
        address,
        zipcode,
        state,
        country
    from stg_addresses

)

select * from final_addresses
