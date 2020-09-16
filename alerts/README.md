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


# GET the list of alert policies created
http://edge2ai-1.dim.local:9991/api/v1/admin/alertPolicy

