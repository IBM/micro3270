#!/bin/bash

# change dir back to git root
cd $(git rev-parse --show-toplevel)

# Build and push arm64, amd64, s390x
docker buildx build --push --platform linux/arm64/v8,linux/amd64,linux/s390x --tag icr.io/zmodstack/micro3270:latest .