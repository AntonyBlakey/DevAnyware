#!/usr/bin/env zsh

git clone -q --recursive https://github.com/jaagr/polybar -b 3.3.0
mkdir build
cd build
cmake -G Ninja -DCMAKE_INSTALL_PREFIX=/polybar -DCMAKE_CXX_FLAGS=-Wno-defaulted-function-deleted ../polybar
ninja install