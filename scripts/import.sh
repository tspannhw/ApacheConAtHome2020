# https://nifi.apache.org/docs/nifi-docs/html/toolkit-guide.html

# Get Toolkit

#wget https://archive.apache.org/dist/nifi/1.11.4/nifi-toolkit-1.11.4-bin.tar.gz

#tar -xvf nifi-toolkit*.tar.gz

/opt/demo/ApacheConAtHome2020/scripts/nifi-toolkit-1.11.4/bin/cli.sh registry list-buckets -u http://edge2ai-1.dim.local:18080
/opt/demo/ApacheConAtHome2020/scripts/nifi-toolkit-1.11.4/bin/cli.sh demo quick-import -i /opt/demo/ApacheConAtHome2020/flows/ApacheConDemos.json --nifiProps nifi.props --nifiRegProps reg.props
 
