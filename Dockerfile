FROM nvidia/cuda:12.4.0-runtime-ubuntu22.04

RUN apt-get update && apt-get install -y \
  git \
  python3 \
  python3-pip \
  python3-venv \
  ffmpeg \
  libsm6 \
  libxext6 \
  libavutil-dev \
  libavcodec-dev \
  libavformat-dev \
  libswscale-dev \
  libopenblas-dev \
  && rm -rf /var/lib/apt/lists/*

RUN pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu124

RUN pip install --no-cache-dir numpy

WORKDIR /workspace
RUN git clone https://github.com/comfyanonymous/ComfyUI.git


WORKDIR /workspace/ComfyUI
RUN pip install -r requirements.txt

WORKDIR /workspace/ComfyUI/custom_nodes
RUN git clone https://github.com/ltdrdata/ComfyUI-Manager.git && \
  git clone https://github.com/11cafe/comfyui-workspace-manager.git

WORKDIR /workspace/ComfyUI

# entrypointスクリプトを追加
COPY --chown=comfy:comfy entrypoint.sh /workspace/
RUN chmod +x /workspace/entrypoint.sh

EXPOSE 8188

ENTRYPOINT ["/workspace/entrypoint.sh"]
CMD ["python3", "main.py"]
