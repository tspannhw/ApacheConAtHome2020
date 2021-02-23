# step one load backedup demo Flows from XML or JSON

/opt/demo/nifi-toolkit-1.12.1/bin/cli.sh nifi pg-enable-services --processGroupId root -u http://edge2ai-1.dim.local:8080 
/opt/demo/nifi-toolkit-1.12.1/bin/cli.sh nifi pg-enable-services --processGroupId root -u http://edge2ai-1.dim.local:8080 
/opt/demo/nifi-toolkit-1.12.1/bin/cli.sh nifi pg-enable-services --processGroupId root -u http://edge2ai-1.dim.local:8080 

# https://www.datainmotion.dev/2021/01/automating-starting-services-in-apache.html

/opt/demo/nifi-toolkit-1.12.1/bin/cli.sh nifi pg-list -u http://edge2ai-1.dim.local:8080   

/opt/demo/nifi-toolkit-1.12.1/bin/cli.sh nifi list-param-contexts -u http://edge2ai-1.dim.local:8080 -verbose  

# need to get pg id for stocks 2 and weather from list
# need to get pc from list

/opt/demo/nifi-toolkit-1.12.1/bin/cli.sh nifi pg-set-param-context -u http://edge2ai-1.dim.local:8080 -verbose -pgid 6add2d4c-28d0-36e6-b2ea-551affdcf6de -pcid cfc79628-0177-1000-0000-0000034fb27a

/opt/demo/nifi-toolkit-1.12.1/bin/cli.sh nifi pg-set-param-context -u http://edge2ai-1.dim.local:8080 -verbose -pgid 33a15479-6ab4-35a7-bde9-0fd19d780e59 -pcid cfc79628-0177-1000-0000-0000034fb27a

/opt/demo/nifi-toolkit-1.12.1/bin/cli.sh nifi pg-set-param-context -u http://edge2ai-1.dim.local:8080 -verbose -pgid 2a4e99f2-56e7-34df-85e1-b56b0f918dac  -pcid cfc79628-0177-1000-0000-0000034fb27a

/opt/demo/nifi-toolkit-1.12.1/bin/cli.sh nifi pg-enable-services --processGroupId root -u http://edge2ai-1.dim.local:8080 

