{{ config(materialized='table') }}

--select
 --row_number() over (order by State_Name) as State_ID,
 --State_Name,
 --State_Abbreviation
--from {{ ref('Stage_State') }}

select
 {{ dbt_utils.generate_surrogate_key (
    ['State_Name']
 )}} as State_ID
 State_Name,
 State_Abbreviation
from {{ ref('Stage_State') }}