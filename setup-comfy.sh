#!/bin/bash

pip install onnxruntime
pip install triton==2.1.0
pip install opencv-python-headless
pip install bitsandbytes

# ffmpeg
apt install ffmpeg -y

# SageAttention
git clone https://github.com/thu-ml/SageAttention.git
cd SageAttention
python setup.py install
