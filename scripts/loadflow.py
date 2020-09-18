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

nipyapi.config.nifi_config.host = 'http://edge2ai-1.dim.local:8080/nifi-api'
nipyapi.config.registry_config.host = 'http://edge2ai-1.dim.local:18080/nifi-registry-api'

# Get Registry Bucket
sensor_bucket = versioning.get_registry_bucket('SensorFlows')

if not sensor_bucket:
   sensor_bucket = versioning.create_registry_bucket('SensorFlows')
        
# Get NiFi root PG
root_pg = canvas.get_process_group(canvas.get_root_pg_id(), 'id')

# Create Flow
versionedFlow = versioning.create_flow(sensor_bucket, 'ApacheConDemos', flow_desc='ApacheConDemos', flow_type='Flow')

# Import Flow Version
versionedFlowSnapshot = versioning.import_flow_version(sensor_bucket, flow_id=versionedFlow, flow_name='ApacheConDemos')

# List Flows
print(versioning.list_flows_in_bucket(sensor_bucket))

#registry create-flow -verbose -u http://edge2ai-1.dim.local:18080 -b 250a5ae5-ced8-4f4e-8b3b-01eb9d47a0d9 --flowName iotFlow
#registry import-flow-version -verbose -u http://somesite.compute-1.amazonaws.com:18080 -f a5a4ac59-9aeb-416e-937f-e601ca8beba9 -i flows/iot-1.json
# registry list-flows  -u http://ec2-35-171-154-174.compute-1.amazonaws.com:18080 -b 250a5ae5-ced8-4f4e-8b3b-01eb9d47a0d9
