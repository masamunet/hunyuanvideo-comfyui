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
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean

WORKDIR /workspace

COPY setup-comfy.sh install-extentions.sh README.md /
RUN chmod +x /*.sh \
  && /setup-comfy.sh \
  && /install-extentions.sh

COPY notebooks/download-models.ipynb /workspace/

WORKDIR /workspace

EXPOSE 8888 8188

ENTRYPOINT []
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''", "--no-browser", "--ServerApp.allow_origin=*", "--ServerApp.allow_remote_access=True", "--notebook-dir=/workspace"]
