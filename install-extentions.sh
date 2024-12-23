#!/bin/bash

# ディレクトリを移動
cd /workspace_tmp/ComfyUI/custom_nodes

# 拡張機能をインストール
git clone https://github.com/kijai/ComfyUI-HunyuanVideoWrapper
git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite
git clone https://github.com/NUS-HPC-AI-Lab/Enhance-A-Video

cd /workspace_tmp/ComfyUI/custom_nodes/ComfyUI-HunyuanVideoWrapper
pip install -r requirements.txt

cd /workspace_tmp/ComfyUI/custom_nodes/ComfyUI-VideoHelperSuite
pip install -r requirements.txt

cd /workspace_tmp/ComfyUI/custom_nodes/Enhance-A-Video
pip install -r requirements.txt



# GGUF Loaderのインストール
cd /workspace_tmp/ComfyUI/custom_nodes
git clone https://github.com/city96/ComfyUI-GGUF.git
cd ComfyUI-GGUF
pip install -r requirements.txt
