
CREATE TABLE breakout ( uuid STRING,  `end` STRING, systemtime STRING, runtime STRING, cpu DOUBLE, id STRING, te STRING,  host STRING,
macaddress STRING,  diskusage STRING, memory DOUBLE, ipaddress STRING, 
host_name STRING, lsm303d_magnetometer STRING, BH1745_red STRING,
BH1745_blue STRING, lsm303d_accelerometer STRING, ltr559_prox STRING,
ltr559_lux STRING, VL53L1X_distance_in_mm STRING, BH1745_clear STRING,
BH1745_green STRING, bme680_tempc STRING, bme680_humidity STRING,
bme680_tempf STRING, bme680_pressure STRING,
starttime STRING, cputemp DOUBLE, imgnamep STRING, imgname STRING,
PRIMARY KEY (uuid)
)
PARTITION BY HASH PARTITIONS 4
STORED AS KUDU
TBLPROPERTIES ('kudu.num_tablet_replicas' = '1');

	

CREATE TABLE clouderastatus ( 
   `uuid` STRING,
	`ts` TIMESTAMP,  
`title` STRING, 
	`description` STRING, 
`pubdate` STRING, 
  `link` STRING,
  `guid` STRING,
PRIMARY KEY (`uuid`,`ts` ) )
PARTITION BY HASH PARTITIONS 4 
STORED AS KUDU TBLPROPERTIES ('kudu.num_tablet_replicas' = '1');

CREATE TABLE transcomevents ( 
uuid STRING, `ts` TIMESTAMP,  
`title` STRING, `description` STRING, 
`pubDate` STRING, 
`point` STRING,
PRIMARY KEY (uuid)
)
PARTITION BY HASH PARTITIONS 4
STORED AS KUDU
TBLPROPERTIES ('kudu.num_tablet_replicas' = '1');


   
   
CREATE TABLE itemprice
(
  upc STRING,
  originstore STRING,
  updatedate STRING,
  longdescription STRING,
  itemdescription STRING,
  brandname STRING,
  displayimage STRING, 
  price STRING,
  msrp STRING,
  tpr STRING,
PRIMARY KEY (upc, originstore, updatedate) ) 
PARTITION BY HASH PARTITIONS 4 
STORED AS KUDU TBLPROPERTIES ('kudu.num_tablet_replicas' = '1');

CREATE TABLE provenance
(
  eventId INT,
  timestampMillis INT,
  eventType STRING,
  durationMillis INT,
  lineageStart INT,
  details STRING,
  entityId STRING,
  entityType STRING,
  entitySize INT,
  componentName STRING,
   componentType STRING,
     contentPath STRING, 
  PRIMARY KEY (eventId,timestampMillis ) ) 
PARTITION BY HASH PARTITIONS 4
STORED AS KUDU TBLPROPERTIES ('kudu.num_tablet_replicas' = '1');
	
CREATE TABLE weatherkudu
(`location` STRING,`observation_time` STRING, `credit` STRING, `credit_url` STRING, `image` STRING, `suggested_pickup` STRING, `suggested_pickup_period` BIGINT,
`station_id` STRING, `latitude` DOUBLE, `longitude` DOUBLE,  `observation_time_rfc822` STRING, `weather` STRING, `temperature_string` STRING,
`temp_f` DOUBLE, `temp_c` DOUBLE, `relative_humidity` BIGINT, `wind_string` STRING, `wind_dir` STRING, `wind_degrees` BIGINT, `wind_mph` DOUBLE, `wind_gust_mph` DOUBLE, `wind_kt` BIGINT,
`wind_gust_kt` BIGINT, `pressure_string` STRING, `pressure_mb` DOUBLE, `pressure_in` DOUBLE, `dewpoint_string` STRING, `dewpoint_f` DOUBLE, `dewpoint_c` DOUBLE, `windchill_string` STRING,
`windchill_f` BIGINT, `windchill_c` BIGINT, `visibility_mi` DOUBLE, `icon_url_base` STRING, `two_day_history_url` STRING, `icon_url_name` STRING, `ob_url` STRING, `disclaimer_url` STRING,
`copyright_url` STRING, `privacy_policy_url` STRING,
PRIMARY KEY (`location`, `observation_time`)
)
PARTITION BY HASH PARTITIONS 4
STORED AS KUDU
TBLPROPERTIES ('kudu.num_tablet_replicas' = '1');

CREATE TABLE envirosensors 
(
uuid STRING, 
	systemtime STRING,  
	amplitude100 DOUBLE, 
        amplitude500 DOUBLE, 
	amplitude1000 DOUBLE, 
	lownoise DOUBLE, 
	midnoise DOUBLE,
        highnoise DOUBLE, 
	amps DOUBLE, 
	ipaddress STRING, 
	host STRING, 
	host_name STRING,
        macaddress STRING, 
	endtime STRING, 
	runtime STRING, 
	starttime STRING, 
        cpu DOUBLE, 
	cpu_temp STRING, 
	diskusage STRING, 
	memory DOUBLE, 
	id STRING, 
	temperature STRING, 
	adjtemp STRING, 
	adjtempf STRING, 
	temperaturef STRING, 
	pressure DOUBLE, 
	humidity DOUBLE, 
	lux DOUBLE, 
	proximity INT, 
	oxidising DOUBLE, 
	reducing DOUBLE, 
	nh3 DOUBLE, 
	gasko STRING,
 PRIMARY KEY (uuid) ) 
