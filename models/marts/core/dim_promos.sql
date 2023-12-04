with 

stg_promos as (

    select * from {{ ref('stg_promos') }}

),

final_promos as (

    select
        id_promo,
        promo_name,
        discount,
        status
    from stg_promos

)

select * from final_promos
