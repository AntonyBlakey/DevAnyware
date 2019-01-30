#!/usr/bin/env zsh

set +o errexit ; set +o pipefail

# Make sure to keep the ordering right
images=(
    local-builds/base
    local-builds/llvm
    local-builds/cmake
    local-builds/ccls
    local-builds/sdk-windows
    local-builds/sdk-macos
    local-builds/xchainkeys
    local-builds/i3-gaps
    local-builds/polybar
    local-builds/wmfocus
    local-builds/swi-prolog
    base
)

for i in $images ; do 
    pushd $i && ./build.sh && popd
done