PARTITION BY HASH PARTITIONS 4 
STORED AS KUDU TBLPROPERTIES ('kudu.num_tablet_replicas' = '1');


CREATE TABLE energy 
(
uuid STRING, 
	systemtime STRING,  
        `current` INT, 
	voltage INT, 
	`power` INT, 
	`total` INT, 
	swver STRING, 
	hwver STRING,
	type STRING, 
	model STRING, 
	mac STRING, 
	deviceId STRING, 
	hwId STRING, 
	fwId STRING, 
	oemId STRING,
	alias STRING, 
	devname STRING, 
	iconhash STRING, 
	relaystate INT, 
	ontime INT, 
	activemode STRING, 
	feature STRING, 
	updating INT, 
	rssi INT, 
	ledoff INT, 
	latitude INT, 
	longitude INT, 
	`day` INT, 
	`index` INT, 
	zonestr STRING, 
	tzstr STRING, 
	dstoffset INT, 
	host STRING, 
	currentconsumption INT, 
	devicetime STRING, 
	ledon STRING, 
	fanstatus STRING, 
	`end` STRING, 
	te STRING, 
	cpu INT, 
	memory INT, 
	diskusage STRING,
 PRIMARY KEY (uuid) ) 
PARTITION BY HASH PARTITIONS 4 
STORED AS KUDU TBLPROPERTIES ('kudu.num_tablet_replicas' = '1');


CREATE TABLE global_sensor_events 
(uuid STRING, 
 systemtime STRING, 
 temperaturef STRING, 
 pressure DOUBLE, 
 humidity DOUBLE, 
 lux DOUBLE, 
 proximity INT, 
 oxidising DOUBLE, 
 reducing DOUBLE, 
 nh3 DOUBLE, 
 gasko STRING, 
 `current` INT, 
 voltage INT,
 `power` INT, 
 `total` INT, 
 fanstatus STRING,
  PRIMARY KEY (uuid) ) 
PARTITION BY HASH PARTITIONS 4 
STORED AS KUDU TBLPROPERTIES ('kudu.num_tablet_replicas' = '1');
 
 
CREATE TABLE spl
(
  setid STRING,
  version STRING,
  title STRING, 
  pubdate STRING, 
  link STRING,
  description STRING,
  guid STRING,
PRIMARY KEY (setID,version) ) 
PARTITION BY HASH PARTITIONS 4 
STORED AS KUDU TBLPROPERTIES ('kudu.num_tablet_replicas' = '1');

CREATE TABLE stocks
(
  uuid STRING,
  `datetime` STRING,
  `symbol` STRING, 
  `open` STRING, 
  `close` STRING,
  `high` STRING,
  `volume` STRING,
  `ts` TIMESTAMP,
  `dt`	 TIMESTAMP,
  `low` STRING,
PRIMARY KEY (uuid,`datetime`) ) 
PARTITION BY HASH PARTITIONS 4 
STORED AS KUDU TBLPROPERTIES ('kudu.num_tablet_replicas' = '1');


CREATE TABLE IF NOT EXISTS sentiment_tweets 
(tweet_id STRING, `unixtime` STRING, friends_count STRING, hashtags STRING, listed_count STRING, 
source STRING, favourites_count STRING, 
statuses_count STRING, followers_count STRING, `location` STRING, msg STRING, time STRING, sentiment STRING, 
user_name STRING, placename STRING, retweet_count STRING, 
user_mentions_name STRING, geo STRING, urls STRING, countryCode STRING, user_url STRING,
place STRING, coordinates STRING, handle STRING, profile_image_url STRING, time_zone STRING,
 ext_media STRING, user_description STRING,  `media_url` STRING,`timestamp` STRING, user_mentions STRING,
PRIMARY KEY (tweet_id, `unixtime`)
)
PARTITION BY HASH PARTITIONS 4
STORED AS KUDU
TBLPROPERTIES ('kudu.num_tablet_replicas' = '1');



CREATE TABLE webrequests
(
  uuid STRING,
  msgdate TIMESTAMP,
  controllerid STRING, 
  endpointid STRING, 
  remoteaddress STRING,
  sessionid STRING,
  message STRING,
  localaddress STRING,
PRIMARY KEY (uuid,msgdate) ) 
PARTITION BY HASH PARTITIONS 4 
STORED AS KUDU TBLPROPERTIES ('kudu.num_tablet_replicas' = '1');
