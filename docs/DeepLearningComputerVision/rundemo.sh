#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H%M")
python3 -W ignore /home/nvidia/nvme/minifi-jetson-xavier/demo.py --camera /dev/video0 --network googlenet /home/nvidia/nvme/images/$DATE.jpg  2>/dev/null

python3 -W ignore /home/nvidia/nvme/minifi-jetson-xavier/demo.py --camera /dev/video1 --network googlenet /home/nvidia/nvme/images/$DATE.jpg  2>/dev/null

python3 -W ignore /home/nvidia/nvme/minifi-jetson-xavier/demo.py --camera /dev/video2 --network googlenet /home/nvidia/nvme/images/$DATE.jpg  2>/dev/null
