#!/usr/bin/bash


if [[ ! -d /app/ComfyUI/custom_nodes/ComfyUI-Manager ]]; then
  git clone https://github.com/ltdrdata/ComfyUI-Manager /app/ComfyUI/custom_nodes/ComfyUI-Manager
fi

if [[ ! -d /app/venv/bin ]]; then
  mv /venv/* /app/venv/
fi

eval "$(/micromamba shell hook --shell bash)"
micromamba activate /app/venv
python /app/ComfyUI/main.py --listen "$@"
