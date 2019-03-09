#!/usr/bin/env zsh

code --install-extension rust-lang.rust

TEMP=$(mktemp)
SETTINGS='/home/dev/.config/Code/User/settings.json'
cp $SETTINGS $TEMP
cat <<EOF | jq -s '.[0] * .[1]' - $TEMP > $SETTINGS
{
    "rust-client.channel": "nightly"
}
EOF
rm $TEMP