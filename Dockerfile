FROM nvidia/cuda:12.4.0-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

RUN apt-get update && apt-get install -y --no-install-recommends \
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
  nginx \
  openssh-server \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean

RUN ln -s /usr/bin/python3 /usr/bin/python

RUN useradd -m -u 1000 comfy
RUN mkdir -p /workspace && chown -R comfy:comfy /workspace

USER root

RUN pip3 install --no-cache-dir \
  torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu124 \
  numpy \
  jupyter \
  jupyterlab \
  "notebook<7.0.0" \
  jupyter_contrib_nbextensions \
  jupyter_nbextensions_configurator \
  ipywidgets

RUN jupyter contrib nbextension install --system && \
  jupyter nbextension enable --system widgetsnbextension

WORKDIR /workspace
RUN git clone https://github.com/comfyanonymous/ComfyUI.git
WORKDIR /workspace/ComfyUI
RUN pip3 install --no-cache-dir -r requirements.txt

RUN mkdir -p /workspace/ComfyUI/models \
  /workspace/ComfyUI/custom_nodes \
  /workspace/ComfyUI/user \
  && touch /workspace/ComfyUI/comfyui.log \
  && chown -R comfy:comfy /workspace/ComfyUI

COPY setup-comfy.sh install-extentions.sh /
RUN chmod +x /*.sh && \
  chown comfy:comfy /*.sh

USER comfy
RUN /setup-comfy.sh && \
  /install-extentions.sh

COPY --chown=comfy:comfy notebooks/download-models.ipynb notebooks/run-comfyui.ipynb /workspace/
COPY runpod.yaml /

WORKDIR /workspace

EXPOSE 8888 8188

ENTRYPOINT []
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]
