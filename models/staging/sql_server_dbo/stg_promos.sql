with 

source as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

renamed_promos as (

    select
        promo_id,
        discount,
        status,
        _fivetran_deleted AS date_deleted,
        _fivetran_synced AS date_load

    from source

)

select * from renamed_promos
