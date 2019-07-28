#!/usr/bin/env zsh

set +o errexit ; set +o pipefail

echo "START" 

inputs=(base llvm cmake ccls sdk-windows sdk-macos polybar)

for input in $inputs ; do 
    (cd inputs/$input && ./build.sh)
done

docker_modules=(base x11 xmonad elixir haskell java go pandoc racket sbcl c python conan neovim javascript clojurescript rust)
previous_docker_module='ubuntu:19.04'

for docker_module in $docker_modules ; do
    name=devanyware/$docker_module
    ./build-from-modules.sh $name $previous_docker_module $docker_module
    previous_docker_module=$name
done

docker tag $previous_docker_module devanyware/full

echo "FINISH"