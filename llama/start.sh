#!/usr/bin/env sh

podman run --rm -d -p 8080:8080 --gpus all -e HF_HOME=/models -v /srv/data/llama/models:/models ghcr.io/ggml-org/llama.cpp:server-cuda -hf mistralai/Ministral-3-3B-Instruct-2512-GGUF:Q4_K_M -c 16384 -ngl 18
