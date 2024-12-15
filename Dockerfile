FROM nvidia/cuda:12.4.0-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

RUN apt-get update && apt-get install -y \
  git \
  wget \
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

RUN ln -s /usr/bin/python3 /usr/bin/python

RUN useradd -m -u 1000 comfy
RUN mkdir -p /workspace && chown -R comfy:comfy /workspace

USER root

RUN pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu124
RUN pip3 install --no-cache-dir numpy
RUN pip3 install jupyter notebook

WORKDIR /workspace
RUN git clone https://github.com/comfyanonymous/ComfyUI.git
WORKDIR /workspace/ComfyUI
RUN pip3 install -r requirements.txt

RUN mkdir -p /workspace/ComfyUI/models && \
  mkdir -p /workspace/ComfyUI/custom_nodes && \
  mkdir -p /workspace/ComfyUI/user && \
  touch /workspace/ComfyUI/comfyui.log && \
  chown -R comfy:comfy /workspace/ComfyUI

COPY setup-comfy.sh install-extentions.sh /workspace/
RUN chmod +x /workspace/*.sh
RUN chown comfy:comfy /workspace/*.sh

USER comfy
RUN /workspace/setup-comfy.sh
RUN /workspace/install-extentions.sh

# ノートブックディレクトリを作成
RUN mkdir -p /workspace/notebooks && \
  chown -R comfy:comfy /workspace/notebooks

COPY --chown=comfy:comfy notebooks/download-models.ipynb notebooks/run-comfyui.ipynb /workspace/notebooks/


WORKDIR /

EXPOSE 8888

ENTRYPOINT []
# CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]
