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

# TODO
# Build NiFi Atlas Connection
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
HADOOP_USER_NAME=hdfs hdfs dfs -mkdir /tmp/stocks
HADOOP_USER_NAME=hdfs hdfs dfs -chmod -R 777 /tmp/stocks
HADOOP_USER_NAME=hdfs hdfs dfs -chmod -R 777 /warehouse/tablespace/managed/hive
HADOOP_USER_NAME=hdfs hdfs dfs -mkdir -p /iextradingnews
HADOOP_USER_NAME=hdfs hdfs dfs -mkdir -p /iextradingquote
HADOOP_USER_NAME=hdfs hdfs dfs -mkdir -p /iextradingchart
HADOOP_USER_NAME=hdfs hdfs dfs -mkdir -p /stocks
HADOOP_USER_NAME=hdfs hdfs dfs -mkdir -p /cyber
HADOOP_USER_NAME=hdfs hdfs dfs -chmod -R 777 /

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
schemaname="`echo $f | awk -F'[/_.]' '{print $(NF-1)}'`"
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

curl -k -u admin:supersecret1 --location --request POST 'http://edge2ai-1.dim.local:31000/api/atlas/v2/types/typedefs' \
--header 'Content-Type: application/json' \
--data-raw '{
    "enumDefs": [],
    "structDefs": [],
    "classificationDefs": [],
    "entityDefs": [
        {
            "name": "flink_application",
            "superTypes": [
                "Process"
            ],
            "serviceType": "flink",
            "typeVersion": "1.0",
            "attributeDefs": [
                {
                    "name": "id",
                    "typeName": "string",
                    "cardinality": "SINGLE",
                    "isIndexable": true,
                    "isOptional": false,
                    "isUnique": true
                },
                {
                    "name": "startTime",
                    "typeName": "date",
                    "cardinality": "SINGLE",
                    "isIndexable": false,
                    "isOptional": true,
                    "isUnique": false
                },
                {
                    "name": "endTime",
                    "typeName": "date",
                    "cardinality": "SINGLE",
                    "isIndexable": false,
                    "isOptional": true,
                    "isUnique": false
                },
                {
                    "name": "conf",
                    "typeName": "map<string,string>",
                    "cardinality": "SINGLE",
                    "isIndexable": false,
                    "isOptional": true,
                    "isUnique": false
                },
                {
                    "name": "inputs",
                    "typeName": "array<string>",
                    "cardinality": "LIST",
                    "isIndexable": false,
                    "isOptional": false,
                    "isUnique": false
                },
                {
                    "name": "outputs",
                    "typeName": "array<string>",
                    "cardinality": "LIST",
                    "isIndexable": false,
                    "isOptional": false,
                    "isUnique": false
                }
            ]
        }
    ],
    "relationshipDefs": []
}'

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
#/opt/cloudera/parcels/CDH/bin/kafka-topics --create --bootstrap-server edge2ai-1.dim.local:9092 --replication-factor 1 --partitions 1 --topic energy
#/opt/cloudera/parcels/CDH/bin/kafka-topics --create --bootstrap-server edge2ai-1.dim.local:9092 --replication-factor 1 --partitions 1 --topic scada
#/opt/cloudera/parcels/CDH/bin/kafka-topics --create --bootstrap-server edge2ai-1.dim.local:9092 --replication-factor 1 --partitions 1 --topic itemprice

done

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
echo ""
echo "Completed."
echo ""
echo "⏱  $(date +%H%Mhrs)"
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
