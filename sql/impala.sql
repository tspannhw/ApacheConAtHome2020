CREATE EXTERNAL TABLE stocksparquet
(
    `symbol` STRING, 
  uuid STRING,
    `ts` BIGINT,
    `dt`	 BIGINT,
  `datetime` STRING,
  `open` STRING, 
  `close` STRING,
  `high` STRING,
  `volume` STRING,
  `low` STRING,
PRIMARY KEY (uuid,`datetime`) ) 
STORED AS PARQUET
LOCATION '/tmp/stocks/stocks3';


# Kafka Connect to parquet requires a schema without union types so no Nulls and no timestamps
