with 

src_users as (

    select * from {{ source('sql_server_dbo', 'users') }}

),

renamed_users as (

    select
        cast(user_id as varchar(75)) as id_user,
        cast(address_id as varchar(75)) as id_address,
        cast(first_name as varchar(75)) as first_name,
        cast(last_name as varchar(75)) as last_name,
        cast(phone_number as varchar(75)) as phone_number,
        cast(email as varchar(75)) as email,
        created_at as created_profile,
        updated_at as updated_profile,
        _fivetran_synced AS raw_timestamp_load

    from src_users

)

select * from renamed_users