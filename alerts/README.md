# Build Alerts
# edge2ai-1.dim.local


#GET 
http://edge2ai-1.dim.local:9991/api/v1/admin/alert/notifications?limit=11&startOffset=-1

# POST to build A Notifier
http://edge2ai-1.dim.local:9991/api/v1/admin/notifiers

{"id":null,"name":"http","description":"http","notifierProviderId":"http",
"rateLimiterConfig":{"count":1,"duration":"MINUTE"},
"config":{"URL":"http://edge2ai-1.dim.local:9999/alerts","ConnectionTimeoutInMilliSecs":30000,"ReadTimeoutInMilliSecs":30000}}

# GET to list that notifier
http://edge2ai-1.dim.local:9991/api/v1/admin/notifiers

# POST to Add a new alert Policy

http://edge2ai-1.dim.local:9991/api/v1/admin/alertPolicy

{"id":null,"name":"alert 1","description":"alert 1","enabled":true,"version":1,"executionIntervalInMillis":60000,"executionDelayInMillis":300000,"notifierIds":[1],"timestamp":1600287180171,"policy":"ALERT IF ( CLUSTER ONLINE_BROKER_COUNT <= 0 )"}

{"id":null,"name":"alert 2","description":"alert 2","enabled":true,"version":1,"executionIntervalInMillis":60000,"executionDelayInMillis":300000,"notifierIds":[1],"timestamp":1600287336868,"policy":"ALERT IF ( BROKER (name=\"1546333332\") IS_BROKER_DOWN = true )"}

{"id":null,"name":"alert 3","description":"alert 3","enabled":true,"version":1,"executionIntervalInMillis":60000,"executionDelayInMillis":300000,"notifierIds":[1],"timestamp":1600287415498,"policy":"ALERT IF ( ANY CONSUMER IS_CONSUMER_ACTIVE = false )"}

{"id":null,"name":"alert 4","description":"alert 4","enabled":true,"version":1,"executionIntervalInMillis":60000,"executionDelayInMillis":300000,"notifierIds":[1],"timestamp":1600287448792,"policy":"ALERT IF ( ANY CONSUMER CONSUMER_GROUP_LAG >= 120 )"}

{"id":null,"name":"alert 5","description":"alert 5","enabled":true,"version":1,"executionIntervalInMillis":60000,"executionDelayInMillis":300000,"notifierIds":[1],"timestamp":1600287511393,"policy":"ALERT IF ( ANY CONSUMER MILLISECONDS_LAPSED_SINCE_CONSUMER_WAS_ACTIVE >= 60000 )"}

{"id":null,"name":"alert 6","description":"alert 6","enabled":true,"version":1,"executionIntervalInMillis":60000,"executionDelayInMillis":300000,"notifierIds":[1],"timestamp":1600287540609,"policy":"ALERT IF ( ANY TOPIC UNDER_REPLICATED_PARTITIONS_COUNT >= 1 )"}

{"id":null,"name":"alert 7","description":"alert 7","enabled":true,"version":1,"executionIntervalInMillis":60000,"executionDelayInMillis":300000,"notifierIds":[1],"timestamp":1600287569319,"policy":"ALERT IF ( ANY TOPIC OUT_OF_SYNC_REPLICA_COUNT >= 1 )"}

{"id":null,"name":"alert 8","description":"alert 8","enabled":true,"version":1,"executionIntervalInMillis":60000,"executionDelayInMillis":300000,"notifierIds":[1],"timestamp":1600287627413,"policy":"ALERT IF ( ANY TOPIC BYTES_IN_PER_SEC <= 120 )"}

{"id":null,"name":"alert 9","description":"alert 9","enabled":true,"version":1,"executionIntervalInMillis":60000,"executionDelayInMillis":300000,"notifierIds":[1],"timestamp":1600287659267,"policy":"ALERT IF ( LATENCY (topic=\".*\", consumer=\".*\") END_TO_END_LATENCY >= 120 )"}

{"id":null,"name":"alert 10","description":"alert 10","enabled":true,"version":1,"executionIntervalInMillis":60000,"executionDelayInMillis":300000,"notifierIds":[1],"timestamp":1600287706360,"policy":"ALERT IF ( ANY PRODUCER MILLISECONDS_LAPSED_SINCE_PRODUCER_WAS_ACTIVE >= 600000 )"}

{"id":null,"name":"alert 11","description":"alert 11","enabled":true,"version":1,"executionIntervalInMillis":60000,"executionDelayInMillis":300000,"notifierIds":[1],"timestamp":1600287749642,"policy":"ALERT IF ( ANY PRODUCER IS_PRODUCER_ACTIVE != true )"}

{"id":null,"name":"alert 12","description":"alert 12","enabled":true,"version":1,"executionIntervalInMillis":60000,"executionDelayInMillis":300000,"notifierIds":[1],"timestamp":1600287792099,"policy":"ALERT IF ( CLUSTER_REPLICATION (cluster=\".*\") REPLICATION_STATUS != ACTIVE )"}

{"id":null,"name":"alert kafka connect weather","description":"alert kafka connect weather","enabled":true,"version":1,"executionIntervalInMillis":60000,"executionDelayInMillis":300000,"notifierIds":[1],"timestamp":1600287836840,"policy":"ALERT IF ( CONSUMER (name=\"connect-weather\") IS_CONSUMER_ACTIVE = false )"}

{"id":null,"name":"alert kafka connect itemprice","description":"alert kafka connect itemprice","enabled":true,"version":1,"executionIntervalInMillis":60000,"executionDelayInMillis":300000,"notifierIds":[1],"timestamp":1600287878310,"policy":"ALERT IF ( CONSUMER (name=\"connect-itemprice\") IS_CONSUMER_ACTIVE != true )"}

{"id":null,"name":"alert kafka connect producer-logs","description":"alert kafka connect producer-logs","enabled":true,"version":1,"executionIntervalInMillis":60000,"executionDelayInMillis":300000,"notifierIds":[1],"timestamp":1600287929540,"policy":"ALERT IF ( PRODUCER (name=\"connector-producer-logs-0\") IS_PRODUCER_ACTIVE != true )"}

# GET the list of alert policies created
http://edge2ai-1.dim.local:9991/api/v1/admin/alertPolicy

