version="3.2.18-36497"
docker buildx build --progress=plain --platform linux/amd64,linux/arm64 -t "linyuchen/qq:$version" -t "linyuchen/qq:latest" -f Dockerfile --push .