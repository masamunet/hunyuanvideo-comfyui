#!/bin/bash
mkdir -p models/clip models/vae models/loras models/checkpoints models/text_encoders models/unet models/controlnet models/upscale_models models/diffusion_models models/LLM

# 必要なモデルをダウンロード
wget -nc -P models/clip https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors
wget -nc -P models/clip https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp16.safetensors
wget -nc -P models/clip https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp8_e4m3fn.safetensors

# hunyuan video
wget -nc -P models/vae https://huggingface.co/Kijai/HunyuanVideo_comfy/resolve/main/hunyuan_video_vae_bf16.safetensors
# wget -nc -P models/vae https://huggingface.co/Kijai/HunyuanVideo_comfy/resolve/main/hunyuan_video_vae_fp32.safetensors
# wget -nc -P models/diffusion_models https://huggingface.co/Kijai/HunyuanVideo_comfy/resolve/main/hunyuan_video_720_cfgdistill_bf16.safetensors
wget -nc -P models/diffusion_models https://huggingface.co/Kijai/HunyuanVideo_comfy/resolve/main/hunyuan_video_720_cfgdistill_fp8_e4m3fn.safetensors

# cd models/clip
# git lfs clone https://huggingface.co/openai/clip-vit-large-patch14
# cd ../LLM
# git lfs clone https://huggingface.co/Kijai/llava-llama-3-8b-text-encoder-tokenizer
