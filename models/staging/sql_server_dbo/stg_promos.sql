with

source as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

renamed_promos as (

    select
        {{ dbt_utils.generate_surrogate_key(['promo_id']) }} as promo_id,
        cast(promo_id as varchar(50)) as desc_promo,
        cast(discount as number(10,0)) as discount,
        cast(status as varchar(50)) as status,
        _fivetran_deleted as date_deleted,
        _fivetran_synced as date_load

from source

)

select * from renamed_promos
union all
select
'999',
'Sin Promo',
0,
'inactive',
null,
null
