#!/usr/bin/env zsh

KEY=$(jq -s -r 'add | .[].name' ~/.config/xchainkeys/run-*.json | sort | rofi -dmenu -no-custom -i -p "Run" -lines $(jq -s 'add | length' ~/.config/xchainkeys/run-*.json))
[ -n "$KEY" ] || exit 1

COMMAND=$(jq -s -r 'add | .[] | select(.name == "'$KEY'") | .command' ~/.config/xchainkeys/run-*.json)
eval $COMMAND &