#!/bin/bash

cd /workspace

./download-models.sh
./install-extentions.sh
./setup-comfy.sh

# ComfyUIのディレクトリに移動
cd /workspace/ComfyUI

# コマンドライン引数を実行
exec "$@"
