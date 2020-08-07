# Repos

clear

yum -y install git curl wget

cd /tmp/resources
./reset-to-lab.sh 12

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

# Build Kudu tables

impala-shell -i edge2ai-1.dim.local -d default -f ../sql/kudu.sql 

# Get Schema Registry URL
curl -X GET "http://edge2ai-1.dim.local:8585/api/v1/admin/schemas/registryInfo" -H "accept: application/json"

# Load Schemas into Schema Registry
# https://registry-project.readthedocs.io/en/latest/schema-registry.html#api-examples
# http://edge2ai-1.dim.local:7788/swagger

# upload schema name
curl -X POST "http://edge2ai-1.dim.local:7788/api/v1/schemaregistry/schemas" -H "accept: application/json" -H "Content-Type: application/json" -d "{ \"type\": \"avro\", \"schemaGroup\": \"Kafka\", \"name\": \"test\", \"description\": \"test\", \"compatibility\": \"BOTH\", \"validationLevel\": \"LATEST\"}"

# Upload body
# /test/ - schema name
curl -X POST "http://edge2ai-1.dim.local:7788/api/v1/schemaregistry/schemas/test/versions/upload?branch=MASTER&disableCanonicalCheck=false" -H "accept: application/json" -H "Content-Type: multipart/form-data" -F "file=@itemprice.avsc.txt;type=application/json" -F "description=test"

# curl -vX POST http://server/api/v1/places.json -d @../schemas/test.avsc --header "Content-Type: application/json"

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

# Kafka Connect
# https://docs.cloudera.com/runtime/7.2.0/smm-rest-api-reference/index.html#/Kafka_Connect_operations
# Uses SMM REST API
# http://edge2ai-1.dim.local:8585/swagger

# Is Kafka Connect Configured
# TODO check = false
curl -X GET "http://edge2ai-1.dim.local:8585/api/v1/admin/kafka-connect/is-configured" -H "accept: application/json"

# Check to see if HDFS Sink is there
curl -X GET "http://edge2ai-1.dim.local:8585/api/v1/admin/kafka-connect/connector-plugins" -H "accept: application/json"

# load that file TODO
curl -X PUT "http://edge2ai-1.dim.local:8585/api/v1/admin/kafka-connect/connectors/itemprice" -H "accept: application/json" -H "Content-Type: application/json" -d "{ \"connector.class\": \"com.cloudera.dim.kafka.connect.hdfs.HdfsSinkConnector\", \"hdfs.uri\": \"hdfs://edge2ai-1.dim.local:8020\", \"tasks.max\": \"1\", \"topics\": \"itemprice\", \"value.converter.schema.registry.url\": \"http://edge2ai-1.dim.local:7788/api/v1\", \"value.converter.passthrough.enabled\": \"true\", \"hdfs.output\": \"/tmp/itemprice/\", \"output.avro.passthrough.enabled\": \"true\", \"hadoop.conf.path\": \"file:///etc/hadoop/conf\", \"name\": \"itemprice\", \"output.writer\": \"com.cloudera.dim.kafka.connect.partition.writers.avro.AvroPartitionWriter\", \"value.converter\": \"com.cloudera.dim.kafka.connect.converts.AvroConverter\", \"output.storage\": \"com.cloudera.dim.kafka.connect.hdfs.HdfsPartitionStorage\", \"key.converter\": \"org.apache.kafka.connect.storage.StringConverter\"}"

# Check Service
curl -X GET "http://edge2ai-1.dim.local:8585/api/v1/admin/kafka-connect/connectors" -H "accept: application/json"

# Check KC Metrics
curl -X GET "http://ec2-54-167-28-79.compute-1.amazonaws.com:8585/api/v1/admin/metrics/connect/workers" -H "accept: application/json"

# Flink SQL

flink-yarn-session -tm 2048 -s 2 -d

flink-sql-client embedded -e ../conf/sql-env.yaml
