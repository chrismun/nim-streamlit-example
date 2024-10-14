export NGC_API_KEY=<YOUR API KEY FROM build.nvidia.com, it should look like nvapi-.... > 

# update cache if you'd like
export LOCAL_NIM_CACHE=~/.cache/nim
mkdir -p "$LOCAL_NIM_CACHE"

docker run --rm \
    --gpus '"device=0,1"' \
    --shm-size=16GB \
    -e NGC_API_KEY \
    -v "$LOCAL_NIM_CACHE:/opt/nim/.cache" \
    -u $(id -u) \
    -p 8000:8000 \
    -e NIM_MODEL_PROFILE="tensorrt_llm-a100-fp16-tp2-latency" \
    nvcr.io/nim/nv-mistralai/mistral-nemo-12b-instruct:latest 
