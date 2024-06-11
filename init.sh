#!/usr/bin/bash

eval "$(/micromamba shell hook --shell bash)"
micromamba activate /venv

if [[ ! -d /app/ComfyUI/custom_nodes/ComfyUI-Manager ]]; then
  git clone https://github.com/ltdrdata/ComfyUI-Manager /app/ComfyUI/custom_nodes/ComfyUI-Manager
fi

python /app/ComfyUI/main.py --listen "$@"
