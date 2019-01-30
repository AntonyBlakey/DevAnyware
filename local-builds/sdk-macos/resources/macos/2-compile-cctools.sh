#!/usr/bin/env zsh

curl -s http://files.soops.intern/Software/MacOS/cctools/cctools-895-ld64-274.2_8e9c3f2.tar.xz | xzcat -d -c - | tar xf - -C /macos 

cd /macos/cctools-*/cctools 

for i in /macos/patches/cctools-*.patch ; do
    patch -p0 < $i
done

 ./configure --prefix=/macos --target=x86_64-apple-darwin15
 make
 make install

 rm -rf /macos/cctools-* /macos/patches

 for i in /macos/bin/x86_64-apple-darwin* ; do
    ln -s $i ${i/x86_64/i386}
    ln -s $i ${i/x86_64/x86_64h}
 done