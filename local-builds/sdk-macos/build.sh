#!/usr/bin/env zsh

set +o errexit ; set +o pipefail

name=$(basename $(pwd))
version=10.11

echo "$name build of $(date)" > build.log
docker build -t devanyware/builds/$name:$version . | tee -a build.log