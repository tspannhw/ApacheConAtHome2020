# select dayofweek(time), count(dayofweek(`time`)) as Count from sentiment_tweets group by dayofweek(`time`)
# to_timestamp('2019-Oct-14 20:00:01.027898', 'yyyy-MMM-dd HH:mm:ss.SSSSSS');


select dayofweek(to_timestamp(time,'yyyy-MMM-dd HH:mm:ss.SSSSSS')), unixtime, `timestamp`, msg from sentiment_tweets

https://impala.apache.org/docs/build/html/topics/impala_datetime_functions.html#datetime_functions

https://docs.cloudera.com/documentation/enterprise/latest/topics/impala_datetime_functions.html#datetime_functions__to_timestamp

