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
from nipyapi import config, canvas, versioning, nifi
from nipyapi.nifi.rest import ApiException
import nipyapi

# 2020 Thanks Dan

config.nifi_config.host = 'http://edge2ai-1.dim.local:8080/nifi-api'
config.registry_config.host = 'http://edge2ai-1.dim.local:18080/nifi-registry-api'
nipyapi.config.nifi_config.host = 'http://localhost:8080/nifi-api'
config.nifi_config.host = 'http://localhost:8080/nifi-api'

# Get Registry Bucket
sensor_bucket = versioning.get_registry_bucket('SensorFlows')
print("=====")
print("bucket %s", sensor_bucket)
print("=====")

if not sensor_bucket:
   sensor_bucket = versioning.create_registry_bucket('SensorFlows')

dlx = versioning.get_flow_version(sensor_bucket.identifier, 'c8f05073-4f6f-42c1-8152-9047c4519419', version=None, export=true)
  
# Export Flow Version
xprt = versioning.export_flow_version(sensor_bucket.identifier, 'c8f05073-4f6f-42c1-8152-9047c4519419', version=None, file_path='/opt/demo/flow.json', mode='json')


print(dlx)
print(xprt)

# Create Flow
versionedFlow = versioning.create_flow(sensor_bucket.identifier, 'ApacheConDemos', flow_desc='ApacheConDemos', flow_type='Flow')

print("=====")
print("versioned flow %s", versionedFlow)
print("=====")

# Import Flow Version
versionedFlowSnapshot = versioning.import_flow_version(sensor_bucket.identifier, flow_id=versionedFlow.identifier, flow_name='ApacheConDemos',  file_path='/opt/demo/ApacheConAtHome2020/flows/ApacheConDemos.json')



print("=====")
print("loaded %s", versionedFlowSnapshot)
print("=====")

# List Flows
print(versioning.list_flows_in_bucket(sensor_bucket.identifier))
print("=====")

# Maybeload XML template

# Load the flow to the nifi server
# ttp://ec2-3-95-163-2.compute-1.amazonaws.com:8080/nifi-api/process-groups/8d2f8d59-0174-1000-63a6-2036b2061094/process-groups

# NiFi Status
print(nipyapi.system.get_system_diagnostics())

print(nipyapi.system.get_nifi_version_info())

#registry create-flow -verbose -u http://edge2ai-1.dim.local:18080 -b 250a5ae5-ced8-4f4e-8b3b-01eb9d47a0d9 --flowName iotFlow
#registry import-flow-version -verbose -u http://somesite.compute-1.amazonaws.com:18080 -f a5a4ac59-9aeb-416e-937f-e601ca8beba9 -i flows/iot-1.json
# registry list-flows  -u http://ec2-35-171-154-174.compute-1.amazonaws.com:18080 -b 250a5ae5-ced8-4f4e-8b3b-01eb9d47a0d9
