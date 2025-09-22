select Day_Date,County,State,FIPS,Cases,Deaths 
from {{source('Stage_Covid','Stage_County_Information')}}

