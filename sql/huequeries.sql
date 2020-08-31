select version, setid, pubdate, title, link, guid, description
from spl
order by pubdate desc;


select `location`, observation_time, latitude,longitude,temperature_string, weather, pressure_string
from weatherkudu
where `location` like '%NJ%'
order by observation_time desc;
