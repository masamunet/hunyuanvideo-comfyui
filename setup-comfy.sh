#!/bin/bash
set -e

# SageAttentionのセットアップ
pip install -U bitsandbytes
pip install "triton>=2.3.0"
# のこりはホスト側でコンパイルする
