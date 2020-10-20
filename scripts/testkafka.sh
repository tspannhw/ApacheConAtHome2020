kafka-topics --create --partitions 16 --replication-factor 1 --zookeeper $(hostname -f):2181/kafka --topic transaction.log.1

CREATE TABLE ItemTransactions (
	transactionId    BIGINT,
	ts    BIGINT,
	itemId    STRING,
	quantity INT,
	event_time AS CAST(from_unixtime(floor(ts/1000)) AS TIMESTAMP(3)),
	WATERMARK FOR event_time AS event_time - INTERVAL '5' SECOND
) WITH (
	'connector.type'    	 = 'kafka',
	'connector.version' 	 = 'universal',
	'connector.topic'   	 = 'transaction.log.1',
	'connector.startup-mode' = 'earliest-offset',
	'connector.properties.bootstrap.servers' = 'edge2ai-1.dim.local:9092',
	'format.type' = 'json'
);

CREATE TABLE WindowedQuantity (
	window_start    TIMESTAMP(3),
	itemId    STRING,
	volume INT
) WITH (
	'connector.type'    	 = 'kafka',
	'connector.version' 	 = 'universal',
	'connector.topic'   	 = 'transaction.output.log',
	'connector.properties.bootstrap.servers' = 'edge2ai-1.dim.local:9092',
	'format.type' = 'json'
);

INSERT INTO WindowedQuantity
SELECT TUMBLE_START(event_time, INTERVAL '10' SECOND) as window_start, itemId, sum(quantity) as volume
FROM ItemTransactions
GROUP BY itemId, TUMBLE(event_time, INTERVAL '10' SECOND);

CREATE TABLE Queries (
	queryId    BIGINT,
	ts    BIGINT,
	itemId    STRING,
	event_time AS CAST(from_unixtime(floor(ts/1000)) AS TIMESTAMP(3)),
	WATERMARK FOR event_time AS event_time - INTERVAL '5' SECOND
) WITH (
	'connector.type'    	 = 'kafka',
	'connector.version' 	 = 'universal',
	'connector.topic'   	 = 'query.input.log.1',
	'connector.startup-mode' = 'earliest-offset',
	'connector.properties.bootstrap.servers' = 'edge2ai-1.dim.local:9092',
	'format.type' = 'json'
);

CREATE TABLE QueryResult (
  queryId    BIGINT,
	query_time    TIMESTAMP(3),
	itemId    STRING,
	quantity INT
) WITH (
	'connector.type'    	 = 'kafka',
	'connector.version' 	 = 'universal',
	'connector.topic'   	 = 'query.output.log',
	'connector.properties.bootstrap.servers' = 'edge2ai-1.dim.local:9092',
	'format.type' = 'json'
);

INSERT INTO QueryResult
SELECT
  q.queryId,
  TUMBLE_START(q.event_time, INTERVAL '1' SECOND) as query_time,
  t.itemId,
  sum(t.quantity) AS quantity
FROM
  ItemTransactions AS t,
  Queries AS q
WHERE
  t.itemId = q.itemId AND
  t.event_time BETWEEN q.event_time - INTERVAL '1' MINUTE AND q.event_time
GROUP BY
  t.itemId, q.queryId, TUMBLE(q.event_time, INTERVAL '1' SECOND);
  
  
SELECT * FROM (
  SELECT * ,
  ROW_NUMBER() OVER (
    PARTITION BY window_start
    ORDER BY num_transactions desc
  ) AS rownum
  FROM (
    SELECT TUMBLE_START(event_time, INTERVAL '10' MINUTE) AS window_start, itemId, COUNT(*) AS num_transactions
    FROM ItemTransactions
    GROUP BY itemId, TUMBLE(event_time, INTERVAL '10' MINUTE)
  )
)
WHERE rownum <=3;
