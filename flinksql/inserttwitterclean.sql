INSERT INTO global_twitter 
SELECT tweet_id, sentiment, location, `time` as systemtime, source, friends_count
FROM twitter
WHERE
    sentiment is not null;
