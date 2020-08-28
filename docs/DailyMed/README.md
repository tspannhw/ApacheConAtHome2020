How to Access DailyMed Data via XML, JSON, RSS REST Feeds / HTTP GET over SSL

## RSS

* https://dailymed.nlm.nih.gov/dailymed/rss-updates.cfm

* https://dailymed.nlm.nih.gov/dailymed/rss.cfm

## SupportingData

https://dailymed.nlm.nih.gov/dailymed/app-support-mapping-files.cfm

## Batch

* Download all labels    https://dailymed.nlm.nih.gov/dailymed/spl-resources-all-drug-labels.cfm

## Data

Grab up to 100 records then iterate to pages

pagesize=100&page=13

* All APIs https://dailymed.nlm.nih.gov/dailymed/app-support-web-services.cfm#restfulapi

* UUNIS API https://dailymed.nlm.nih.gov/dailymed/webservices-help/v2/uniis_api.cfm

https://dailymed.nlm.nih.gov/dailymed/services/v2/uniis.json

* RXCUIS API https://dailymed.nlm.nih.gov/dailymed/webservices-help/v2/rxcuis_api.cfm

https://dailymed.nlm.nih.gov/dailymed/services/v2/rxcuis.json?pagesize=100&page=2

* Drug Names API https://dailymed.nlm.nih.gov/dailymed/webservices-help/v2/drugnames_api.cfm

https://dailymed.nlm.nih.gov/dailymed/services/v2/drugnames.json

* App #s API https://dailymed.nlm.nih.gov/dailymed/webservices-help/v2/applicationnumbers_api.cfm

https://dailymed.nlm.nih.gov/dailymed/services/v2/applicationnumbers.json
https://dailymed.nlm.nih.gov/dailymed/services/v2/applicationnumbers.json?pagesize=100&page=13

* Drug Classes API https://dailymed.nlm.nih.gov/dailymed/webservices-help/v2/drugclasses_api.cfm

https://dailymed.nlm.nih.gov/dailymed/services/v2/drugclasses.json

* SPLS API https://dailymed.nlm.nih.gov/dailymed/webservices-help/v2/spls_api.cfm

https://dailymed.nlm.nih.gov/dailymed/services/v2/spls.json

* NDCS  API https://dailymed.nlm.nih.gov/dailymed/webservices-help/v2/ndcs_api.cfm

https://dailymed.nlm.nih.gov/dailymed/services/v2/ndcs.json


*** Example Use Case

Download daily extracts from FTP and unzip.

Grab daily news from RSS to get what's changed.

Use setid to get more data.

https://dailymed.nlm.nih.gov/dailymed/services/v2/spls.json?setid=9256d3b2-50eb-4091-bbcd-1982865fb998&pagesize=5000

Also Grab SPL
https://dailymed.nlm.nih.gov/dailymed/services/v2/spls/9256d3b2-50eb-4091-bbcd-1982865fb998.xml

Grab SPL Media
https://dailymed.nlm.nih.gov/dailymed/services/v2/spls/9256d3b2-50eb-4091-bbcd-1982865fb998/media.json
This will produce data with URL to jpegs or other mime_types, download these.

https://dailymed.nlm.nih.gov/dailymed/image.cfm?setid=9256d3b2-50eb-4091-bbcd-1982865fb998&name=mm3.jpg

Get ndcs for it
https://dailymed.nlm.nih.gov/dailymed/services/v2/spls/9256d3b2-50eb-4091-bbcd-1982865fb998/ndcs.json
This one supports the next_page paradigm that we can use to navigate through many pages.

Get packaging for it

https://dailymed.nlm.nih.gov/dailymed/services/v2/spls/9256d3b2-50eb-4091-bbcd-1982865fb998/packaging.json

Get all spl version information

https://dailymed.nlm.nih.gov/dailymed/services/v2/spls/9256d3b2-50eb-4091-bbcd-1982865fb998/history.json
This one supports the next_page paradigm that we can use to navigate through many pages.

 
 



