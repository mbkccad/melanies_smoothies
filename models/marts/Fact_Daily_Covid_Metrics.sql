{{ config(materialized='table') }}

select
    d.date_id as date_id
    ,ds.state_id
    ,dc.county_id
    ,c.cases
    ,c.cases - lag(c.cases) over (partition by c.county, s.state_name order by d.full_date) as new_cases
    ,c.deaths
    ,c.deaths - lag(c.deaths) over (partition by c.county, s.state_name order by d.full_date) as new_deaths
from {{ref('Stage_County')}} c --edw_covid.covid.stage_county c
join {{ref('Stage_State')}} s -- edw_covid.covid.stage_state s
    on c.state = s.state_name
join {{ref('Dim_Date')}} d --edw_covid.covid.dim_date d
    on c.day_date = d.full_date    
left join {{ref('Dim_State')}} ds --edw_covid.covid.dim_state ds 
on ds.state_name = s.state_name  
left join {{ref('Dim_County')}} dc --edw_covid.covid.dim_county dc 
on dc.county_name = c.county and dc.state_abbreviation = ds.state_abbreviation
