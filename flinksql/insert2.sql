INSERT INTO global_sensor_events 
SELECT 
	scada.uuid, 
	scada.systemtime ,  
scada.temperaturef , 
scada.pressure , 
scada.humidity , 
scada.lux , 
scada.proximity , 
scada.oxidising , 
scada.reducing , 
scada.nh3 , 
scada.gasko,
energy.`current`, 
energy.voltage ,
energy.`power` ,
energy.`total`,
energy.fanstatus

FROM energy,
     scada
WHERE
    scada.systemtime = energy.systemtime;
