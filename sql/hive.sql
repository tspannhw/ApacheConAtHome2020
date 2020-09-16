CREATE TABLE provenancehive
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
   componentType STRING);

CREATE TABLE hv_stocks
(
  uuid STRING NOT NULL,
  `datetime` STRING,
  `symbol` STRING, 
  `open` STRING, 
  `close` STRING,
  `high` STRING,
  `volume` STRING,
  `low` STRING,
   PRIMARY KEY (UUID) DISABLE NOVALIDATE);
