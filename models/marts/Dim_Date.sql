{{ config(materialized='table') }}

with date_spine as (
    select
        dateadd(day, seq4(), '2020-01-01'::date) as full_date
    from table(generator(rowcount => 2000))
)

select
    to_number(to_char(full_date, 'YYYYMMDD')) as date_id,
    full_date,
    extract(year from full_date) as year_number,
    decode(
        extract('dayofweek_iso', full_date),
        1, 'Monday',
        2, 'Tuesday', 
        3, 'Wednesday',
        4, 'Thursday',
        5, 'Friday',
        6, 'Saturday',
        7, 'Sunday'
    ) as weekday_name,
    extract(day from full_date) as day_of_month,
    extract(month from full_date) as month_of_year,
    to_char(full_date, 'MMMM') as month_name,
    extract(quarter from full_date) as quarter,
    case 
        when extract(dow from full_date) in (6, 0) 
        then true 
        else false 
    end as weekend_ind
from date_spine