#!/usr/bin/env zsh

code --install-extension rust-lang.rust
code --install-extension bungcip.better-toml

TEMP=$(mktemp)
SETTINGS='/home/dev/.config/Code/User/settings.json'
cp $SETTINGS $TEMP
echo '{"rust-client.channel": "'${DEVANYWARE_RUST_TOOLCHAIN}'", "rust.all_targets": false }' | jq -s '.[0] * .[1]' - $TEMP > $SETTINGS
rm $TEMP