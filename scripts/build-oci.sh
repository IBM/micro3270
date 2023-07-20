#!/bin/bash

REGISTRY="icr.io"
NAMESPACE="zmodstack"
REPO="micro3270"
TAG="0.4.0-rc.1"
IMAGE=$REGISTRY/$NAMESPACE/$REPO:$TAG

# change dir back to git root
cd $(git rev-parse --show-toplevel)

# Build and push arm64, amd64, s390x
podman build --jobs 3 --platform linux/arm64/v8,linux/amd64,linux/s390x --manifest ibm/micro3270 .
podman manifest push ibm/micro3270 docker://$IMAGE
