#!/usr/bin/env zsh

git clone https://github.com/llvm/llvm-project.git --branch llvmorg-8.0.0 --depth 1
mkdir llvm-project/build
pushd llvm-project/build
cmake ../llvm -G Ninja \
    -DLLVM_ENABLE_PROJECTS='clang;libcxx;libcxxabi;libunwind;lldb;compiler-rt;lld' \
    -DCMAKE_INSTALL_PREFIX=/llvm \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_TARGETS_TO_BUILD=X86
cmake --build . --target install
popd
rm -rf llvm-project

ln -s /llvm/bin/clang /llvm/bin/cc