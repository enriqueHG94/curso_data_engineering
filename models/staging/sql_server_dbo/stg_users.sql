with 

source as (

    select * from {{ source('sql_server_dbo', 'users') }}

),

renamed_users as (

    select
        user_id,
        address_id,
        first_name,
        last_name,
        phone_number,
        email,
        created_at,
        updated_at,
        total_orders,
        _fivetran_deleted AS date_deleted,
        _fivetran_synced AS date_load

    from source

)

select * from renamed_users
