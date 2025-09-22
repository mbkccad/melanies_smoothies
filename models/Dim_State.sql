


{{ config(
    materialized='incremental',
    unique_key='state'
) }}

select
    State_Name,
    State_Abbreviation
from {{ ref('Stage_State') }}


