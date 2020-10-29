
INSERT INTO weathernj 
SELECT `location`, station_id,latitude,longitude,observation_time,weather,
temperature_string, temp_f,temp_c,relative_humidity,wind_string,wind_dir,wind_degrees,wind_mph,
wind_kt, pressure_in,dewpoint_string,dewpoint_f,dewpoint_c
FROM weather
WHERE
    `location` is not null and `location` <> 'null' and trim(`location`) <> '' and `location` like '%NJ';
