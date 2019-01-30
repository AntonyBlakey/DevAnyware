#!/usr/bin/env zsh

set -o errexit

for arch in x86 x86_64 ; do
    for build in Release ; do
        conan create . soops/stable --profile MacOS-$arch-$build
    done
done