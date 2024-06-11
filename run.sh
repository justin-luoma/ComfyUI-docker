#!/usr/bin/env bash

OPTIND=1
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

port=8188
models_path=$(pwd)/models
output_path=$(pwd)/output
input_path=$(pwd)/input
workflows_path=$(pwd)/workflows
docker_extras=""
args=""

function check_path() {
  if [[ ! -d "$1" ]]; then
    echo "$1 does not exist"
    exit 1
  fi
}

function show_help() {
    echo "Usage:"
}

while getopts "h?:p:m:a:o:i:w:d:" opt; do
  case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    p)
        port="$OPTARG"
        ;;
    m)
        models_path="$OPTARG"
        ;;
    a)
        args="$OPTARG"
        ;;
    o)
        output_path="$OPTARG"
        ;;
    i)
        input_path="$OPTARG"
        ;;
    w)
        workflows_path="$OPTARG"
        ;;
    d)
        docker_extras="$OPTARG"
        ;;
  esac
done

shift $((OPTIND - 1))
[ "${1:-}" = "--" ] && shift

echo "port $port"
echo "models_path $models_path"
echo "args $args"

for p in "$models_path" "$output_path" "$input_path" "$workflows_path"; do
    check_path "$p"
done

if [[ "$docker_extras" != "" ]]; then
  docker run \
  -p "$port:8188" \
  -v "${models_path}:/app/ComfUI/models" \
  -v "${output_path}:/app/ComfyUI/output" \
  -v "${input_path}:/app/ComfyUI/input" \
  -v "${workflows_path}:/app/ComfyUI/workflows" \
  -v comfyui_nodes:/app/ComfyUI/custom_nodes \
  --gpus all \
  --name comfyui \
  "$docker_extras" \
  comfyui "$args"
else
  docker run \
    -p "$port:8188" \
    -v "${models_path}:/app/ComfUI/models" \
    -v "${output_path}:/app/ComfyUI/output" \
    -v "${input_path}:/app/ComfyUI/input" \
    -v "${workflows_path}:/app/ComfyUI/workflows" \
    -v comfyui_nodes:/app/ComfyUI/custom_nodes \
    --gpus all \
    --name comfyui \
    comfyui "$args"
fi
