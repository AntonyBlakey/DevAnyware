#!/usr/bin/env zsh

apt-get update
apt-get install -y --no-install-recommends \
    git ninja-build pkg-config \
    $(cat /llvm/dependencies) \
    $(cat /cmake/dependencies) \
    $(cat /polybar/dependencies)