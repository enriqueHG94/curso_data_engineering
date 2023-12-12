with 

stg_budget as (

    select * from {{ ref('stg_budget') }}

),

final_budget as (
    select
        _row,
        id_product,
        quantity,
        month
    from stg_budget
)

select * from final_budget