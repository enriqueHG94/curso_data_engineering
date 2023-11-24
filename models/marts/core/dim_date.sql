with 

stg_fechas as (

    select * from {{ ref('stg_fechas') }}

),

final_fechas as (

    select
        id_date,
        fecha_forecast,
        anio,
        mes,
        desc_mes,
        id_anio_mes,
        dia_previo,
        anio_semana_dia,
        semana
    from stg_fechas

)

select * from final_fechas
