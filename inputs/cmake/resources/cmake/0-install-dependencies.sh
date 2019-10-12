#!/usr/bin/env zsh

apt-get update
apt-get install -y --no-install-recommends make libssl-dev $(cat /llvm/dependencies)