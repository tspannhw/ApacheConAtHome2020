CREATE EXTERNAL TABLE stocksparquet
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
STORED AS PARQUET
LOCATION '/tmp/stocks/stocks3';
