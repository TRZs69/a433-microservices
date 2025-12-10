#!/usr/bin/env bash
# Script untuk build & push Docker image frontend Karsa Jobs UI ke GHCR

set -euo pipefail

IMAGE="ghcr.io/${GHCR_USERNAME}/karsajobs-ui:latest"

echo "[1] Build image frontend Karsa Jobs UI"
docker build -t "${IMAGE}" .

echo "[2] Login ke GitHub Container Registry"
echo "${GHCR_TOKEN}" | docker login ghcr.io -u "${GHCR_USERNAME}" --password-stdin

echo "[3] Push image ke GHCR"
docker push "${IMAGE}"

echo "[DONE] Image frontend berhasil di-push ke ${IMAGE}"
