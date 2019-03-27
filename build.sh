#!/usr/bin/env zsh

set +o errexit ; set +o pipefail

# Make sure to keep the ordering right
images=(
    input-builds/base
    input-builds/llvm
    input-builds/cmake
    input-builds/ccls
    input-builds/sdk-windows
    input-builds/sdk-macos
    input-builds/polybar
    base
)

for i in $images ; do 
    pushd $i && ./build.sh && popd
done