# Hunyuanvideo ComfyUI

ComfyUIを使用してHunyuan Videoモデルを実行するためのDocker環境です。

## 機能

- JupyterLabインターフェイス (port: 8888)
- ComfyUIインターフェイス (port: 8188)
- NVIDIA GPUサポート
- Hunyuan Videoモデルの自動ダウンロード

## 使用方法

1. JupyterLabにアクセス (http://localhost:8888)
2. `notebooks/download-models.ipynb` を実行してモデルをダウンロード
3. ComfyUIを起動して使用開始

## ポート

- 8888: JupyterLabインターフェイス
- 8188: ComfyUIインターフェイス

## 注意事項

- 初回起動時は必要なモデルのダウンロードが必要です
- GPUメモリ使用量に注意してください
- .env.exampleを参考に .envファイルを作成。Dockerhubのユーザー名を設定してください
