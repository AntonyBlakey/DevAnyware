#!/usr/bin/env zsh

rm -rf /tmp/conan
conan install . -if /tmp/conan/build --profile Windows-x86-Debug 
