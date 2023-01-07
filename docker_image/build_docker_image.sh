#!/bin/bash -f
export IMAGE="ghcr.io/mabrains/pdk_regression"
docker build -t $IMAGE .

