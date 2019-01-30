#!/usr/bin/env zsh

apt-get update
apt-get install -y --no-install-recommends \
    pkg-config libgtk-3-dev libxcb-keysyms1-dev \
    $(cat /llvm/dependencies) $(cat /wmfocus/dependencies)

curl https://sh.rustup.rs -sSf | sh -s -- -y
echo "source $HOME/.cargo/env" >> /etc/zsh/zshenv