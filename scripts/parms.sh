bin/cli.sh nifi list-param-contexts -u http://localhost:8080 -ot simple
#/Users/tspann/Downloads/nifi-toolkit-1.12.0/bin/cli.sh nifi export-param-context -u http://localhost:8080  --paramContextId a13e3764-134c-16f0-7c35-312b7ee4b182 -ot json -o financial.json

tspann@MacBook-Pro nifi-toolkit-1.12.0 % cat restore.sh 
/Users/tspann/Downloads/nifi-toolkit-1.12.0/bin/cli.sh nifi import-param-context -u http://edge2ai-1.dim.local:8080 -i retail.json
