# 2017 load pictures and analyze
# https://github.com/tspannhw/mxnet_rpi/blob/master/analyze.py
#!/usr/bin/python
#
# Copyright (c) 2019, NVIDIA CORPORATION. All rights reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#
import time
import sys
import datetime
import subprocess
import sys
import os
import datetime
import traceback
import math
import base64
import json
from time import gmtime, strftime
import random, string
import time
from time import gmtime, strftime
import random, string
import psutil
import base64
import uuid
# Importing socket library 
import socket 

import jetson.inference
import jetson.utils

import argparse

external_IP_and_port = ('198.41.0.4', 53)  # a.root-servers.net
socket_family = socket.AF_INET

def IP_address():
        try:
            s = socket.socket(socket_family, socket.SOCK_DGRAM)
            s.connect(external_IP_and_port)
            answer = s.getsockname()
            s.close()
            return answer[0] if answer else None
        except socket.error:
            return None

# Get MAC address of a local interfaces
def psutil_iface(iface):
    # type: (str) -> Optional[str]
    import psutil
    nics = psutil.net_if_addrs()
    if iface in nics:
        nic = nics[iface]
        for i in nic:
            if i.family == psutil.AF_LINK:
                return i.address
# Random Word
def randomword(length):
 return ''.join(random.choice("ABCDEFGHIJKLMNOPQRSTUVWXYZ".lower()) for i in range(length))

# Timer
start = time.time()
packet_size=3000

# parse the command line
parser = argparse.ArgumentParser(description="Classify a live camera stream using an image recognition DNN.",
                                                   formatter_class=argparse.RawTextHelpFormatter, epilog=jetson.inference.imageNet.Usage())
parser.add_argument("file_in", type=str, default="image.jpg", help="filename of the input image to process")
parser.add_argument("--network", type=str, default="googlenet", help="pre-trained model to load, see below for options")
parser.add_argument("--camera", type=str, default="/dev/video0", help="index of the MIPI CSI camera to use (NULL for CSI camera 0),\nor for VL42 cameras the /dev/video node to use (/dev/video0).\nby default, MIPI CSI camera 0 will be used.")
parser.add_argument("--width", type=int, default=1280, help="desired width of camera stream (default is 1280 pixels)")
parser.add_argument("--height", type=int, default=720, help="desired height of camera stream (default is 720 pixels)")

opt, argv = parser.parse_known_args()

width = 1280
height=720
dnetwork = "googlenet"

head_tail = os.path.split(opt.camera)

camera = head_tail[1]

# Create unique id
uniqueid = 'xav_uuid_{0}_{1}_{2}'.format(camera,randomword(3),strftime("%Y%m%d%H%M%S",gmtime()))
uuid = '{0}_{1}_{2}'.format(camera,strftime("%Y%m%d%H%M%S",gmtime()),uuid.uuid4())

host_name = socket.gethostname()
host_ip = socket.gethostbyname(host_name)

# image output
filename = '/home/nvidia/nvme/images/img_{0}_{1}_{2}.jpg'.format(camera,randomword(3),strftime("%Y%m%d%H%M%S",gmtime()))
filename2 = '/home/nvidia/nvme/images/out_{0}_{1}_{2}.jpg'.format(camera,randomword(3),strftime("%Y%m%d%H%M%S",gmtime()))

# /opt/demo/images

# CPU Temp
f = open("/sys/devices/virtual/thermal/thermal_zone1/temp","r")
cputemp = str( f.readline() )
cputemp = cputemp.replace('\n','')
cputemp = cputemp.strip()
cputemp = str(round(float(cputemp)) / 1000)
cputempf = str(round(9.0/5.0 * float(cputemp) + 32))
f.close()
# GPU Temp
f = open("/sys/devices/virtual/thermal/thermal_zone2/temp","r")
gputemp = str( f.readline() )
gputemp = gputemp.replace('\n','')
gputemp = gputemp.strip()
gputemp = str(round(float(gputemp)) / 1000)
gputempf = str(round(9.0/5.0 * float(gputemp) + 32))
f.close()
 
# load the recognition network
net = jetson.inference.imageNet(dnetwork, argv)

# Debug off
net.EnableDebug()

# create the camera and display
camera = jetson.utils.gstCamera(width, height, opt.camera)
camera.Open()

img, width, height = camera.CaptureRGBA(zeroCopy=1)
#img, width, height = jetson.utils.loadImageRGBA(filename)
# classify the image
class_idx, confidence = net.Classify(img, width, height)

# save raw file
jetson.utils.saveImageRGBA(filename, img, width, height)
# find the object description
class_desc = net.GetClassDesc(class_idx)

ipaddress = IP_address()

font = jetson.utils.cudaFont(size=jetson.utils.adaptFontSize(width))
font.OverlayText(img, width, height, "{:f}% {:s}".format(confidence * 100, class_desc), 10, 10, font.White, font.Gray40)
jetson.utils.cudaDeviceSynchronize()
jetson.utils.saveImageRGBA(filename2, img, width, height)
net.PrintProfilerTimes()
end = time.time()
row = { }

row['uuid'] =  uniqueid
row['camera'] = str(opt.camera)
row['ipaddress']=ipaddress
row['networktime'] = net.GetNetworkTime() 
row['top1pct'] =  (confidence * 100)
row['top1'] =  class_desc 
row['cputemp'] =  cputemp 
row['gputemp'] =  gputemp 
row['gputempf'] =  gputempf
row['cputempf'] =  cputempf
row['runtime'] = str(round(end - start)) 
row['host'] = os.uname()[1]
row['camera'] = opt.camera
row['filename'] = filename2
row['imageinput'] = filename
row['host_name'] = host_name
row['macaddress'] = psutil_iface('wlan0')
row['end'] = '{0}'.format( str(end ))
row['te'] = '{0}'.format(str(end-start))
row['systemtime'] = datetime.datetime.now().strftime('%m/%d/%Y %H:%M:%S')
row['cpu'] = psutil.cpu_percent(interval=1)
usage = psutil.disk_usage("/")
row['diskusage'] = "{:.1f} MB".format(float(usage.free) / 1024 / 1024)
row['memory'] = psutil.virtual_memory().percent
row['id'] = str(uuid)
json_string = json.dumps(row)
fa=open("/home/nvidia/nvme/logs/demo1.log", "a+")
fa.write(json_string + "\n")
fa.close()
