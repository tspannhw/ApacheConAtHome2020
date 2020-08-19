# See Detached SQL queries (-u) and catalogs
# https://ci.apache.org/projects/flink/flink-docs-stable/dev/table/sqlClient.html
# https://ci.apache.org/projects/flink/flink-docs-release-1.11/dev/table/catalogs.html

flink-sql-client embedded -e /opt/demo/ApacheConAtHome2020/conf/sql-env-insert.yaml -u "
insert into krogerprices
select upc,updatedate,itemdescription,brandname,CAST(price as float) as price, UUID() as uuid
from itemprice
where originstore = 'kroger';"
