#!/bin/bash
# Script untuk build dan push Docker image item-app ke GitHub Packages (GitHub Container Registry)

# Hentikan eksekusi jika ada perintah yang gagal
set -e

# Nama image lokal yang akan dibuild dari Dockerfile
LOCAL_IMAGE_NAME="item-app:v1"

# Nama image di GitHub Container Registry (GHCR)
# Format: ghcr.io/<username_github>/item-app:v1
GITHUB_USERNAME="${GITHUB_USERNAME:-trzs69}"
GHCR_IMAGE="ghcr.io/${GITHUB_USERNAME}/item-app:v1"

echo "===> Build image lokal ${LOCAL_IMAGE_NAME} dari Dockerfile ..."
# 1. Build Docker image dengan tag lokal item-app:v1
docker build -t "${LOCAL_IMAGE_NAME}" .

echo "===> Daftar image lokal (untuk memastikan image sudah terbuat) ..."
# 2. Tampilkan daftar image di lokal
docker images

echo "===> Tag image lokal menjadi ${GHCR_IMAGE} ..."
# 3. Tag image lokal menjadi nama image di GHCR
docker tag "${LOCAL_IMAGE_NAME}" "${GHCR_IMAGE}"

echo "===> Login ke GitHub Container Registry (ghcr.io) ..."
# 4. Login ke GitHub Container Registry menggunakan token dari environment variable
echo "$GITHUB_TOKEN" | docker login ghcr.io -u "$GITHUB_USERNAME" --password-stdin

echo "===> Push image ke GitHub Packages (GHCR) ..."
# 5. Push image ke GitHub Packages
docker push "${GHCR_IMAGE}"

echo "===> Selesai. Image berhasil dipush ke ${GHCR_IMAGE}"

