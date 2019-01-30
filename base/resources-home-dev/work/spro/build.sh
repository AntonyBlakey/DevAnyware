#!/usr/bin/env zsh

set +o errexit ; set +o pipefail

pushd ${0:h}

pushd zlib && conan-create-Linux.sh && popd
pushd libffi && conan-create-Linux.sh && popd
pushd visualworks-vm && conan-prep-Linux-x86-Release.sh && conan-build.sh && popd

popd