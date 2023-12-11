with

src_promos as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

renamed_promos as (

    select
        initcap(cast(promo_id as varchar(50))) as promo_id,
        cast(discount as integer) as discount,
        initcap(cast(status as varchar(50))) as status,
        _fivetran_synced as date_load

    from src_promos

    union all

    select
        'Without Promotion',
        0,
        'Inactive',
        '2023-11-11T11:11:35.244000-08:00'

),

final_promos as (
    select 
        {{ dbt_utils.generate_surrogate_key(['promo_id']) }} AS id_promo,
        promo_id AS promo_name,
        discount,
        status,
        date_load

from renamed_promos
)

select * from final_promos
