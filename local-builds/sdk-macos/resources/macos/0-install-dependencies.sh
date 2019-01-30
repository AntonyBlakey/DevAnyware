#!/usr/bin/env zsh

apt-get update 
apt-get install -y --no-install-recommends make $(cat /llvm/dependencies) 