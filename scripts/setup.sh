clear

echo "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
echo "┃ Starting to create all the demo   ┃"
echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
echo " *** Thanks Paul Vidal *** "
echo " *** Thanks Andre *** "
echo " *** Thanks Dan ***"
echo ""
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo "⏱  $(date +%H%Mhrs)"
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo ""
echo ""

# Run NiFi setupnifi.sh

# TODO
# Build NiFi Atlas Connection
# https://www.datainmotion.dev/2020/02/connecting-apache-nifi-to-apache-atlas.html

# Add NiFi SQL Reporting Tasks for JVM, Provenance, ...
# Add NiFi HTTP Listener for Kafka Alerts
# Build Kafka Alerts / Notifier

# Repos

yum -y install git curl wget

# Andre's script 

cd /tmp/resources
./reset-to-lab.sh 12

# Created for edge2ai

cd /opt/demo

git clone https://github.com/tspannhw/meetup-sensors
git clone https://github.com/tspannhw/FlinkSQLDemo
git clone https://github.com/tspannhw/ApacheConAtHome2020
git clone https://github.com/tspannhw/retail-dynamic-shelf-pricing
git clone https://github.com/tspannhw/SmartWeather
git clone https://github.com/tspannhw/ClouderaPublicCloudCDFWorkshop
git clone https://github.com/tspannhw/SmartStocks

chmod -R 777 /opt/demo/SmartStocks
chmod -R 777 /opt/demo/FlinkSQLDemo
chmod -R 777 /opt/demo/meetup-sensors
chmod -R 777 /opt/demo/ApacheConAtHome2020
chmod -R 777 /opt/demo/retail-dynamic-shelf-pricing

# No Kerberos 

echo ""
echo ""
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo " Build HDFS Directories"
echo ""
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo ""
echo ""

HADOOP_USER_NAME=hdfs hdfs dfs -mkdir /user/admin
HADOOP_USER_NAME=hdfs hdfs dfs -mkdir /user/root
HADOOP_USER_NAME=hdfs hdfs dfs -chown root:root /user/root
HADOOP_USER_NAME=hdfs hdfs dfs -chown admin:admin /user/admin
HADOOP_USER_NAME=hdfs hdfs dfs -chmod -R 777 /user
HADOOP_USER_NAME=hdfs hdfs dfs -mkdir /user/kafka
HADOOP_USER_NAME=hdfs hdfs dfs -mkdir /tmp/sensors
HADOOP_USER_NAME=hdfs hdfs dfs -chmod -R 777 /tmp/sensors
HADOOP_USER_NAME=hdfs hdfs dfs -chown kafka:kafka /user/kafka
HADOOP_USER_NAME=hdfs hdfs dfs -chown kafka:kafka /tmp/sensors
HADOOP_USER_NAME=hdfs hdfs dfs -mkdir /tmp/itemprice
HADOOP_USER_NAME=hdfs hdfs dfs -chmod -R 777 /tmp/itemprice
HADOOP_USER_NAME=hdfs hdfs dfs -chown kafka:kafka /tmp/itemprice
HADOOP_USER_NAME=hdfs hdfs dfs -mkdir /tmp/twitter
HADOOP_USER_NAME=hdfs hdfs dfs -chmod -R 777 /tmp/twitter
HADOOP_USER_NAME=hdfs hdfs dfs -chown kafka:kafka /tmp/twitter
HADOOP_USER_NAME=hdfs hdfs dfs -mkdir /tmp/globaltwitter
HADOOP_USER_NAME=hdfs hdfs dfs -chmod -R 777 /tmp/globaltwitter
HADOOP_USER_NAME=hdfs hdfs dfs -chown kafka:kafka /tmp/globaltwitter
HADOOP_USER_NAME=hdfs hdfs dfs -mkdir /tmp/stocks
HADOOP_USER_NAME=hdfs hdfs dfs -chmod -R 777 /tmp/stocks
HADOOP_USER_NAME=hdfs hdfs dfs -chmod -R 777 /warehouse/tablespace/managed/hive
HADOOP_USER_NAME=hdfs hdfs dfs -mkdir -p /iextradingnews
HADOOP_USER_NAME=hdfs hdfs dfs -mkdir -p /iextradingquote
HADOOP_USER_NAME=hdfs hdfs dfs -mkdir -p /iextradingchart
HADOOP_USER_NAME=hdfs hdfs dfs -mkdir -p /stocks
HADOOP_USER_NAME=hdfs hdfs dfs -mkdir -p /cyber
HADOOP_USER_NAME=hdfs hdfs dfs -mkdir /tmp/weatherapp
HADOOP_USER_NAME=hdfs hdfs dfs -mkdir -p /tmp/spl
HADOOP_USER_NAME=hdfs hdfs dfs -chmod -R 777 /tmp/spl
HADOOP_USER_NAME=hdfs hdfs dfs -mkdir -p /user/tspann/prices
HADOOP_USER_NAME=hdfs hdfs dfs -chmod -R 777 /user/tspann/prices
HADOOP_USER_NAME=hdfs hdfs dfs -chmod -R 777 /tmp/weatherapp
HADOOP_USER_NAME=hdfs hdfs dfs -chmod -R 777 /
HADOOP_USER_NAME=hdfs hdfs dfs -chmod -R 777 /warehouse/tablespace/managed/hive/

