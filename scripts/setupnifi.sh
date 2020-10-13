  
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

# yum -y install git curl wget gunzip gzip tar

# /opt/demo/nifi-toolkit-1.12.0/bin/cli.sh nifi import-param-context -u http://localhost:8080 -i retail.json
# https://nifi.apache.org/docs/nifi-docs/html/toolkit-guide.html

echo "Download NiFi Toolkit"

# Download NiFi Toolkit
#
# cd /opt/demo
# wget https://apache.claz.org/nifi/1.12.1/nifi-toolkit-1.12.1-bin.tar.gz
# gunzip nifi-toolkit-1.12.1-bin.tar.gz
# tar -xvf nifi-toolkit-1.12.1-bin.tar

echo "Load Parameter Contexts"

for f in /opt/demo/ApacheConAtHome2020/parameters/*.json
do 

echo "Uploading Parameter File $f"

/opt/demo/nifi-toolkit-1.12.0/bin/cli.sh nifi import-param-context -u http://edge2ai-1.dim.local:8080 -i $f

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
