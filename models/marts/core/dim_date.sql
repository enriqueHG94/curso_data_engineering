with date as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2000-01-01' as date)",
        end_date="cast(current_date()+1 as date)"
    )
    }}  
)


select
    date_day as forecast_date, 
    year(date_day)*10000+month(date_day)*100+day(date_day) as date_id,
    year(date_day) as year, 
    month(date_day) as month, 
    monthname(date_day) as month_name,  
    year(date_day)*100+month(date_day) as year_month_id, 
    date_day-1 as previous_day, 
    year(date_day)||weekiso(date_day)||dayofweek(date_day) as year_week_day_id, 
    weekiso(date_day) as week_number,
    date_part(dow, date_day) as day_of_week_number,
    dayname(date_day) as day_of_week_name,
    quarter(date_day) as quarter_number,
    ceil(month(date_day)/6) as semester_number,
    case when month(date_day) >= 4 then year(date_day) else year(date_day) - 1 end as fiscal_year
from date
order by
    date_day desc