# Need permissions for hive tables
# Permission denied: user=nifi, access=EXECUTE, inode="/warehouse/tablespace/managed/hive/hv_stocks":hive:hive:drwxrwx---


cd /opt/demo/ApacheConAtHome2020

echo ""
echo ""
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo "Build HBase Tables"
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo ""
echo ""
hbase shell /opt/demo/ApacheConAtHome2020/hbase/tables.tbl 

echo ""
echo ""
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo " Building Kudu Impala Tables"
echo ""
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo ""
echo ""

# Build Kudu tables

impala-shell -i edge2ai-1.dim.local -d default -f  /opt/demo/ApacheConAtHome2020/sql/kudu.sql 

echo ""
echo ""
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo " Building Apache Hive ORC Tx Tables"
echo ""
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo ""
echo ""

# Build Hive Tables
beeline -u jdbc:hive2://edge2ai-1.dim.local:10000/default -f /opt/demo/ApacheConAtHome2020/sql/hive.sql

# Postgresql Tables
# Phoenix Tables
# Druid Tables
# HBase Tables
# MySQL Tables
# External ORC Hive Tables
# Parquet Impala Tables
# CREATE EXTERNAL TABLE ingest_existing_files LIKE PARQUET '/user/etl/destination/datafile1.dat'
#  STORED AS PARQUET
#  LOCATION '/user/etl/destination';
  
echo ""
echo ""
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo " Building Schemas"
echo ""
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo ""
echo ""

#
# Get Schema Registry URL
curl -X GET "http://edge2ai-1.dim.local:8585/api/v1/admin/schemas/registryInfo" -H "accept: application/json"

echo ""
echo ""

# Load Schemas into Schema Registry
# https://registry-project.readthedocs.io/en/latest/schema-registry.html#api-examples
# http://edge2ai-1.dim.local:7788/swagger

