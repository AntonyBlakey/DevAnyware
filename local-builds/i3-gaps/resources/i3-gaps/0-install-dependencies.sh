#!/usr/bin/env zsh

apt-get update
apt-get install -y --no-install-recommends make autoconf automake $(cat /llvm/dependencies) $(cat /i3-gaps/dependencies)