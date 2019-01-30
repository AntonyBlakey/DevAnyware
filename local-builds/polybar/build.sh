#!/usr/bin/env zsh

set +o errexit ; set +o pipefail

name=$(basename $(pwd))

echo "$name build of $(date)" > build.log
docker build -t devanyware/builds/$name . | tee -a build.log