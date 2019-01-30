#!/usr/bin/env zsh

git clone -q --depth=1 --recursive https://github.com/MaskRay/ccls 
cd ccls
cmake -H. -G Ninja -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/ccls -DCMAKE_PREFIX_PATH=/llvm
cmake --build Release --target install