

select State as State_Name,State_Abbreviation as State_Abbreviation
from {{source('Stage_Covid','Stage_State')}}
--stage_covid.stage.Stage_State



