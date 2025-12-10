#!/usr/bin/env bash
# Script untuk build & push Docker image backend Karsa Jobs ke GitHub Container Registry (GHCR)

set -euo pipefail

# Nama image lengkap di GHCR
IMAGE="ghcr.io/${GHCR_USERNAME}/karsajobs:latest"

echo "[1] Build image backend Karsa Jobs"
# Perintah build image dari Dockerfile di direktori ini
docker build -t "${IMAGE}" .

echo "[2] Login ke GitHub Container Registry"
# Login menggunakan token yang disimpan di environment variable GHCR_TOKEN
echo "${GHCR_TOKEN}" | docker login ghcr.io -u "${GHCR_USERNAME}" --password-stdin

echo "[3] Push image ke GHCR"
docker push "${IMAGE}"

echo "[DONE] Image backend berhasil di-push ke ${IMAGE}"
