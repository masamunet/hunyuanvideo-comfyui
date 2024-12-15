#!/bin/bash

# ディレクトリを移動
cd /workspace/ComfyUI/custom_nodes

# 拡張機能をインストール
git clone https://github.com/kijai/ComfyUI-HunyuanVideoWrapper
git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite

cd /workspace/ComfyUI/custom_nodes/ComfyUI-HunyuanVideoWrapper
pip install -r requirements.txt

cd /workspace/ComfyUI/custom_nodes/ComfyUI-VideoHelperSuite
pip install -r requirements.txt
