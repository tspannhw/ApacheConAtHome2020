"""
Common utilities for Python scripts
"""

import logging
import re
import requests
import time
import os
import sys
from inspect import getmembers
from contextlib import contextmanager
from datetime import datetime
from nipyapi import config, canvas, versioning, nifi, utils, system
from nipyapi.nifi.rest import ApiException
import nipyapi

# 2020 Thanks Dan
dev_nifi_port = 8080
dev_reg_port = 18080
dev_nifi_url = 'http://edge2ai-1.dim.local:' + str(dev_nifi_port) + '/nifi'
dev_reg_url = 'http://edge2ai-1.dim.local:' + str(dev_reg_port) + '/nifi-registry'
dev_nifi_api_url = dev_nifi_url + '-api'
dev_reg_api_url = dev_reg_url + '-api'

# edge2ai-1.dim.local
config.nifi_config.host = 'http://edge2ai-1.dim.local:8080/nifi-api'
config.registry_config.host = 'http://edge2ai-1.dim.local:18080/nifi-registry-api'
nipyapi.config.nifi_config.host = 'http://edge2ai-1.dim.local:8080/nifi-api'
config.nifi_config.host = 'http://edge2ai-1.dim.local:8080/nifi-api'

# Get Registry Bucket
sensor_bucket = versioning.get_registry_bucket('SensorFlows')
print("=====")
print("bucket %s", sensor_bucket)
print("=====")

if not sensor_bucket:
   sensor_bucket = versioning.create_registry_bucket('SensorFlows')

# if you change it, back it up for migration
# Backup a Flow
#dlx = versioning.get_flow_version(sensor_bucket.identifier, 'e6d35be3-3073-405e-9c0d-46c8f980bf10', version=None, export=True) 
# Export Flow Version
#xprt = versioning.export_flow_version(sensor_bucket.identifier, 'e6d35be3-3073-405e-9c0d-46c8f980bf10', version=None, file_path='/opt/demo/ApacheConAtHome2020/flows/ApacheConDemos.json', mode='json')
#print(dlx)
#print(xprt)

# Create Flow
versionedFlow = versioning.create_flow(sensor_bucket.identifier, 'ApacheConDemos', flow_desc='ApacheConDemos', flow_type='Flow')

print("=====")
print("versioned flow %s", versionedFlow)
print("=====")

# Import Flow Version
#versionedFlowSnapshot = versioning.import_flow_version(sensor_bucket.identifier, flow_id=versionedFlow.identifier, file_path='/opt/demo/ApacheConAtHome2020/flows/ApacheConDemos.json')

#print("=====")
#print("loaded %s", versionedFlowSnapshot)
#print("=====")

# List Flows
#print(versioning.list_flows_in_bucket(sensor_bucket.identifier))
#print("=====")
 
# Load the flow to the nifi server
# process-groups/8d2f8d59-0174-1000-63a6-2036b2061094/process-groups
#utils.set_endpoint('http://edge2ai-1.dim.local:18080/nifi-registry-api')
#registryID = versioning.get_registry_client("Registry").id
#new_pg = versioning.deploy_flow_version(rootPgId, location,sensor_bucket.identifier,registryID, versionedFlow.identifier ) 
prod_ver_flow_name = 'ApacheConDemos'
prod_reg_client_name = 'NiFi Registry'
#utils.set_endpoint(dev_nifi_api_url)
#versioning.create_registry_client(
#        name=prod_reg_client_name,
#        uri='http://localhost:18080',
#        description=''
#)     
#flow = nipyapi.versioning.get_flow_in_bucket(
#        bucket_id=sensor_bucket.identifier,
#        identifier=prod_ver_flow_name
#)
#reg_client = versioning.get_registry_client(prod_reg_client_name)
#versioning.deploy_flow_version(
#        parent_id=canvas.get_root_pg_id(),
#        location=(800, 200),
#        bucket_id=sensor_bucket.identifier,
#        flow_id=versionedFlow.identifier,
#        reg_client_id=versioning.get_registry_client(prod_reg_client_name).id,
#        version=None
#)
      
# Set parameters
# Maybe CLI
# https://github.com/Chaffelson/nipyapi/blob/master/nipyapi/demo/fdlc.py

#>> bucketID = nipyapi.versioning.get_registry_bucket(bucketName).identifier
#>>> workflowID = nipyapi.versioning.get_flow_in_bucket(bucketID, workflowName).identifier
#>>> registryID = nipyapi.versioning.get_registry_client("Registry").id
#>>> ver = 1
#>>> location = (200, 200)

# NiFi Status
# print(system.get_system_diagnostics())
# print(system.get_nifi_version_info())

#registry create-flow -verbose -u http://edge2ai-1.dim.local:18080 -b 250a5ae5-ced8-4f4e-8b3b-01eb9d47a0d9 --flowName iotFlow
#registry import-flow-version -verbose -u http://somesite.compute-1.amazonaws.com:18080 -f a5a4ac59-9aeb-416e-937f-e601ca8beba9 -i flows/iot-1.json
# registry list-flows  -u http://ec2-35-171-154-174.compute-1.amazonaws.com:18080 -b 250a5ae5-ced8-4f4e-8b3b-01eb9d47a0d9
