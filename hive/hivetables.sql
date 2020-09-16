CREATE EXTERNAL TABLE IF NOT EXISTS iextradingchart (`date` STRING, open DOUBLE, high DOUBLE, low DOUBLE, close DOUBLE, volume INT, unadjustedVolume INT, change DOUBLE, changePercent DOUBLE, vwap DOUBLE, label STRING, changeOverTime INT)
STORED AS ORC
LOCATION '/iextradingchart';

CREATE EXTERNAL TABLE IF NOT EXISTS iextradingquote (symbol STRING, companyName STRING, primaryExchange STRING, sector STRING, calculationPrice STRING, open DOUBLE, openTime BIGINT, close DOUBLE, closeTime BIGINT, high DOUBLE, low DOUBLE, latestPrice DOUBLE, latestSource STRING, latestTime STRING, latestUpdate BIGINT, latestVolume INT, iexRealtimePrice DOUBLE, iexRealtimeSize INT, iexLastUpdated BIGINT, delayedPrice DOUBLE, delayedPriceTime BIGINT, extendedPrice DOUBLE, extendedChange DOUBLE, extendedChangePercent DOUBLE, extendedPriceTime BIGINT, previousClose DOUBLE, change DOUBLE, changePercent DOUBLE, iexMarketPercent DOUBLE, iexVolume INT, avgTotalVolume INT, iexBidPrice INT, iexBidSize INT, iexAskPrice INT, iexAskSize INT, marketCap INT, peRatio DOUBLE, week52High DOUBLE, week52Low DOUBLE, ytdChange DOUBLE) 
STORED AS ORC
LOCATION '/iextradingquote';

CREATE EXTERNAL TABLE IF NOT EXISTS iextradingnews (`datetime` STRING, headline STRING, source STRING, url STRING, summary STRING, related STRING, image STRING) 
STORED AS ORC 
LOCATION '/iextradingnews';
