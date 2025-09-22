
{{ config(
    materialized='incremental',
    unique_key='State_Name',
    incremental_strategy='insert_overwrite',
    on_schema_change='ignore'
) }}

select
    State_Name,
    State_Abbreviation
from {{ ref('Stage_State') }}

