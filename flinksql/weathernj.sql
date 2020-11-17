
INSERT INTO weathernj 
SELECT CAST(`location` as STRING) `location`, 
CAST(station_id as STRING) station_id,
     latitude,
     longitude,
CAST(observation_time as STRING) observation_time,
CAST(weather as STRING) weather,
CAST(temperature_string as STRING) temperature_string, 
     temp_f,
     temp_c,
     relative_humidity,
CAST(wind_string  as STRING) wind_string,
CAST(wind_dir as STRING) wind_dir,
     wind_degrees,
     wind_mph,
     wind_kt, 
     pressure_in,
CAST(dewpoint_string as STRING) dewpoint_string,
     dewpoint_f,
     dewpoint_c
FROM weather
WHERE
    `location` is not null and `location` <> 'null' and trim(`location`) <> '' and `location` like '%NJ';
