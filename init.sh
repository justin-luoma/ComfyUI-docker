#!/usr/bin/bash

eval "$(/micromamba shell hook --shell bash)"
micromamba activate /venv
python /app/ComfyUI/main.py --listen
