FROM masamunet/runpod-comfyui

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  cmake \
  wget \
  ffmpeg \
  libsm6 \
  libxext6 \
  libavutil-dev \
  libavcodec-dev \
  libavformat-dev \
  libswscale-dev \
  liblapack-dev \
  libeigen3-dev \
  nginx \
  openssh-server \
  git-lfs \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean \
  && git lfs install

WORKDIR /workspace_tmp

COPY entrypoint.sh setup-comfy.sh install-extentions.sh setup_sageAttention.sh README.md runpod.yaml /
RUN chmod +x /*.sh \
  && /setup-comfy.sh \
  && /install-extentions.sh

COPY notebooks/download-models_wrapper.ipynb notebooks/download-models_official.ipynb notebooks/setup_sageattention.ipynb /workspace_tmp/
RUN chmod 644 /workspace_tmp/download-models_wrapper.ipynb /workspace_tmp/download-models_official.ipynb /workspace_tmp/setup_sageattention.ipynb

WORKDIR /workspace

EXPOSE 8888 8188

ENTRYPOINT ["/entrypoint.sh"]
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''", "--no-browser", "--ServerApp.allow_origin=*", "--ServerApp.allow_remote_access=True", "--notebook-dir=/workspace"]