for f in /opt/demo/ApacheConAtHome2020/schemas/*.avsc
do 

echo "Uploading Schema File $f"
schemaname="`echo $f | awk -F'[/.]' '{print $(NF-1)}'`"
echo "Schema [$schemaname]"
echo ""

curl -X POST "http://edge2ai-1.dim.local:7788/api/v1/schemaregistry/schemas" -H "accept: application/json" -H "Content-Type: application/json" -d "{ \"type\": \"avro\", \"schemaGroup\": \"Kafka\", \"name\": \"$schemaname\", \"description\": \"schemaname\", \"compatibility\": \"BOTH\", \"validationLevel\": \"LATEST\"}"

echo ""

# Upload body

curl -X POST "http://edge2ai-1.dim.local:7788/api/v1/schemaregistry/schemas/$schemaname/versions/upload?branch=MASTER&disableCanonicalCheck=false" -H "accept: application/json" -H "Content-Type: multipart/form-data" -F "file=@/opt/demo/ApacheConAtHome2020/schemas/$schemaname.avsc;type=application/json" -F "description=schemaname"

echo "Added."
echo ""

done


echo ""
echo ""
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo "Integrate Flink and Atlas"
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo ""

# Atlas Flink Integration
#
#curl -k -u admin:supersecret1 --location --request POST 'http://edge2ai-1.dim.local:31000/api/atlas/v2/types/typedefs' \
#--header 'Content-Type: application/json' \
#--data-raw '{

# Kafka Topics (SMM or NiFi could auto build)

echo ""
echo ""
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo "Kafka Topics"
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo ""
echo ""

for f in /opt/demo/ApacheConAtHome2020/schemas/*.avsc
do 

schemaname="`echo $f | awk -F'[/_.]' '{print $(NF-1)}'`"
echo "Creating Kafka Topic [$schemaname]"
echo ""

/opt/cloudera/parcels/CDH/bin/kafka-topics --create --bootstrap-server edge2ai-1.dim.local:9092 --replication-factor 1 --partitions 1 --topic $schemaname

done

/opt/cloudera/parcels/CDH/bin/kafka-topics --create --bootstrap-server edge2ai-1.dim.local:9092 --replication-factor 1 --partitions 1 --topic global_sensor_events


# Kafka Connect
# https://docs.cloudera.com/runtime/7.2.0/smm-rest-api-reference/index.html#/Kafka_Connect_operations
# Uses SMM REST API
# http://edge2ai-1.dim.local:8585/swagger

echo ""
echo ""
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo "Kafka Connect"
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo ""
echo ""

curl -X GET "http://edge2ai-1.dim.local:8585/api/v1/admin/metrics/producers?state=all&duration=LAST_THIRTY_DAYS" -H "accept: application/json"

echo ""
echo ""

# Is Kafka Connect Configured
# TODO check = false
curl -X GET "http://edge2ai-1.dim.local:8585/api/v1/admin/kafka-connect/is-configured" -H "accept: application/json"

echo ""
echo ""

# Check to see if HDFS Sink is there
curl -X GET "http://edge2ai-1.dim.local:8585/api/v1/admin/kafka-connect/connector-plugins" -H "accept: application/json"

echo ""
echo ""

# load that file TODO
# itemprice is connector name

for f in /opt/demo/ApacheConAtHome2020/kafkaconnect/*.json
do 

schemaname="`echo $f | awk -F'[/_.]' '{print $(NF-1)}'`"
echo "Creating Kafka Connectors for each [$schemaname]"
echo ""

curl -X PUT "http://edge2ai-1.dim.local:8585/api/v1/admin/kafka-connect/connectors/$schemaname" -H "accept: application/json" -H "Content-Type: application/json" -d @/opt/demo/ApacheConAtHome2020/kafkaconnect/$schemaname.json

done

echo ""
echo ""

# Check Service
curl -X GET "http://edge2ai-1.dim.local:8585/api/v1/admin/kafka-connect/connectors" -H "accept: application/json"

echo ""
echo ""

# Check KC Metrics
curl -X GET "http://ec2-54-167-28-79.compute-1.amazonaws.com:8585/api/v1/admin/metrics/connect/workers" -H "accept: application/json"

# Build Alerts
# edge2ai-1.dim.local

echo ""
echo ""
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo "Build Kafka Alerts"
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo ""
echo ""

curl -X GET "http://edge2ai-1.dim.local:9991/api/v1/admin/alert/notifications?limit=11&startOffset=-1"

# POST to build A Notifier

curl -X POST "http://edge2ai-1.dim.local:9991/api/v1/admin/notifiers" -H "accept: application/json" -H "Content-Type: application/json" -d '{"id":null,"name":"http","description":"http","notifierProviderId":"http","rateLimiterConfig":{"count":1,"duration":"MINUTE"},"config":{"URL":"http://edge2ai-1.dim.local:9999/alerts","ConnectionTimeoutInMilliSecs":30000,"ReadTimeoutInMilliSecs":30000}}'

echo ""

# GET to list that notifier
curl -X GET "http://edge2ai-1.dim.local:9991/api/v1/admin/notifiers"

echo ""

# POST to Add a new alert Policy
for f in /opt/demo/ApacheConAtHome2020/alerts/*.json
do 
  echo "Load alert $f"
  curl -X POST "http://edge2ai-1.dim.local:8585/api/v1/admin/alertPolicy" -H "accept: application/json" -H "Content-Type: application/json" -d @$f
  echo ""
done


# GET the list of alert policies created
curl -X GET "http://edge2ai-1.dim.local:9991/api/v1/admin/alertPolicy"

# To Disable all policies, iterate all policies, go by id
# http://edge2ai-1.dim.local:9991/api/v1/admin/alertPolicy/45/disable

# To DELETE all policies, iterate all policies, go by id
# http://edge2ai-1.dim.local:9991/api/v1/admin/alertPolicy/6

echo ""
echo ""
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo "Flink SQL Setup"
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo ""
echo ""

# Flink SQL Session

flink-yarn-session -tm 2048 -s 2 -d

# Starts Flink SQL

# flink-sql-client embedded -e /opt/demo/ApacheConAtHome2020/conf/sql-env.yaml

echo ""
echo ""
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo "Server NiFi Flow Setup"
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo ""
echo ""

# Get Toolkit
#wget https://archive.apache.org/dist/nifi/1.11.4/nifi-toolkit-1.11.4-bin.tar.gz
#tar -xvf nifi-toolkit*.tar.gz
#/opt/demo/ApacheConAtHome2020/scripts/nifi-toolkit-1.11.4/bin/cli.sh registry list-buckets -u http://edge2ai-1.dim.local:18080
#registry create-flow -verbose -u http://edge2ai-1.dim.local:18080 -b 250a5ae5-ced8-4f4e-8b3b-01eb9d47a0d9 --flowName iotFlow
#registry import-flow-version -verbose -u http://somesite.compute-1.amazonaws.com:18080 -f a5a4ac59-9aeb-416e-937f-e601ca8beba9 -i flows/iot-1.json
# registry list-flows  -u http://ec2-35-171-154-174.compute-1.amazonaws.com:18080 -b 250a5ae5-ced8-4f4e-8b3b-01eb9d47a0d9
# https://www.datainmotion.dev/2020/03/using-nifi-cli-to-restore-nifi-flows.html
# https://www.datainmotion.dev/2019/09/backup-and-restore-nifi-registry.html

# Get NiFi Python API
# https://pypi.org/project/nipyapi/
# already installed as part of My Setup
# pip3 install nipyapi
# python3 loadflow.py

# Restore NiFi Flow
# Add parameter context and parameters
# https://www.datainmotion.dev/2020/09/devops-working-with-parameter-contexts.html

# Final HDFS Check (demo only, use Apache Ranger in SDX for real workloads).
HADOOP_USER_NAME=hdfs hdfs dfs -chmod -R 777 /

# Stop MiNiFi and EFM
/opt/cloudera/cem/minifi-0.6.0.1.2.1.0-24/bin/minifi.sh stop
/opt/cloudera/cem/efm/bin/efm.sh stop

# Run NiFi Parms Load
source /opt/demo/ApacheConAtHome2020/scripts/setupnifi.sh

# Get Postgresql jdbc
cd /opt/demo

wget https://jdbc.postgresql.org/download/postgresql-42.2.18.jar

echo ""
echo ""
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo ""
echo "Completed."
echo ""
echo "⏱  $(date +%H%Mhrs)"
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
