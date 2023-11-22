with

source as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

renamed_promos as (

    select
        {{ dbt_utils.generate_surrogate_key(['promo_id']) }} as id_promo,
        initcap(cast(promo_id as varchar(50))) as desc_promo,
        cast(discount as integer) as discount,
        initcap(cast(status as varchar(50))) as status,
        _fivetran_synced as date_load

from source

)

select * from renamed_promos
union all
select
{{ dbt_utils.generate_surrogate_key(['999']) }},
'Sin promo',
0,
'Inactive',
null