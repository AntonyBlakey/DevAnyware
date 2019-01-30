#!/usr/bin/env zsh

export BRANCH=release_80

curl -s -L --insecure https://codeload.github.com/llvm-mirror/llvm/tar.gz/${BRANCH} -o llvm-${BRANCH}.tar.gz
curl -s -L --insecure https://codeload.github.com/llvm-mirror/clang/tar.gz/${BRANCH} -o clang-${BRANCH}.tar.gz
curl -s -L --insecure https://codeload.github.com/llvm-mirror/lld/tar.gz/${BRANCH} -o lld-${BRANCH}.tar.gz

mkdir /llvm/src
tar -zxf llvm-${BRANCH}.tar.gz --strip-components=1 --directory=/llvm/src
mkdir /llvm/src/tools/clang
tar -zxf clang-${BRANCH}.tar.gz --strip-components=1 --directory=/llvm/src/tools/clang
mkdir /llvm/src/tools/lld
tar -zxf lld-${BRANCH}.tar.gz --strip-components=1 --directory=/llvm/src/tools/lld
rm *.tar.gz

mkdir /llvm/build
cd /llvm/build
cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/llvm -DLLVM_TARGETS_TO_BUILD=X86 /llvm/src
cmake --build . --target install
ln -s /llvm/bin/clang /llvm/bin/cc
rm -rf /llvm/src /llvm/build