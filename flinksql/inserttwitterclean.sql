INSERT INTO globaltwitter 
SELECT friends_count, tweet_id, source, `time` as systemtime, location, sentiment
FROM twitter
WHERE
    sentiment is not null and sentiment <> 'null' and trim(sentiment) <> '';
