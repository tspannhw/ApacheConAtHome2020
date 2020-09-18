# https://nifi.apache.org/docs/nifi-docs/html/toolkit-guide.html

# Get Toolkit

#wget https://archive.apache.org/dist/nifi/1.11.4/nifi-toolkit-1.11.4-bin.tar.gz

#tar -xvf nifi-toolkit*.tar.gz
# /opt/demo/ApacheConAtHome2020/scripts/nifi-toolkit-1.11.4/bin/cli.sh session set nifi.props /var/run/cloudera-scm-agent/process/1546334108-nifi-NIFI_NODE/nifi.properties
#/opt/demo/ApacheConAtHome2020/scripts/nifi-toolkit-1.11.4/bin/cli.sh session set nifi.reg.props /var/run/cloudera-scm-agent/process/1546334114-nifiregistry-NIFI_REGISTRY_SERVER/nifi-registry.properties

#/opt/demo/ApacheConAtHome2020/scripts/nifi-toolkit-1.11.4/bin/cli.sh registry list-buckets -u http://edge2ai-1.dim.local:18080
/opt/demo/ApacheConAtHome2020/scripts/nifi-toolkit-1.11.4/bin/cli.sh demo quick-import -i /opt/demo/ApacheConAtHome2020/flows/ApacheConDemos.json --nifiProps /opt/demo/ApacheConAtHome2020/scripts/nifi.props --nifiRegProps /opt/demo/ApacheConAtHome2020/scripts/nifi.props
 
