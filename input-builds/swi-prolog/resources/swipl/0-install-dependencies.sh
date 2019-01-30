#!/usr/bin/env zsh

apt-get update 
apt-get install -y --no-install-recommends $(cat /llvm/dependencies) $(cat /swipl/dependencies) $(cat /swipl/build-dependencies) 