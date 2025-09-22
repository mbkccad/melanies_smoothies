{{ config(materialized='table') }}

with distinct_county_name as (

    select county,state from {{ref('Stage_County')}} group by county,state
)



-- select 
--  row_number() over (order by County) as County_ID,
--  cc.County as County_Name,
--  ss.State_Abbreviation
-- from {{ ref('Stage_State') }} as ss 
-- join distinct_county_name as cc on cc.State = ss.State_Name


select 
 {{ dbt_utils.generate_surrogate_key(
    ['County','State_Abbreviation']
 )}} as County_ID,
 cc.County as County_Name,
 ss.State_Abbreviation
from {{ ref('Stage_State') }} as ss 
join distinct_county_name as cc on cc.State = ss.State_Name