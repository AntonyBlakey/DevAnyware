#!/usr/bin/env zsh

set +o errexit ; set +o pipefail

echo "START" \
\
&& pushd inputs/base        && ./build.sh && popd \
&& pushd inputs/llvm        && ./build.sh && popd \
&& pushd inputs/cmake       && ./build.sh && popd \
&& pushd inputs/ccls        && ./build.sh && popd \
&& pushd inputs/sdk-windows && ./build.sh && popd \
&& pushd inputs/sdk-macos   && ./build.sh && popd \
&& pushd inputs/polybar     && ./build.sh && popd \
\
&& ./build-from-modules.sh devanyware/base        ubuntu:19.04           base x11 xmonad    \
&& ./build-from-modules.sh devanyware/dev-base    devanyware/base        rust neovim vscode \
&& ./build-from-modules.sh devanyware/dev-c       devanyware/dev-base    c python conan     \
&& ./build-from-modules.sh devanyware/dev-web     devanyware/dev-base    javascript markup  \
&& ./build-from-modules.sh devanyware/dev-full    devanyware/dev-c       javascript markup  \
\
&& echo "FINISH"

# && ./build-from-modules.sh devanyware/dev-extra devanyware/dev-full elixir java lisp reason go haskell \