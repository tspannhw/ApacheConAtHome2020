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

# GET the list of alert policies created
http://edge2ai-1.dim.local:9991/api/v1/admin/alertPolicy
