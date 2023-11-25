with 

stg_users as (

    select * from {{ ref('stg_users') }}

),

final_users as (

    select
        id_user,
        first_name,
        last_name,
        phone_number,
        email,
        created_profile,
        updated_profile
    from stg_users

)

select * from final_users
