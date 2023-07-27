#!/bin/bash

REGISTRY="icr.io"
NAMESPACE="zmodstack"
REPO="micro3270"
TAG="0.4.0"
IMAGE=$REGISTRY/$NAMESPACE/$REPO:$TAG

# change dir back to git root
cd $(git rev-parse --show-toplevel)

# local (single-architecture) build
# podman build --tag ibm/micro3270 .

# Build and push arm64, amd64, s390x
podman manifest rm ibm/micro3270
podman build --jobs 3 --platform linux/arm64/v8,linux/amd64,linux/s390x --manifest ibm/micro3270 .
podman manifest push ibm/micro3270 docker://$IMAGE