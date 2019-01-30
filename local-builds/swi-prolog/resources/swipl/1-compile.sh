#!/usr/bin/env zsh

mkdir /tmp/src
curl -s http://www.swi-prolog.org/download/devel/src/swipl-7.7.25.tar.gz | tar -zx --strip-components=1 --directory=/tmp/src
mkdir /tmp/build
cd /tmp/build
cmake -DCMAKE_BUILD_TYPE=Release -DSWIPL_PACKAGES_X=OFF -DSWIPL_PACKAGES_JAVA=OFF -DCMAKE_INSTALL_PREFIX=/swipl /tmp/src
make
make install