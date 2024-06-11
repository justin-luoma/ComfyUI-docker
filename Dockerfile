FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04

SHELL ["bash", "-c"]

RUN apt update

RUN apt install curl git bzip2 ffmpeg -y

RUN curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba -C /

RUN cp bin/micromamba /

RUN /micromamba create -p /venv python=3.11 -y -c conda-forge

WORKDIR /app

RUN git clone https://github.com/comfyanonymous/ComfyUI && cd ComfyUI

RUN /micromamba -p /venv run pip install torch torchvision torchaudio

RUN /micromamba -p /venv run pip install -r /app/ComfyUI/requirements.txt

WORKDIR /app/ComfyUI/custom_nodes/

RUN git clone https://github.com/ltdrdata/ComfyUI-Manager

WORKDIR /

COPY init.sh /init.sh

RUN chmod +x /init.sh

ENTRYPOINT ["/init.sh"]
