#!/bin/bash -f
export IMAGE="ghcr.io/mabrains/ubuntu_with_libraries_base"
docker build -t $IMAGE .

