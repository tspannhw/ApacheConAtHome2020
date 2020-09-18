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

