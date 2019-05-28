#!/usr/bin/env zsh

mkdir src
tar xf release.tar.gz --strip-components=1 --directory=src
rm *.tar.gz
cd src
git apply /cmake/patches/*
./bootstrap --prefix=/cmake
cat /home/dev/work/src/Bootstrap.cmk/cmake_bootstrap.log
make
make install