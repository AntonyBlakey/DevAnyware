#!/usr/bin/env zsh

apt-get update
apt-get install -y --no-install-recommends \
    git ninja-build \
    zlib1g-dev ncurses-dev \
    $(cat /llvm/dependencies) \
    $(cat /cmake/dependencies) \
    $(cat /ccls/dependencies)