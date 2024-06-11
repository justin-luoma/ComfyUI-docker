# Usage
```
docker build -t comfyui .
docker run -d --name comfui --gpus all -p "8188:8188" -v "/path/to/models:/app/ComfyUI/models" comfyui
```