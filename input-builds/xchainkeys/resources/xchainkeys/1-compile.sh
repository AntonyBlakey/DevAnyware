#!/usr/bin/env zsh

mkdir build
tar zxf src.tar.gz --strip-components 1 --directory=build
cd build
./configure --prefix=/xchainkeys
make -j8 install 