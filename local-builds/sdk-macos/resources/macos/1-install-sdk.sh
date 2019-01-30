#!/usr/bin/env zsh

curl -s --insecure http://files.soops.intern/Software/MacOS/osxcross/MacOSX10.11.sdk.tar.xz | xzcat -d -c - | tar xf - -C /macos 

for i in /macos/MacOSX10.11.sdk/System/Library/Frameworks/Kernel.framework/Versions/A/Headers/std*.h ; do
    ln -s $i /macos/MacOSX10.11.sdk/usr/include/ || true
done

ln -s /macos/include/float.h /macos/MacOSX10.11.sdk/usr/include/ || true