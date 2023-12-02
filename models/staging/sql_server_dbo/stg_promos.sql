with

src_promos as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

renamed_promos as (

    select
        {{ dbt_utils.generate_surrogate_key(['promo_id']) }} as id_promo,
        initcap(cast(promo_id as varchar(50))) as desc_promo,
        cast(discount as integer) as discount,
        initcap(cast(status as varchar(50))) as status,
        _fivetran_synced as raw_timestamp_load

from src_promos

)

select * from renamed_promos
union all
select
'd41d8cd98f00b204e9800998ecf8427e',
'With Promo',
0,
'Inactive',
'2023-11-11T11:11:35.244000-08:00'