#!/usr/bin/env zsh

mkdir wmfocus
tar -zxf wmfocus.tar.gz --strip-components=1 --directory=wmfocus
cd wmfocus
cargo install --features i3 wmfocus
mkdir /wmfocus/bin
cp ~/.cargo/bin/wmfocus /wmfocus/bin/