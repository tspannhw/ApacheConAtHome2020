# Migrate Parameter Context + Parameters

# Backup from Dev, see https://www.datainmotion.dev/2020/09/devops-working-with-parameter-contexts.html
#/Users/tspann/Downloads/nifi-toolkit-1.12.0/bin/cli.sh nifi export-param-context -u http://localhost:8080  --paramContextId 3a801ff4-1f73-1836-b59c-b9fbc79ab030 -ot json -o retail.json

# Import Context to Our Demo Server
/Users/tspann/Downloads/nifi-toolkit-1.12.0/bin/cli.sh nifi import-param-context -u http://edge2ai-1.dim.local:8080 -i retail.json
