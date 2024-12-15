#!/bin/bash
set -e

cd /workspace/ComfyUI

# SageAttentionのセットアップ
cd /workspace
pip install -U bitsandbytes
pip install "triton>=2.3.0"
pip install -U sageattention
# git clone https://github.com/thu-ml/SageAttention.git
# cd SageAttention
# python3 setup.py install
