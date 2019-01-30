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
    input-builds/xchainkeys
    input-builds/i3-gaps
    input-builds/polybar
    input-builds/wmfocus
    input-builds/swi-prolog
    base
)

for i in $images ; do 
    pushd $i && ./build.sh && popd
done