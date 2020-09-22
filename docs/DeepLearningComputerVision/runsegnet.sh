#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H%M")
python3 -W ignore /home/nvidia/nvme/minifi-jetson-xavier/segnet.py --camera /dev/video0 2>/dev/null
