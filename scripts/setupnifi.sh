  
clear

echo "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
echo "┃ Starting to load NiFi Paramters   ┃"
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

yum -y install git curl wget gunzip gzip tar

# /opt/demo/nifi-toolkit-1.12.0/bin/cli.sh nifi import-param-context -u http://localhost:8080 -i retail.json
# https://nifi.apache.org/docs/nifi-docs/html/toolkit-guide.html

echo "Download NiFi Toolkit"

# Download NiFi Toolkit
#
cd /opt/demo
wget https://apache.claz.org/nifi/1.12.1/nifi-toolkit-1.12.1-bin.tar.gz
tar -xvf /opt/demo/nifi-toolkit-1.12.1-bin.tar.gz 

echo "Load Parameter Contexts"

for f in /opt/demo/ApacheConAtHome2020/parameters/*.json
do 

echo "Uploading Parameter File $f"

/opt/demo/nifi-toolkit-1.12.1/bin/cli.sh nifi import-param-context -u http://edge2ai-1.dim.local:8080 -i $f

echo "Added."
echo ""

done

echo ""
echo ""
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
echo ""
echo "Completed."
echo ""
echo "⏱  $(date +%H%Mhrs)"
echo "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"

# sequence

/opt/demo/nifi-toolkit-1.12.1/bin/cli.sh nifi pg-enable-services  -u http://edge2ai-1.dim.local:8080 --processGroupId root  

/opt/demo/nifi-toolkit-1.12.1/bin/cli.sh nifi pg-enable-services  -u http://edge2ai-1.dim.local:8080 --processGroupId root  

/opt/demo/nifi-toolkit-1.12.1/bin/cli.sh nifi pg-enable-services  -u http://edge2ai-1.dim.local:8080 --processGroupId root  

# List all process groups

/opt/demo/nifi-toolkit-1.12.1/bin/cli.sh nifi pg-list -u http://edge2ai-1.dim.local:8080   

# List parms

/opt/demo/nifi-toolkit-1.12.1/bin/cli.sh nifi list-param-contexts -u http://edge2ai-1.dim.local:8080 -verbose  

# Set parameters to pgs
# pgid => parameter group id
# pcid => parameter context id

# manual for now
# /opt/demo/nifi-toolkit-1.12.1/bin/cli.sh nifi pg-set-param-context -u http://edge2ai-1.dim.local:8080 -verbose -pgid 2c1860b3-7f21-36f4-a0b8-b415c652fc62  -pcid 39f0f296-0177-1000-ffff-ffffdccb6d90


# List / Start / Check Process Groups

# nifi pg-list -u http://edge2ai-1.dim.local:8080   
# nifi pg-start -u http://edge2ai-1.dim.local:8080 -verbose -pgid a8e90c68-0e06-3421-9701-c93e1b4d0647
# nifi pg-status  -u http://edge2ai-1.dim.local:8080 -verbose -pgid a8e90c68-0e06-3421-9701-c93e1b4d0647  


# Rest Checks

# curl 'http://edge2ai-1.dim.local:8080/nifi-api/flow/parameter-contexts'

# http://edge2ai-1.dim.local:8080/nifi-api/flow/process-groups/269deb08-0177-1000-4de1-fb797c52b003

# nifi pg-enable-services  -u http://edge2ai-1.dim.local:8080 --processGroupId 269deb08-0177-1000-4de1-fb797c52b003

# can i add a nifi query reporting task?

# nifi create-reporting-task -u http://edge2ai-1.dim.local:8080 -verbose -i
# nifi start-reporting-tasks -help  

# can i create atlas lineage?

