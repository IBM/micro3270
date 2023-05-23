#!/bin/bash

git clone https://github.com/pmattes/x3270.git -b 4.2ga9 /src/x3270
cd /src/x3270

# Following build guides from the following sources
#   - https://x3270.miraheze.org/wiki/Build/Linux
#   - https://x3270.miraheze.org/wiki/Build/configure
#   - https://x3270.miraheze.org/wiki/Build/make
./configure --enable-c3270
make c3270
# [TODO] make test
make install