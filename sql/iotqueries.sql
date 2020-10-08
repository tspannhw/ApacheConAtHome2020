select uuid, `end`, systemtime, te, host, diskusage, memory, ipaddress, lsm303d_accelerometer, lsm303d_accelerometer, bme680_humidity, bme680_pressure, bme680_tempf, cputemp, imgnamep
from breakout
order by systemtime desc;

select * from envirosensors 
order by systemtime desc;
