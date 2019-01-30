#!/usr/bin/env zsh

mkdir src
tar -zxf src.tar.gz --strip-components=1 --directory=src
cd src
autoreconf --force --install
mkdir build
cd build
../configure --prefix=/i3-gaps --sysconfdir=/i3-gaps/etc --disable-sanitizers
make -j8 install