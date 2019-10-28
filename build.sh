#!/usr/bin/env zsh

set +o errexit ; set +o pipefail

echo "START" 

inputs=(base llvm cmake sdk-windows sdk-macos polybar)

for input in $inputs ; do 
    (cd inputs/$input && ./build.sh)
done

version_major=1
version=${version_major}.0.0

previous_docker_module='ubuntu:19.04'

# UI
docker_modules=(base x11 haskell xmonad)
for docker_module in $docker_modules ; do
    name=devanyware/module/$docker_module
    ./build-from-modules.sh $name $previous_docker_module $docker_module
    previous_docker_module=$name
done

docker tag ${previous_docker_module} devanyware/ui:${version}
docker tag ${previous_docker_module} devanyware/ui:${version_major}
docker tag ${previous_docker_module} devanyware/ui:latest

# Minimal
docker_modules=(c python conan javascript rust)
for docker_module in $docker_modules ; do
    name=devanyware/module/$docker_module
    ./build-from-modules.sh $name $previous_docker_module $docker_module
    previous_docker_module=$name
done

docker tag ${previous_docker_module} devanyware/minimal:${version}
docker tag ${previous_docker_module} devanyware/minimal:${version_major}
docker tag ${previous_docker_module} devanyware/minimal:latest

# Full
docker_modules=(java neovim elixir go racket sbcl pandoc clojurescript)
for docker_module in $docker_modules ; do
    name=devanyware/module/$docker_module
    ./build-from-modules.sh $name $previous_docker_module $docker_module
    previous_docker_module=$name
done

docker tag $previous_docker_module devanyware/full:${version}
docker tag $previous_docker_module devanyware/full:${version_major}
docker tag $previous_docker_module devanyware/full:latest

echo "FINISH"