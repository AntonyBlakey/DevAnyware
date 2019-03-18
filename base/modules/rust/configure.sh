#!/usr/bin/env zsh

code --install-extension rust-lang.rust
code --install-extension bungcip.better-toml

TEMP=$(mktemp)
SETTINGS='/home/dev/.config/Code/User/settings.json'
cp $SETTINGS $TEMP
cat <<EOF | jq -s '.[0] * .[1]' - $TEMP > $SETTINGS
{
    "rust-client.channel": "nightly-2019-03-15"
}
EOF
rm $TEMP