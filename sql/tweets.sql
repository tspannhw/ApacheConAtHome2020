# select dayofweek(time), count(dayofweek(`time`)) as Count from sentiment_tweets group by dayofweek(`time`)
# to_timestamp('2019-Oct-14 20:00:01.027898', 'yyyy-MMM-dd HH:mm:ss.SSSSSS');


select dayofweek(to_timestamp(time,'yyyy-MMM-dd HH:mm:ss.SSSSSS')), unixtime, `timestamp`, msg from sentiment_tweets

https://impala.apache.org/docs/build/html/topics/impala_datetime_functions.html#datetime_functions

https://docs.cloudera.com/documentation/enterprise/latest/topics/impala_datetime_functions.html#datetime_functions__to_timestamp

select from_unixtime(CAST(STRLEFT(unixtime,LENGTH(unixtime)-3) as bigint), 'yyyy-MM-dd HH:mm:ss'), unixtime, time, `timestamp`
from sentiment_tweets
where unixtime is not null

                              select dayofweek(from_unixtime(CAST(STRLEFT(unixtime,LENGTH(unixtime)-3) as bigint), 'yyyy-MM-dd HH:mm:ss')), 
count(dayofweek(from_unixtime(CAST(STRLEFT(unixtime,LENGTH(unixtime)-3) as bigint), 'yyyy-MM-dd HH:mm:ss'))) as Count 
from sentiment_tweets 
group by dayofweek(from_unixtime(CAST(STRLEFT(unixtime,LENGTH(unixtime)-3) as bigint), 'yyyy-MM-dd HH:mm:ss'))
                                 
select 'Privacy Rule X2YZ applies', count(user_name) from rawpostsunicef group by user_name order by count(user_name) DESC
                                 
 select sentiment, count(sentiment) from rawpostsunicef group by sentiment
                                 
                                 
