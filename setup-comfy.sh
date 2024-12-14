#!/bin/bash
set -e

cd /workspace/ComfyUI

# 必要なPythonパッケージのインストール
pip3 install --user torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu124
pip3 install --user xformers
pip3 install --user -r requirements.txt

# SageAttentionのセットアップ
cd /workspace
git clone https://github.com/thu-ml/SageAttention.git
cd SageAttention
python3 setup.py install
