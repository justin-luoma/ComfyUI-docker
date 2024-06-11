# Info
CUDA version: 12.4.1

## Instructions
if your CUDA doesn't match, update the `FROM` line in [Dockerfile](Dockerfile) based on tags from [here](https://hub.docker.com/r/nvidia/cuda)

# Usage
```
docker build -t comfyui .
docker run -d --name comfui --gpus all -p "8188:8188" -v "/path/to/models:/app/ComfyUI/models" comfyui
```