#!/usr/bin/env zsh

rm -rf /tmp/conan
conan install . -if /tmp/conan/build --profile Linux-x86_64-Release 
